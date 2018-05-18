//
//  ColorWithString.swift
//  EFBTEST
//
//  Created by apple on 2016/12/30.
//  Copyright © 2016年 Mac. All rights reserved.
//

import Foundation
import UIKit
    
    // MARK:- 把#ffffff颜色转为UIColor
    func kRGBColorFromHex(rgbValue: Int) -> (UIColor) {
        
        return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0,green: ((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0,blue: ((CGFloat)(rgbValue & 0xFF)) / 255.0,alpha: 1.0)
}
    func rulerRGBFromHex(rgbValue: Int) -> (UIColor) {
    
            return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0,green: ((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0,blue: ((CGFloat)(rgbValue & 0xFF)) / 255.0,alpha: 0.5)
}

   // 10 kRGBColorFromHex(0x1D1D26)

