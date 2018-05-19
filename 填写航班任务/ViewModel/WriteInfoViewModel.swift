//
//  WriteInfoViewModel.swift
//  CrewLogger
//
//  Created by apple on 2018/5/18.
//  Copyright © 2018年 apple. All rights reserved.
/*viewModel主要职责:
    由输入源model 输出model是网络请求的model还是以保存的model
 */

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

class WriteInfoViewModel: NSObject {
    
    fileprivate let disposeBag = DisposeBag()
    //存储输出的model
    let model_realm = Variable<FlightPlanModel>(FlightPlanModel())
}
extension WriteInfoViewModel:FlightPlanViewModelType{
    
    //别名
    typealias Input = LeeInput
    typealias Output = LeeOutput
    
    struct LeeInput {
        let preparationId:Int
        init(preparationId:Int) {
            self.preparationId = preparationId
        }
    }
    struct LeeOutput {
        //按钮的显示与否
        let buttonIsHiddenOrnot = Variable<Bool>(false)
        //输出的model
        let model :Driver<FlightPlanModel>
    }
    func transform(input: WriteInfoViewModel.Input) -> WriteInfoViewModel.Output {
        
        let outputModel = model_realm.asObservable()
                                     .map { (model) -> FlightPlanModel in
                                        return model
                                      }.asDriver(onErrorJustReturn: FlightPlanModel())
            
        let output = LeeOutput(model: outputModel)
        
        let realm = try! Realm(configuration: RealmConfiguration.shareInstance.setDefaultRealmForAlterFlightplan())
        if (realm.object(ofType: FlightPlanModel.self, forPrimaryKey: input.preparationId) != nil){
            let model_realm = realm.object(ofType: FlightPlanModel.self, forPrimaryKey: input.preparationId)
            self.model_realm.value = model_realm!
            let hidden = ((model_realm?.isUpdate = 3) != nil) ? true:false
                output.buttonIsHiddenOrnot.value = hidden
        }else{
            let realm = try! Realm(configuration: RealmConfiguration.shareInstance.setDefaultRealmForFlightplan())
            let model_realm = realm.object(ofType: FlightPlanModel.self, forPrimaryKey: input.preparationId)
            self.model_realm.value = model_realm!
            let hidden = ((model_realm?.isUpdate = 3) != nil) ? true:false
                output.buttonIsHiddenOrnot.value = hidden
        }
        return output
    }
}
