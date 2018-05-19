//
//  RealmConfiguration.swift
//  CrewLogger
//
//  Created by apple on 2018/4/28.
//  Copyright © 2018年 apple. All rights reserved.
//

import Foundation
import RealmSwift

/*
 通过Realm 的config 修改默认的数据库 
 */
class RealmConfiguration {
    ///单例
    static let shareInstance = RealmConfiguration()    
    /*
     配置user为默认数据库
     */
    func setDefaultRealmForUser()->Realm.Configuration{
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("User.realm")
        return config
    }
    /*
     配置为航班任务的数据库
     */
    func setDefaultRealmForFlightplan()->Realm.Configuration{
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("Flightplan.realm")
        return config
    }
    /*
     配置保存航前准备数据库
     */
    func setDefaultRealmForAlterFlightplan()->Realm.Configuration{
        var config = Realm.Configuration()
        config.fileURL = config.fileURL?.deletingLastPathComponent().appendingPathComponent("FlightplanAlter.realm")
        return config
    }
}
