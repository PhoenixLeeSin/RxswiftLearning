//
//  NetWorkState.swift
//  EFB
//
//  Created by apple on 2017/1/18.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
import Reachability

class NetWorkState: NSObject {
    static func isReachable() -> Bool {
        if let reachability = Reachability() {
            if reachability.connection == .wifi || reachability.connection == .cellular{
                return true
            }
        }
        return false
    }    
}
