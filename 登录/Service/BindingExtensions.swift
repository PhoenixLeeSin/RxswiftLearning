//
//  BindingExtensions.swift
//  CrewLogger
//
//  Created by apple on 2018/4/26.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension ValidationResult:CustomStringConvertible {
    var description:String {
        switch self {
        case let .ok(message):
            return message
        case .empty:
            return ""
        case let .failed(message):
            return message
        case .validating:
            return "validating ..."
        }
    }
}
struct ValidationColors {
    static let okColor = UIColor(red: 138.0 / 255.0, green: 221.0 / 255.0, blue: 109.0 / 255.0, alpha: 1.0)
    static let errorColor = UIColor.red
}

extension ValidationResult  {
    var textColor:UIColor {
        switch self {
        case .ok:
            return ValidationColors.okColor
        case .empty:
            return UIColor.black
        case .validating:
            return UIColor.black
        case .failed:
            return ValidationColors.errorColor
        }
    }
}
extension Reactive where Base:UILabel{
    var validationResult:Binder<ValidationResult> {
        return Binder(base) {label,result in
            label.textColor = result.textColor
            label.text = result.description
        }
    }
}















