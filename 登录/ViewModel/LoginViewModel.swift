//
//  LoginViewModel.swift
//  CrewLogger
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

import RxSwift
import RxCocoa

class LoginViewModel {
    
    let validatedUsername:Observable<ValidationResult>
    let validatedPassword:Observable<ValidationResult>
    let signInEnabled:Observable<Bool>  /// 登录按钮是否可用
    let signingIn:Observable<Bool>      ///登录中小菊花
    let signedIn:Observable<Bool>       ///登录按钮的点击
    
    init(input:(
                username:Observable<String>,
                password:Observable<String>,
                loginTap:Observable<Void>
        ),
         dependency:(
                API:CrewLogAPI,
                validationService:SignInValidationService
        )
    ){
        let API = dependency.API
        let validationService = dependency.validationService
        ///
        validatedUsername = input.username
            .flatMapLatest{ username in
               return   validationService.validateUsername(username)
                        .observeOn(MainScheduler.instance)
                .catchErrorJustReturn(.failed(message:"位置错误"))
        }
        ///
        validatedPassword = input.password
            .map{ password in
               return validationService.validatePassword(password)
        }
            .share(replay: 1, scope: SubjectLifetimeScope.forever)
        
        ///登录中
        let signInIndicator = ActivityIndicator()
        self.signingIn = signInIndicator.asObservable()
        
        ///
        let usernameAndPassword = Observable.combineLatest(input.username,input.password) {(username:$0,password:$1
            )
            
        }
        signedIn = input.loginTap.withLatestFrom(usernameAndPassword)
            .flatMapLatest{ pair in
                return  API.sign(pair.username, password: pair.password)
                        .observeOn(MainScheduler.instance)                    
                        .trackActivity(signInIndicator)
                        .catchErrorJustReturn(false)
            }
            .flatMapLatest{ loggedIn -> Observable<Bool> in
                return Observable.just(true)
                                 .delay(1, scheduler: MainScheduler.instance)
       }
        .share(replay: 1, scope: SubjectLifetimeScope.forever)
        
        ///登录按钮是否可用
        signInEnabled = Observable.combineLatest(validatedUsername,validatedPassword,signInIndicator.asObservable())
        { (username,password,signInIndicator)   in
            username.isValid && password.isValid && !signInIndicator
            }
            .distinctUntilChanged()
            .share(replay: 1, scope: SubjectLifetimeScope.forever)
        
        
    }

    
}
