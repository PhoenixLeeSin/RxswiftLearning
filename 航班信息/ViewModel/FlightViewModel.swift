//
//  FlightViewModel.swift
//  CrewLogger
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

class FlightViewModel: NSObject {
    // 存放着解析完成的模型数组
    let models = Variable<[FlightPlanModel]>([])
    fileprivate let disposeBag = DisposeBag()
    /* 获取用户信息*/
    func getUserInfo()->User{
        let realm = try! Realm(configuration: RealmConfiguration.shareInstance.setDefaultRealmForUser())
        let users = realm.objects(User.self)
        return users.first!
    }
}
extension FlightViewModel:FlightPlanViewModelType{
    
    typealias Input = LeeInput
    typealias Output = LeeOutput
    
    struct LeeInput {
        let workcode:String
        init(workcode:String) {
            self.workcode = workcode
        }
    }
    struct  LeeOutput {
        // tableView的sections数据
        let sections : Driver<[FlightPlanSection]>
        // 外界通过该属性告诉viewModel加载数据（传入的值是为了标志是否重新加载）
        let requstCommond = PublishSubject<Bool>()
        // 告诉外界的tableView当前的刷新状态
        let refreshStatus = Variable<LeeRefreshStatus>(.none)
    }
    
    func transform(input: FlightViewModel.LeeInput) -> FlightViewModel.LeeOutput {
        let sections = models.asObservable()
                             .map { (models) -> [FlightPlanSection] in
                             return [FlightPlanSection(items: models)]
                             }
                             .asDriver(onErrorJustReturn: [])
        
        let output = LeeOutput(sections: sections)
        
        output.requstCommond.subscribe(onNext: { [unowned self] _ in
            CrewProvider.rx.request(CrewAPI.flightPlan(input.workcode))                               
                               .asObservable()
                               .mapJSON()
                               .mapArray(type: FlightPlanModel.self)
                .subscribe({ [weak self] (event) in
                    switch event {
                    case let .next(modelArr):
                        self?.models.value = modelArr
                        /*realm数据库的刷新*/
                        let realm = try! Realm(configuration: RealmConfiguration.shareInstance.setDefaultRealmForFlightplan())                        
                        try! realm.write {
                            for model in modelArr{
                                realm.add(model, update: true)
                            }
                        }
                    case let .error(error):
                        print(error)
                    case .completed:
                        output.refreshStatus.value = .endHeaderRefresh
                    }
                }).disposed(by: self.disposeBag)
        })
            .disposed(by:disposeBag)
        return output
    }
}
