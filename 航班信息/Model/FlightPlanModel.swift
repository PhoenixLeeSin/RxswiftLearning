//
//  FlightPlanModel.swift
//  CrewLogger
//
//  Created by apple on 2018/5/2.
//  Copyright © 2018年 apple. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm
import RxDataSources


class FlightPlanModel: Object,Mappable {
    @objc dynamic var flightId:String? = nil
    @objc dynamic  var preparationId:Int = 1    //行前准备id
    @objc dynamic  var flightNo:String? = nil      //航班号
    @objc dynamic  var flightDate:String?  = nil       //航班日期
    @objc dynamic  var arrivalTime:String?  = nil       //到岗时间
    @objc dynamic  var enterTime:String?   = nil       //进场时间
    @objc dynamic  var acType:String?    = nil          //机型
    @objc dynamic  var acReg:String?    = nil          //机号
    @objc dynamic  var flightVoyage:String?  = nil    //航线
    @objc dynamic  var crewCount:String?   = nil         //机组人数
    @objc dynamic  var captain:String?    = nil       //机长工号
    @objc dynamic  var h001:String?     = nil           //乘务长工号
    @objc dynamic var h001Name:String?   = nil         //乘务长姓名
    var  h003:List<h003Model>?           //乘务员3
    @objc dynamic  var is3Certificate:String?  = nil     //3证
    @objc dynamic  var isApperence:String?   = nil    //仪容仪表
    @objc dynamic  var lateList:String?   = nil        //迟到人员列表
    @objc dynamic  var planTime:String?    = nil      //计划时间
    var crewBack:List<crewBackModel>? //
    @objc dynamic  var h003List:String? = nil
    @objc dynamic var flightStatus:String? = nil  //航班状态
    @objc dynamic var  isUpdate:Int = 1  //乘务日志是否填写
   
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map)
    {
        preparationId <- map["preparationId"]
        flightNo <- map["flightNo"]
        flightDate <- map["flightDate"]
        flightId <- map["flightId"]
        arrivalTime <- map["arrivalTime"]
        enterTime <- map["enterTime"]
        acReg <- map["acReg"]
        acType <- map["acType"]
        flightVoyage <- map["flightVoyage"]
        crewCount <- map["crewCount"]
        captain <- map["captain"]
        h001 <- map["h001"]
        h001Name <- map["h001Name"]
        h003 <- (map["h003"],ListTransform<h003Model>())
        is3Certificate <- map["is3Certificate"]
        isApperence <- map["isApperence"]
        lateList <- map["lateList"]
        planTime <- map["planTime"]
        crewBack <- (map["crewBack"],ListTransform<crewBackModel>())
        h003List <- map["h003List"]
        flightStatus <- map["flightStatus"]
        isUpdate <- map["isUpdate"]
    }
    override static func primaryKey()->String?{
        return "preparationId"
    }
}

class h003Model: Object ,Mappable {
    @objc dynamic var workcode:String = ""
    @objc dynamic var crewName:String = ""
    @objc dynamic var tsFlag:String? = nil

    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map)
    {
        workcode <- map["workcode"]
        crewName <- map["crewName"]
        tsFlag <- map["tsFlag"]
    }
}

class crewBackModel: Object ,Mappable {
    @objc dynamic var id:String? = nil
    @objc dynamic var text:String? = nil
    @objc dynamic var textEn:String? = nil
    @objc dynamic var isDefault:String? = nil
    
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map)
    {
        id <- map["id"]
        text <- map["text"]
        textEn <- map["textEn"]
        isDefault <- map["isDefault"]
    }
}
/*
 自定义section
 */
struct FlightPlanSection {
     // items就是rows
    var items:[Item]
}
extension FlightPlanSection:SectionModelType{
    
    // 重定义 Item 的类型为 LXFModel
    typealias Item = FlightPlanModel
    
    init(original: FlightPlanSection, items: [FlightPlanSection.Item]) {
        self = original
        self.items = items
    }
}







