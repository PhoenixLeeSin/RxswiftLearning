//
//  LoginService.swift
//  CrewLogger
//
//  Created by apple on 2018/4/26.
//  Copyright © 2018年 apple. All rights reserved.
//

import Foundation
import RxSwift

class LoginService: SignInValidationService {
  
    let usernameStringLength = 7 //最少字符串长度
    
    static let shareInstance = LoginService()
    init() {}
    func validateUsername(_ username: String) -> Observable<ValidationResult> {
        if username.isEmpty{
            return .just(.empty)
        }
        if self.isPureInt(username)&&username.count == 7{
            return .just(.ok(message:"正确啦~~"))
        }
        else{
           return .just(.failed(message:"账户名必须为7位数字"))
        }
        
    }
    func validatePassword(_ password: String) -> ValidationResult {
        if password.isEmpty{
            return .failed(message: "")
        }else{
           return .ok(message: "")
        }        
    }
    
    
    ///判断字符串是否全部是数字
    func isPureInt(_ string:String)->Bool{
        let scan = Scanner(string: string)
        var start:Int32 = 0
        return scan.scanInt32(&start)&&scan.isAtEnd
    }
}
class CrewLogDefaultAPI: CrewLogAPI {
    static let shareInstance = CrewLogDefaultAPI()
    
    func sign(_ username: String, password: String) -> Observable<Bool> {
        let signInResult = arc4random() % 5 == 0 ? false : true
        return Observable.just(signInResult)
                 .delay(1, scheduler: MainScheduler.instance)
    }
}

