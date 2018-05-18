//
//  User.swift
//  CrewLogger
//
//  Created by apple on 2018/4/28.
//  Copyright © 2018年 apple. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object{
    @objc dynamic var username:String = ""
    @objc dynamic var password:String = ""
    
  class  func tetxToModelWith(_ username:String,_ password:String)->User{
        let user = User()
        user.username = "RY"+username
        user.password = password
        return user
    }
}
