//
//  LoginViewController.swift
//  CrewLogger
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameOutlet: UITextField!
    
    @IBOutlet weak var usernameValidationOutlet: UILabel!
    
    @IBOutlet weak var passwordOutlet: UITextField!
    
    @IBOutlet weak var signinOutlet: UIButton!
    
    @IBOutlet weak var signingOutlet: UIActivityIndicatorView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameOutlet.layer.cornerRadius = 6
        usernameOutlet.clipsToBounds = true
        passwordOutlet.layer.cornerRadius = 6
        passwordOutlet.clipsToBounds = true
        
        let viewModel = LoginViewModel.init(input: (usernameOutlet.rx.text.orEmpty.asObservable(),
                                                    password: passwordOutlet.rx.text.orEmpty.asObservable(),
                                                    loginTap: signinOutlet.rx.tap.asObservable()
                                           ),
                                            dependency: (
                                                API:CrewLogDefaultAPI.shareInstance,
                                                LoginService.shareInstance)
                                          )
        
        viewModel.validatedUsername
                 .bind(to: usernameValidationOutlet.rx.validationResult)
                 .disposed(by: disposeBag)
        
        viewModel.signInEnabled
            .subscribe(onNext: { [weak self] valid in
                self?.signinOutlet.isEnabled = valid
                self?.signinOutlet.alpha = valid ? 1.0 : 0.5
            })
            .disposed(by:disposeBag)
        
        viewModel.signingIn
                 .bind(to: signingOutlet.rx.isAnimating)
                 .disposed(by: disposeBag)
        
        viewModel.signedIn
            .subscribe(onNext: { [weak self] _ in
                //
                let realm = try! Realm(configuration: RealmConfiguration.shareInstance.setDefaultRealmForUser())
                try! realm.write {
                    print(realm.configuration.fileURL!)
                    realm.deleteAll()
                }
                if let username = self?.usernameOutlet.text, let password = self?.passwordOutlet.text{
                   try! realm.write {
                       realm.add(User.tetxToModelWith(username, password))
                    }
                }
                let vc = CrewViewController()
                let nav = UINavigationController.init(rootViewController: vc)
                self?.navigationController?.present(nav, animated: true, completion: nil)
            })
            .disposed(by:disposeBag)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()}
}
