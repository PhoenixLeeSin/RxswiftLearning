//
//  ListExtensions.swift
//  CrewLogger
//
//  Created by apple on 2018/5/21.
//  Copyright © 2018年 apple. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

/// Maps object of Realm's List type
func <- <T: Mappable>(left: List<T>, right: Map)
{
    var array: [T]?
    
    if right.mappingType == .toJSON {
        array = Array(left)
    }
    
    array <- right
    
    if right.mappingType == .fromJSON {
        if let theArray = array {
            left.append(objectsIn: theArray)
        }
    }
}
