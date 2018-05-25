//
//  PreFlightPreparationView.swift
//  CrewLog
//
//  Created by apple on 2017/12/11.
//  Copyright © 2017年 LeeSin. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import AnimatedTextInput
import SVProgressHUD
import RSKGrowingTextView


class PreFlightPreparationView: UIView,UITableViewDelegate,UITableViewDataSource {
    /*
     航の前準備  的cell
     显示内容:      航班号：QW9772   航班日期：2017-12-11
     到岗时间：05:05  进场时间：05:20
     机型： A320     机号：B-8282
     航线：青蓉青     计划时间：06:40-09:00
     机长：***       乘务长： ***
     迟到人员 ***
     乘务员
     三证齐全
     仪容仪表
     */
    
    var preparationId:Int? //标识
    var index:Int = 0  //表示那个乘务员手势被激活
    //航班号
    lazy var flightNoLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.textAlignment = .left
        return label
    }()
    //航班日期
    lazy var fligtDateLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.textAlignment = .left
        return label
    }()
    //到岗时间
    lazy var arrivalTimeLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.textAlignment = .left
        return label
    }()
    //进场时间
    lazy var enterTimeLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.textAlignment = .left
        return label
    }()
    //机型
    lazy var acTypeLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.textAlignment = .left
        return label
    }()
    //机号
    lazy var acRegLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.textAlignment = .left
        return label
    }()
    //航线
    lazy var flightVoyageLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.textAlignment = .left
        return label
    }()
    //计划时间
    lazy var planTimeLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.textAlignment = .left
        return label
    }()
    //机长
    lazy var captainLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.textAlignment = .left
        return label
    }()
    //乘务长
    lazy var h001Label:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.textAlignment = .left
        return label
    }()
    //迟到人员
    lazy var lateListLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.textAlignment = .left
        return label
    }()
    lazy var lateListText:RSKPlaceholderTextView = {
        let textField = RSKPlaceholderTextView()
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        return textField
    }()
    //乘务员
    lazy var stewardLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.textAlignment = .left
        return label
    }()
    //乘务员2
    lazy var h002Label:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.textAlignment = .left
        return label
    }()
    //乘务员3
    lazy var h003Label:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.textAlignment = .left
        return label
    }()
    //乘务员4
    lazy var h004Label:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.textAlignment = .left
        return label
    }()
    //乘务员5
    lazy var h005Label:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.textAlignment = .left
        return label
    }()
    //乘务员6
    lazy var h006Label:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.textAlignment = .left
        return label
    }()
    //3证
    lazy var is3CertificateLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "三证齐全:"
        return label
    }()
    //仪容仪表
    lazy var isApperenceLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "仪容仪表:"
        return label
    }()
    //3证button   ’0‘ 未确定    ‘1’已确认
    lazy var is3CertificateButton:UIButton = {
        let button = UIButton.init()
        button.setImage(UIImage.init(named: "checkboxoff"), for: .normal)
        return button
    }()
    //仪容仪表button
    lazy var isApperenceButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(named: "checkboxoff"), for: .normal)
        return button
    }()
    //保存按钮
    lazy var saveButton:UIButton = {
        let button = UIButton()
        button.setTitle("保存", for: .normal)
        button.backgroundColor = OrangeColor_FlightStatus
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    //
    var h003ModelArr:[h003Model]?
    
    let leftOffSuperView:CGFloat = 20.0
    let rightOffSuperView:CGFloat = -20.0
    let topWidth:CGFloat = 20.0
    let leftOffSubView:CGFloat = 50.0
    
    lazy var tableView:UITableView? = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "PreFlightPreparationCell")
        table.delegate = self
        table.dataSource = self
        return table
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpUI(){
        self.addSubview(flightNoLabel)
        self.addSubview(fligtDateLabel)
        self.addSubview(arrivalTimeLabel)
        self.addSubview(enterTimeLabel)
        self.addSubview(acTypeLabel)
        self.addSubview(acRegLabel)
        self.addSubview(flightVoyageLabel)
        self.addSubview(planTimeLabel)
        self.addSubview(captainLabel)
        self.addSubview(h001Label)
        self.addSubview(lateListLabel)
        self.addSubview(lateListText)
        self.addSubview(stewardLabel)
        self.addSubview(h002Label)
        self.addSubview(h003Label)
        self.addSubview(h004Label)
        self.addSubview(h005Label)
        self.addSubview(h006Label)
        self.addSubview(is3CertificateLabel)
        self.addSubview(is3CertificateButton)
        self.addSubview(isApperenceLabel)
        self.addSubview(isApperenceButton)
        self.addSubview(saveButton)
        self.flightNoLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(leftOffSuperView)
            make.right.equalTo(self.snp.centerX).offset(rightOffSuperView)
            make.top.equalTo(self.snp.top).offset(topWidth)
            make.height.equalTo(self.is3CertificateLabel.snp.height)
        }
        self.fligtDateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.centerX).offset(leftOffSubView)
            make.right.equalTo(self.snp.right).offset(rightOffSuperView)
            make.top.equalTo(self.snp.top).offset(topWidth)
            make.height.equalTo(self.is3CertificateLabel.snp.height)
        }
        self.arrivalTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(leftOffSuperView)
            make.right.equalTo(self.snp.centerX).offset(rightOffSuperView)
            make.top.equalTo(self.flightNoLabel.snp.bottom).offset(topWidth)
            make.height.equalTo(self.acTypeLabel.snp.height)
        }
        self.enterTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.centerX).offset(leftOffSubView)
            make.right.equalTo(self.snp.right).offset(rightOffSuperView)
            make.top.equalTo(self.fligtDateLabel.snp.bottom).offset(topWidth)
            make.height.equalTo(self.acTypeLabel.snp.height)
        }
        self.acTypeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(leftOffSuperView)
            make.right.equalTo(self.snp.centerX).offset(rightOffSuperView)
            make.top.equalTo(self.arrivalTimeLabel.snp.bottom).offset(topWidth)
            make.height.equalTo(self.flightVoyageLabel.snp.height)
        }
        self.acRegLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.centerX).offset(leftOffSubView)
            make.right.equalTo(self.snp.right).offset(rightOffSuperView)
            make.top.equalTo(self.enterTimeLabel.snp.bottom).offset(topWidth)
            make.height.equalTo(self.flightVoyageLabel.snp.height)
        }
        self.flightVoyageLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(leftOffSuperView)
            make.right.equalTo(self.snp.centerX).offset(rightOffSuperView)
            make.top.equalTo(self.acTypeLabel.snp.bottom).offset(topWidth)
            make.height.equalTo(self.captainLabel.snp.height)
        }
        self.planTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.centerX).offset(leftOffSubView)
            make.right.equalTo(self.snp.right).offset(rightOffSuperView)
            make.top.equalTo(self.acRegLabel.snp.bottom).offset(topWidth)
            make.height.equalTo(self.captainLabel.snp.height)
        }
        self.captainLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(leftOffSuperView)
            make.right.equalTo(self.snp.centerX).offset(rightOffSuperView)
            make.top.equalTo(self.flightVoyageLabel.snp.bottom).offset(topWidth)
            make.height.equalTo(self.lateListLabel.snp.height)
        }
        self.h001Label.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.centerX).offset(leftOffSubView)
            make.right.equalTo(self.snp.right).offset(rightOffSuperView)
            make.top.equalTo(self.planTimeLabel.snp.bottom).offset(topWidth)
            make.height.equalTo(self.is3CertificateLabel.snp.height)
        }
        self.lateListLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(leftOffSuperView)
            make.top.equalTo(self.captainLabel.snp.bottom).offset(topWidth)
            make.height.equalTo(self.is3CertificateLabel.snp.height)
        }
        self.lateListText.snp.makeConstraints { (make) in
            make.left.equalTo(self.lateListLabel.snp.right).offset(leftOffSuperView)
            make.top.equalTo(self.captainLabel.snp.bottom).offset(topWidth)
            make.height.equalTo(self.is3CertificateLabel.snp.height)
            make.right.equalTo(self.snp.right).offset(rightOffSuperView)
        }
        
        self.stewardLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(leftOffSuperView)
            make.top.equalTo(self.lateListLabel.snp.bottom).offset(topWidth)
            make.height.equalTo(self.is3CertificateLabel.snp.height)
            make.width.equalTo(100)
        }
        self.h002Label.snp.makeConstraints { (make) in
            make.top.equalTo(self.lateListLabel.snp.bottom).offset(topWidth)
            make.left.equalTo(self.stewardLabel.snp.right).offset(leftOffSubView)
            make.right.equalTo(self.snp.right).offset(rightOffSuperView)
            make.height.equalTo(self.is3CertificateLabel.snp.height)
        }
        self.h003Label.snp.makeConstraints { (make) in
            make.top.equalTo(self.h002Label.snp.bottom).offset(topWidth)
            make.left.equalTo(self.stewardLabel.snp.right).offset(leftOffSubView)
            make.right.equalTo(self.snp.right).offset(rightOffSuperView)
            make.height.equalTo(self.is3CertificateLabel.snp.height)
        }
        self.h004Label.snp.makeConstraints { (make) in
            make.top.equalTo(self.h003Label.snp.bottom).offset(topWidth)
            make.left.equalTo(self.stewardLabel.snp.right).offset(leftOffSubView)
            make.right.equalTo(self.snp.right).offset(rightOffSuperView)
            make.height.equalTo(self.is3CertificateLabel.snp.height)
        }
        self.h005Label.snp.makeConstraints { (make) in
            make.top.equalTo(self.h004Label.snp.bottom).offset(topWidth)
            make.left.equalTo(self.stewardLabel.snp.right).offset(leftOffSubView)
            make.right.equalTo(self.snp.right).offset(rightOffSuperView)
            make.height.equalTo(self.is3CertificateLabel.snp.height)
        }
        self.h006Label.snp.makeConstraints { (make) in
            make.top.equalTo(self.h005Label.snp.bottom).offset(topWidth)
            make.left.equalTo(self.stewardLabel.snp.right).offset(leftOffSubView)
            make.right.equalTo(self.snp.right).offset(rightOffSuperView)
            make.height.equalTo(self.is3CertificateLabel.snp.height)
        }
        self.is3CertificateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(leftOffSuperView)
            make.top.equalTo(self.h006Label.snp.bottom).offset(topWidth)
            make.height.equalTo(self.isApperenceLabel.snp.height)
            make.width.equalTo(100)
        }
        self.is3CertificateButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.is3CertificateLabel.snp.centerY)
            make.left.equalTo(self.is3CertificateLabel.snp.right).offset(20)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        self.isApperenceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(leftOffSuperView)
            make.top.equalTo(self.is3CertificateLabel.snp.bottom).offset(topWidth)
            make.bottom.equalTo(self.saveButton.snp.top).offset(-20.0)
            make.width.equalTo(100)
        }
        self.isApperenceButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.isApperenceLabel.snp.centerY)
            make.left.equalTo(self.is3CertificateLabel.snp.right).offset(20)
            make.width.height.equalTo(30)
        }
        self.saveButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.isApperenceLabel.snp.bottom).offset(topWidth)
            make.height.equalTo(40)
            make.width.equalTo(90)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
        }
        //按钮
        self.is3CertificateButton.addTarget(self, action: #selector(is3BtnClick(_:)), for: .touchUpInside)
        self.isApperenceButton.addTarget(self, action: #selector(iaAppBtnClick(_:)), for: .touchUpInside)
        self.saveButton.addTarget(self, action: #selector(saveBtnClick(_:)), for: .touchUpInside)
    }
    
    func viewWithModel(_ model: FlightPlanModel){
        if let flightNo = model.flightNo{
            self.flightNoLabel.text = "航班号:"+"  "+flightNo
        }else{
            self.flightNoLabel.text = "航班号:"
        }
        if let flightDate = model.flightDate{
            self.fligtDateLabel.text = "航班日期:"+"  "+flightDate
        }else{
            self.fligtDateLabel.text = "航班日期:"
        }
        if let arrivalTime = model.arrivalTime{
            self.arrivalTimeLabel.text = "到岗时间:"+arrivalTime
        }else{
            self.arrivalTimeLabel.text = "到岗时间:"
        }
        if let enterTime = model.enterTime{
            self.enterTimeLabel.text = "进场时间:"+"  "+enterTime
        }else{
            self.enterTimeLabel.text = "进场时间:"
        }
        if let acReg = model.acReg{
            self.acRegLabel.text = "机号:"+"  "+acReg
        }else{
            self.acRegLabel.text = "机号:"
        }
        if let acType = model.acType{
            self.acTypeLabel.text = "机型:"+"  "+acType
        }else{
            self.acTypeLabel.text = "机型:"
        }
        if let flightVoyage = model.flightVoyage{
            self.flightVoyageLabel.text = "航线:"+"  "+flightVoyage
        }else{
            self.flightVoyageLabel.text = "航线:"
        }
        if let planTime = model.planTime{
            self.planTimeLabel.text = "计划时间:"+"  "+planTime
        }else{
            self.planTimeLabel.text = "计划时间:"
        }
        if let captain = model.captain{
            self.captainLabel.text = "机长:"+"  "+captain
        }else{
            self.captainLabel.text = "机长:"
        }
        if let h001 = model.h001Name{
            self.h001Label.text = "乘务长:"+"  "+h001
        }else{
            self.h001Label.text = "乘务长:"
        }
        self.stewardLabel.text = "乘务员:"
        
        
            let h003Arr = model.h003
        
            if h003Arr.count>0{
                if let tsFlag = h003Arr[0].tsFlag{
                    self.h002Label.text = "2#:"+"  "+h003Arr[0].crewName+"("+tsFlag+")"
                }else{
                    self.h002Label.text = "2#:"+"  "+h003Arr[0].crewName
                }
            }else{
                self.h002Label.text = "2#:"
            }
        
        
            if h003Arr.count>1{
                if let tsFlag = h003Arr[1].tsFlag{
                    if h003Arr.count != 3{
                        self.h003Label.text = "3#:"+"  "+h003Arr[1].crewName+"("+tsFlag+")"
                    }else{
                        self.h003Label.text = "4#:"+"  "+h003Arr[1].crewName+"("+tsFlag+")"
                    }
                }else{
                    if h003Arr.count != 3{
                        self.h003Label.text = "3#:"+"  "+h003Arr[1].crewName
                    }else{
                        self.h003Label.text = "4#:"+"  "+h003Arr[1].crewName
                    }
                }
            }else {
                self.h003Label.text = "3#:"
            }

        
            if h003Arr.count>2{
                if let tsFlag = h003Arr[2].tsFlag{
                    if h003Arr.count != 3{
                        self.h004Label.text = "4#:"+"  "+h003Arr[2].crewName+"("+tsFlag+")"
                    }else{
                        self.h004Label.text = "5#:"+"  "+h003Arr[2].crewName+"("+tsFlag+")"
                    }
                }else{
                    if h003Arr.count != 3{
                        self.h004Label.text = "4#:"+"  "+h003Arr[2].crewName
                    }else{
                        self.h004Label.text = "5#:"+"  "+h003Arr[2].crewName
                    }
                }
            }else{
                self.h004Label.text = "4#:"
            }

            if h003Arr.count>3{
                if let tsFlag = h003Arr[3].tsFlag{
                    self.h005Label.text = "5#:"+"  "+h003Arr[3].crewName+"("+tsFlag+")"
                }else{
                    self.h005Label.text = "5#:"+"  "+h003Arr[3].crewName
                }
            }
        
        
            if h003Arr.count>4{
                if let tsFlag = h003Arr[4].tsFlag{
                    self.h006Label.text = "6#:"+"  "+h003Arr[4].crewName+"("+tsFlag+")"
                }else{
                    self.h006Label.text = "6#:"+"  "+h003Arr[4].crewName
                }
            }
        
        if let lateList = model.lateList{
            self.lateListLabel.text = "迟到人员:"+"  "+lateList
        }else{
            self.lateListLabel.text = "迟到人员:"
        }
        self.is3CertificateLabel.text = "三证齐全:"
        self.isApperenceLabel.text = "仪容仪表:"
        
        //label + 手势
        if self.h002Label.text != nil{
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(h002Tap(_:)))
            self.h002Label.addGestureRecognizer(tap)
            self.h002Label.isUserInteractionEnabled = true
        }
        if self.h003Label.text != nil{
            self.h003Label.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(h003Tap(_ :))))
            self.h003Label.isUserInteractionEnabled = true
        }
        if self.h004Label.text != nil{
            self.h004Label.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(h004Tap(_ :))))
            self.h004Label.isUserInteractionEnabled = true
        }
        if self.h005Label.text != nil{
            self.h005Label.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(h005Tap(_ :))))
            self.h005Label.isUserInteractionEnabled = true
        }
        if self.h006Label.text != nil{
            self.h006Label.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(h006Tap(_ :))))
            self.h006Label.isUserInteractionEnabled = true
        }
        

//            if  update == 3{
//                self.saveButton.isHidden = true
//            }

        
    }
    
    //是否有修改乘务员顺序
    func viewWithFlightplanAlterModel(_ model:FlightPlanModel){
        if let lateString = model.lateList{
            self.lateListText.text = lateString
        }
        
        if let h003Arr = self.h003ModelArr{
            if h003Arr.count>0{
                if let tsFlag = h003Arr[0].tsFlag{
                    self.h002Label.text = "2#:"+"  "+h003Arr[0].crewName+"("+tsFlag+")"
                }else{
                    self.h002Label.text = "2#:"+"  "+h003Arr[0].crewName
                }
            }else{
                self.h002Label.text = "2#:"
            }
        }else{
            self.h002Label.text = "2#:"
        }
        if let h003Arr = self.h003ModelArr{
            if h003Arr.count>1{
                if let tsFlag = h003Arr[1].tsFlag{
                    if h003Arr.count != 3{
                        self.h003Label.text = "3#:"+"  "+h003Arr[1].crewName+"("+tsFlag+")"
                    }else{
                        self.h003Label.text = "4#:"+"  "+h003Arr[1].crewName+"("+tsFlag+")"
                    }
                }else{
                    if h003Arr.count != 3{
                        self.h003Label.text = "3#:"+"  "+h003Arr[1].crewName
                    }else{
                        self.h003Label.text = "4#:"+"  "+h003Arr[1].crewName
                    }
                }
            }else {
                self.h003Label.text = "3#:"
            }
        }else{
            self.h003Label.text = "3#:"
        }
        if let h003Arr = self.h003ModelArr{
            if h003Arr.count>2{
                if let tsFlag = h003Arr[2].tsFlag{
                    if h003Arr.count != 3{
                        self.h004Label.text = "4#:"+"  "+h003Arr[2].crewName+"("+tsFlag+")"
                    }else{
                        self.h004Label.text = "5#:"+"  "+h003Arr[2].crewName+"("+tsFlag+")"
                    }
                }else{
                    if h003Arr.count != 3{
                        self.h004Label.text = "4#:"+"  "+h003Arr[2].crewName
                    }else{
                        self.h004Label.text = "5#:"+"  "+h003Arr[2].crewName
                    }
                }
            }else{
                self.h004Label.text = "4#:"
            }
        }else{
            self.h004Label.text = "4#:"
        }
        if let h003Arr = self.h003ModelArr{
            if h003Arr.count>3{
                if let tsFlag = h003Arr[3].tsFlag{
                    self.h005Label.text = "5#:"+"  "+h003Arr[3].crewName+"("+tsFlag+")"
                }else{
                    self.h005Label.text = "5#:"+"  "+h003Arr[3].crewName
                }
            }
        }
        if let h003Arr = self.h003ModelArr{
            if h003Arr.count>4{
                if let tsFlag = h003Arr[4].tsFlag{
                    self.h006Label.text = "6#:"+"  "+h003Arr[4].crewName+"("+tsFlag+")"
                }else{
                    self.h006Label.text = "6#:"+"  "+h003Arr[4].crewName
                }
            }
        }

        if let selectedBtn = model.isApperence{
            if selectedBtn == "1"{
                self.isApperenceButton.setImage(UIImage.init(named: "checkboxon"), for: .normal)
                self.isApperenceButton.isSelected = true
            }
        }else{
            self.isApperenceButton.setImage(UIImage.init(named: "checkboxoff"), for: .normal)
            self.isApperenceButton.isSelected = false
        }
        
        if let selectedBtn = model.is3Certificate{
            if selectedBtn == "1"{
                self.is3CertificateButton.setImage(UIImage.init(named: "checkboxon"), for: .normal)
                self.is3CertificateButton.isSelected = true
            }
        }else{
            self.is3CertificateButton.setImage(UIImage.init(named: "checkboxoff"), for: .normal)
            self.is3CertificateButton.isSelected = false
        }
    }
    
    // 3证
    @objc func is3BtnClick(_ sender:UIButton){
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            sender.setImage(UIImage.init(named: "checkboxon"), for: .normal)
        }else{
            sender.setImage(UIImage.init(named: "checkboxoff"), for: .normal)
        }
    }
    //仪容
    @objc func iaAppBtnClick(_ sender:UIButton){
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            sender.setImage(UIImage.init(named: "checkboxon"), for: .normal)
        }else{
            sender.setImage(UIImage.init(named: "checkboxoff"), for: .normal)
        }
    }
    @objc func saveBtnClick(_ sender:UIButton){


    }
    //
    @objc func h002Tap(_ tap:UITapGestureRecognizer){
        self.tableView?.removeFromSuperview()
        self.addSubview(tableView!)
        self.index = 0
        tableView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.stewardLabel.snp.right).offset(250)
            make.top.equalTo(self.h002Label.snp.top).offset(0)
            make.width.equalTo(200)
            make.height.equalTo(200)
        })
        self.tableView?.reloadData()
    }
    @objc func h003Tap(_ tap:UITapGestureRecognizer){
        self.tableView?.removeFromSuperview()
        self.addSubview(tableView!)
        self.index = 1
        tableView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.stewardLabel.snp.right).offset(250)
            make.top.equalTo(self.h003Label.snp.top).offset(0)
            make.width.equalTo(200)
            make.height.equalTo(200)
        })
        self.tableView?.reloadData()
    }
    @objc func h004Tap(_ tap:UITapGestureRecognizer){
        self.tableView?.removeFromSuperview()
        self.addSubview(tableView!)
        self.index = 2
        tableView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.stewardLabel.snp.right).offset(250)
            make.top.equalTo(self.h004Label.snp.top).offset(0)
            make.width.equalTo(200)
            make.height.equalTo(200)
        })
        self.tableView?.reloadData()
    }
    @objc func h005Tap(_ tap:UITapGestureRecognizer){
        self.tableView?.removeFromSuperview()
        self.addSubview(tableView!)
        self.index = 3
        tableView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.stewardLabel.snp.right).offset(250)
            make.top.equalTo(self.h005Label.snp.top).offset(0)
            make.width.equalTo(200)
            make.height.equalTo(200)
        })
        self.tableView?.reloadData()
    }
    @objc func h006Tap(_ tap:UITapGestureRecognizer){
        self.tableView?.removeFromSuperview()
        self.addSubview(tableView!)
        self.index = 4
        tableView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.stewardLabel.snp.right).offset(250)
            make.top.equalTo(self.h006Label.snp.top).offset(0)
            make.width.equalTo(200)
            make.height.equalTo(200)
        })
        self.tableView?.reloadData()
    }
    //Delegate DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.h003ModelArr?.count{
            return count
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreFlightPreparationCell", for: indexPath)
        if let model = self.h003ModelArr?[indexPath.row] {
            if let tsFlag = model.tsFlag{
                cell.textLabel?.text = model.crewName+"("+tsFlag+")"
            }else{
                cell.textLabel?.text = model.crewName
            }
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "点击选择更换人员"
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.h003ModelArr?.swapAt(index, indexPath.row)
        self.tableView?.removeFromSuperview()
        self.resetupCrewInfo()
    }
    
}
extension PreFlightPreparationView{
    //重新更新乘务员信息
    func resetupCrewInfo(){
        if let h003Arr = self.h003ModelArr{
            if h003Arr.count>0{
                if let tsFlag = h003Arr[0].tsFlag{
                    self.h002Label.text = "2#:"+"  "+h003Arr[0].crewName+"("+tsFlag+")"
                }else{
                    self.h002Label.text = "2#:"+"  "+h003Arr[0].crewName
                }
            }else{
                self.h002Label.text = "2#:"
            }
        }else{
            self.h002Label.text = "2#:"
        }
        if let h003Arr = self.h003ModelArr{
            if h003Arr.count>1{
                if let tsFlag = h003Arr[1].tsFlag{
                    if h003Arr.count != 3{
                       self.h003Label.text = "3#:"+"  "+h003Arr[1].crewName+"("+tsFlag+")"
                    }else{
                         self.h003Label.text = "4#:"+"  "+h003Arr[1].crewName+"("+tsFlag+")"
                    }
                }else{
                    if h003Arr.count != 3{
                        self.h003Label.text = "3#:"+"  "+h003Arr[1].crewName
                    }else{
                        self.h003Label.text = "4#:"+"  "+h003Arr[1].crewName
                    }
                }
            }else {
                self.h003Label.text = "3#:"
            }
        }else{
            self.h003Label.text = "3#:"
        }
        if let h003Arr = self.h003ModelArr{
            if h003Arr.count>2{
                if let tsFlag = h003Arr[2].tsFlag{
                    if h003Arr.count != 3{
                      self.h004Label.text = "4#:"+"  "+h003Arr[2].crewName+"("+tsFlag+")"
                    }else{
                       self.h004Label.text = "5#:"+"  "+h003Arr[2].crewName+"("+tsFlag+")"
                    }
                }else{
                    if h003Arr.count != 3{
                        self.h004Label.text = "4#:"+"  "+h003Arr[2].crewName
                    }else{
                        self.h004Label.text = "5#:"+"  "+h003Arr[2].crewName
                    }
                }
            }else{
                self.h004Label.text = "4#:"
            }
        }else{
            self.h004Label.text = "4#:"
        }
        if let h003Arr = self.h003ModelArr{
            if h003Arr.count>3{
                if let tsFlag = h003Arr[3].tsFlag{
                    self.h005Label.text = "5#:"+"  "+h003Arr[3].crewName+"("+tsFlag+")"
                }else{
                    self.h005Label.text = "5#:"+"  "+h003Arr[3].crewName
                }
            }
        }
        if let h003Arr = self.h003ModelArr{
            if h003Arr.count>4{
                if let tsFlag = h003Arr[4].tsFlag{
                    self.h006Label.text = "6#:"+"  "+h003Arr[4].crewName+"("+tsFlag+")"
                }else{
                    self.h006Label.text = "6#:"+"  "+h003Arr[4].crewName
                }
            }
        }
    }
}














