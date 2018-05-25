//
//  WriteInfoViewController.swift
//  CrewLogger
//
//  Created by apple on 2018/5/17.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

/*填写航班信息VC*/
class WriteInfoViewController: UIViewController {
    
    //航前准备按钮
    lazy var preFlightButton:UIButton = {
        let button = UIButton()
        button.setTitleColor(RedColor, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.5
        button.tag = 001
        return button
    }()
    //值飞情况按钮
    lazy var quantificationButton:UIButton = {
        let button = UIButton()
        button.setTitleColor(RedColor, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.5
        button.tag = 002
        return button
    }()
    //航后总结
    lazy var afeFlightSummaryButton:UIButton = {
        let button = UIButton()
        button.setTitleColor(RedColor, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.5
        button.tag = 003
        return button
    }()
    //航前准备自定义View
    lazy var preFlightPreparationView:PreFlightPreparationView = {
        let view = PreFlightPreparationView()
        return view
    }()
    let viewModel = WriteInfoViewModel()
    var preparationId:Int = 1
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        setupUI()
        bindView()
    }
    func setupUI(){
        self.view.addSubview(preFlightButton)
        self.view.addSubview(quantificationButton)
        self.view.addSubview(afeFlightSummaryButton)
        self.view.addSubview(preFlightPreparationView)
        
        self.preFlightButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(0)
            make.top.equalTo(self.view.snp.top).offset(100)
            make.width.equalTo(100)
            make.height.equalTo(self.quantificationButton.snp.height)
        }
        self.quantificationButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(0)
            make.top.equalTo(self.preFlightButton.snp.bottom).offset(0)
            make.width.equalTo(100)
            make.height.equalTo(self.afeFlightSummaryButton.snp.height)
        }
        self.afeFlightSummaryButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(0)
            make.top.equalTo(self.quantificationButton.snp.bottom).offset(0)
            make.width.equalTo(100)
            make.bottom.equalTo(self.view.snp.bottom).offset(-100)
        }
        self.preFlightPreparationView.snp.makeConstraints { (make) in
            make.left.equalTo(self.preFlightButton.snp.right).offset(0)
            make.right.equalTo(self.view.snp.right).offset(0)
            make.top.equalTo(self.view.snp.top).offset(64)
            make.bottom.equalTo(self.view.snp.bottom).offset(-45)
        }
        preFlightButton.set(image: UIImage.init(named: "航前准备-红"), title: "航前准备", titlePosition: .bottom, additionalSpacing: 20, state: .normal)
        quantificationButton.set(image: UIImage.init(named: "值飞情况-红"), title: "执飞情况", titlePosition: .bottom, additionalSpacing: 20, state: .normal)
        afeFlightSummaryButton.set(image: UIImage.init(named: "航后总结-红"), title: "航后总结", titlePosition: .bottom, additionalSpacing: 20, state: .normal)
        
    }
    func bindView(){
        let input = WriteInfoViewModel.Input(preparationId: self.preparationId)
        let output = viewModel.transform(input: input)
        //航前准备按钮点击
        (preFlightButton.rx.tap).asObservable()
            .subscribe(onNext: { [weak self] _ in
               print("1111")
            })
            .disposed(by:disposeBag)
        
        output.model.asDriver()
                    .asObservable()
                    .bind { (model) in                    
                    self.preFlightPreparationView.viewWithModel(model)
                   }.disposed(by: disposeBag)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
