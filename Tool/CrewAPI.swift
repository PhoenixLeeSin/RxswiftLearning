//
//  CrewAPI.swift
//  CrewLogger
//
//  Created by apple on 2018/4/24.
//  Copyright © 2018年 apple. All rights reserved.
//

import Foundation
import Moya

let CrewProvider = MoyaProvider<CrewAPI>()

enum CrewAPI {
    case flightPlan(String)
    case preparetion(jsonString:String)
    case quantification(jsonString:String)
    case afterFlightsummary(workcode:String,preparationId:Int,case1:String?,cleanFeedBack:String,innerFeedback:String?,innerFeedbacks:[Data]?,scFeedback:String?,scFeedbacks:[Data]?,zbFeedback:String?,zbFeedbacks:[Data]?,jwFeedback:String?,jwFeedbacks:[Data]?)
    
    

    
}
extension CrewAPI:TargetType{
    
    public var baseURL:URL{
        switch self {
        default:
            return URL.init(string: "http://172.16.3.232:11080/PSS")!
        }
    }
    public var path: String{
        switch self {
        case .flightPlan(_):
            return "/crewLogger/getPreparationList.do"
        case .preparetion(_):
            return "/crewLogger/savePreparetion.do"
        case .quantification(_):
            return "/crewLogger/saveEvalutation.do"
        default:
            return "/crewLogger/saveSummary.do"
        }
    }
    public var method: Moya.Method{
        switch self {
        case .flightPlan:
            return .get
        default:
            return .post
        }
    }
    public var task:Task{
        switch self {
        case .flightPlan(let workcode):
            var parms:[String:Any] = [:]
            parms["workcode"] = workcode
            return .requestParameters(parameters: parms, encoding: URLEncoding.default)
        case let .preparetion(jsonString: jsonString):
            return .requestParameters(parameters: [:], encoding: jsonString)
        case let .quantification(jsonString: jsonString):
            return .requestParameters(parameters: [:], encoding: jsonString)
        case let .afterFlightsummary(workcode: workcode, preparationId:preparationId , case1: case1, cleanFeedBack: cleanFeedBack, innerFeedback: innerFeedback, innerFeedbacks: innerFeedbacks, scFeedback: scFeedback, scFeedbacks: scFeedbacks, zbFeedback: zbFeedback, zbFeedbacks: zbFeedbacks, jwFeedback: jwFeedback, jwFeedbacks: jwFeedbacks):
            
            var multipartData = [MultipartFormData]()
            
            let workcodeData = workcode.data(using: String.Encoding.utf8)
            let formData_workcode = MultipartFormData(provider: .data(workcodeData!), name: "workcode")
            
            let preparationIdData = String(preparationId).data(using: String.Encoding.utf8)
            let formData_preparationId = MultipartFormData(provider: .data(preparationIdData!), name: "preparationId")
            
            multipartData.append(formData_workcode)
            multipartData.append(formData_preparationId)
            if let caseString = case1{
                let caseData = caseString.data(using: .utf8)
                let formData_case1 = MultipartFormData(provider: .data(caseData!), name: "case1")
                multipartData.append(formData_case1)
            }
            let cleanFeedBackData = cleanFeedBack.data(using: .utf8)
            let formData_cleanFeedBack = MultipartFormData(provider: .data(cleanFeedBackData!), name: "cleanFeedBack")
            multipartData.append(formData_cleanFeedBack)
            
            if let innerFeedbackString = innerFeedback{
                let innerFeedbackData = innerFeedbackString.data(using: .utf8)
                let formData_innerFeedback = MultipartFormData(provider: .data(innerFeedbackData!), name: "innerFeedbackString")
                multipartData.append(formData_innerFeedback)
            }
            if let innerFeedbacksArr = innerFeedbacks{
                for model in innerFeedbacksArr{
                    let formData_innerFeedbacks = MultipartFormData(provider: .data(model), name:"innerFeedbacks", fileName: self.getTimeinterval()+".jpg", mimeType: "image/jpeg")
                    multipartData.append(formData_innerFeedbacks)
                }
            }
            
            if  let scFeedbackString = scFeedback{
                let scFeedbackData = scFeedbackString.data(using: .utf8)
                let formData_scFeedback = MultipartFormData(provider: .data(scFeedbackData!), name: "scFeedbackString")
                multipartData.append(formData_scFeedback)
            }
            if let scFeedbacksArr = scFeedbacks{
                for model in scFeedbacksArr{
                    let formData_scFeedbacks = MultipartFormData(provider: .data(model), name:"scFeedbacks", fileName: self.getTimeinterval()+".jpg", mimeType: "image/jpeg")
                    multipartData.append(formData_scFeedbacks)
                }
            }
            
            if let zbFeedbackString = zbFeedback{
                let zbFeedbackData = zbFeedbackString.data(using: .utf8)
                let formData_zbFeedback = MultipartFormData(provider: .data(zbFeedbackData!), name: "zbFeedbackString")
                multipartData.append(formData_zbFeedback)
            }
            if let zbFeedbacksArr = zbFeedbacks{
                for model in zbFeedbacksArr{
                    let formData_zbFeedbacks = MultipartFormData(provider: .data(model), name:"zbFeedbacks", fileName: self.getTimeinterval()+".jpg", mimeType: "image/jpeg")
                    multipartData.append(formData_zbFeedbacks)
                }
            }
            
            if let jwFeedbackString = jwFeedback{
                let jwFeedbackData = jwFeedbackString.data(using: .utf8)
                let formData_jwFeedback = MultipartFormData(provider: .data(jwFeedbackData!), name: "jwFeedbackString")
                multipartData.append(formData_jwFeedback)
            }
            if let jwFeedbacksArr = jwFeedbacks{
                for model in jwFeedbacksArr{
                    let formData_jwFeedbacks = MultipartFormData(provider: .data(model), name:"jwFeedbacks", fileName: self.getTimeinterval()+".jpg", mimeType: "image/jpeg")
                    multipartData.append(formData_jwFeedbacks)
                }
            }
            return .uploadMultipart(multipartData)
        }
    }
    public var validate:Bool{
        return false
    }
    public var sampleData:Data{
        return "..".data(using: String.Encoding.utf8)!
    }
    public var headers:[String:String]?{
        switch self {
        case .flightPlan(_):
            return nil
        case .preparetion(jsonString: _):
            return ["Accept":"application/json","Content-Type" : "application/json"]
        case .quantification(jsonString: _):
            return ["Accept":"application/json","Content-Type" : "application/json"]
        case .afterFlightsummary(fileURL: _):
            return ["content-type":"multipart/form-data"]
        }
    }
    ///获取系统时间戳
     func getTimeinterval()->String{
        let date = NSDate()
        let timeInterval = date.timeIntervalSince1970 * 1000
        let intNumber = Int.init(timeInterval)
        return "\(intNumber)"
    }
}

