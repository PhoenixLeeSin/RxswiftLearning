//
//  LXFViewModelType.swift
//  CrewLogger
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

import Foundation

protocol FlightPlanViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input:Input) -> Output
}
