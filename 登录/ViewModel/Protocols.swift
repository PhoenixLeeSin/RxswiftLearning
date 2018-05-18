//
//  Protocols.swift
//  CrewLogger
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

import RxSwift
import RxCocoa

enum ValidationResult {
    case ok(message:String)
    case empty
    case validating
    case failed(message:String)
}
enum SigninState {
    case signingIn(signing:Bool)
    case signedIn(signedIn:Bool)
}
protocol CrewLogAPI {
    func sign(_ username:String, password:String) -> Observable<Bool>
}
protocol SignInValidationService  {
    func validateUsername(_ username:String) -> Observable<ValidationResult>
    func validatePassword(_ password:String) -> ValidationResult
}

extension ValidationResult{
    var isValid:Bool{
        switch self{
        case .ok:
            return true
        default:
            return false
        }
    }
}
