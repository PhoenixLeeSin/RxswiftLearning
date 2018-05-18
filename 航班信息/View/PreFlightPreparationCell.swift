//
//  PreFlightPreparationCell.swift
//  CrewLog
//
//  Created by apple on 2017/12/8.
//  Copyright © 2017年 LeeSin. All rights reserved.
//

import UIKit
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
class PreFlightPreparationCell: UITableViewCell {

   //1 航班日期
    lazy var flightDataLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    // 2机号
    lazy var acRegLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    // 3航线
    lazy var flightVoyageLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    // 4计划时间 起飞-到达
    lazy var planTimeLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    // 5航班状态
    lazy var flightStatusLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.black
        label.text = "计划中"
        label.textAlignment = .center
        return label
    }()
    // 6提交按钮
    lazy var submitButton:UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        return button
    }()
    lazy var lineView:UIView = {
        let line = UIView()
        line.backgroundColor = LineViewColor
        return line
    }()
    
    //航班号
    lazy var exflightNoLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = TextColor_Flight
        label.textAlignment = .left
        return label
    }()
    //航班日期
    lazy var exfligtDateLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = TextColor_Flight
        label.textAlignment = .left
        return label
    }()
    //复制按钮
    lazy var copyButton:UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        return button
    }()
    //到岗时间
    lazy var exarrivalTimeLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = TextColor_Flight
        label.textAlignment = .left
        return label
    }()
    //进场时间
    lazy var exenterTimeLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = TextColor_Flight
        label.textAlignment = .left
        return label
    }()
    //机型
    lazy var exacTypeLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = TextColor_Flight
        label.textAlignment = .left
        return label
    }()
    //机号
    lazy var exacRegLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = TextColor_Flight
        label.textAlignment = .left
        return label
    }()
    //航线
    lazy var exflightVoyageLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = TextColor_Flight
        label.textAlignment = .left
        return label
    }()
    //计划时间
    lazy var explanTimeLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = TextColor_Flight
        label.textAlignment = .left
        return label
    }()
    //机长
    lazy var excaptainLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = TextColor_Flight
        label.textAlignment = .left
        return label
    }()
    //乘务长
    lazy var exh001Label:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = TextColor_Flight
        label.textAlignment = .left
        return label
    }()
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setUpUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpUI(){
        self.contentView.addSubview(flightDataLabel)
        self.contentView.addSubview(acRegLabel)
        self.contentView.addSubview(flightVoyageLabel)
        self.contentView.addSubview(planTimeLabel)
        self.contentView.addSubview(flightStatusLabel)
        self.contentView.addSubview(submitButton)
        self.contentView.addSubview(lineView)
        
        self.contentView.addSubview(exflightNoLabel)
        self.contentView.addSubview(exfligtDateLabel)
        self.contentView.addSubview(copyButton)
        self.contentView.addSubview(exarrivalTimeLabel)
        self.contentView.addSubview(exenterTimeLabel)
        self.contentView.addSubview(exacTypeLabel)
        self.contentView.addSubview(exacRegLabel)
        self.contentView.addSubview(exflightVoyageLabel)
        self.contentView.addSubview(explanTimeLabel)
        self.contentView.addSubview(excaptainLabel)
        self.contentView.addSubview(exh001Label)

        self.flightDataLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(10)
            make.top.equalTo(self.contentView.snp.top).offset(15).priority(999)
            make.height.equalTo(50).priority(999)
            make.width.equalTo(self.acRegLabel.snp.width)
        }
        self.acRegLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.flightDataLabel.snp.right).offset(10)
            make.top.equalTo(self.contentView.snp.top).offset(15)
            make.height.equalTo(50)
            make.width.equalTo(self.flightVoyageLabel.snp.width)
        }
        self.flightVoyageLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.acRegLabel.snp.right).offset(10)
            make.top.equalTo(self.contentView.snp.top).offset(15)
            make.height.equalTo(50)
            make.width.equalTo(self.planTimeLabel.snp.width)
        }
        self.planTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.flightVoyageLabel.snp.right).offset(10)
            make.top.equalTo(self.contentView.snp.top).offset(15)
            make.height.equalTo(50)
            make.width.equalTo(self.flightStatusLabel.snp.width)
        }
        self.flightStatusLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.planTimeLabel.snp.right).offset(10)
            make.top.equalTo(self.contentView.snp.top).offset(15)
            make.height.equalTo(50)
            make.width.equalTo(self.submitButton.snp.width)
        }
        self.submitButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView.snp.right).offset(-10)
            make.top.equalTo(self.contentView.snp.top).offset(15)
            make.height.equalTo(40)
            make.left.equalTo(self.flightStatusLabel.snp.right).offset(10)
        }        
        self.lineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.contentView).offset(0)
            make.top.equalTo(self.flightDataLabel.snp.bottom).offset(5)
            make.height.equalTo(1)
        }
        
        self.exflightNoLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(30)
            make.right.equalTo(self.contentView.snp.centerX).offset(0)
            make.top.equalTo(self.lineView.snp.bottom).offset(0)
            make.height.equalTo(self.exarrivalTimeLabel.snp.height)
        }
        self.exfligtDateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.centerX).offset(0)
            make.right.equalTo(self.contentView.snp.right).offset(-80)
            make.top.equalTo(self.lineView.snp.bottom).offset(0)
            make.height.equalTo(self.exarrivalTimeLabel.snp.height)
        }
        self.copyButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.exfligtDateLabel.snp.right).offset(10)
            make.right.equalTo(self.contentView.snp.right).offset(-10)
            make.top.equalTo(self.lineView.snp.bottom).offset(0)
            make.height.equalTo(self.exarrivalTimeLabel.snp.height)
        }
        self.exarrivalTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(30)
            make.right.equalTo(self.contentView.snp.centerX).offset(0)
            make.top.equalTo(self.exflightNoLabel.snp.bottom).offset(0)
            make.height.equalTo(self.exacTypeLabel.snp.height)
        }
        self.exenterTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.centerX).offset(0)
            make.right.equalTo(self.contentView.snp.right).offset(0)
            make.top.equalTo(self.exfligtDateLabel.snp.bottom).offset(0)
            make.height.equalTo(self.exacTypeLabel.snp.height)
        }
        self.exacTypeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(30)
            make.right.equalTo(self.contentView.snp.centerX).offset(0)
            make.top.equalTo(self.exarrivalTimeLabel.snp.bottom).offset(0)
            make.height.equalTo(self.exflightVoyageLabel.snp.height)
        }
        self.exacRegLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.centerX).offset(0)
            make.right.equalTo(self.contentView.snp.right).offset(0)
            make.top.equalTo(self.exenterTimeLabel.snp.bottom).offset(0)
            make.height.equalTo(self.exflightVoyageLabel.snp.height)
        }
        self.exflightVoyageLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(30)
            make.right.equalTo(self.contentView.snp.centerX).offset(0)
            make.top.equalTo(self.exacTypeLabel.snp.bottom).offset(0)
            make.height.equalTo(self.excaptainLabel.snp.height)
        }
        self.explanTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.centerX).offset(0)
            make.right.equalTo(self.contentView.snp.right).offset(0)
            make.top.equalTo(self.exacRegLabel.snp.bottom).offset(0)
            make.height.equalTo(self.excaptainLabel.snp.height)
        }
        self.excaptainLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(30)
            make.right.equalTo(self.contentView.snp.centerX).offset(0)
            make.top.equalTo(self.exflightVoyageLabel.snp.bottom).offset(0)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(0)
        }
        self.exh001Label.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.centerX).offset(0)
            make.right.equalTo(self.contentView.snp.right).offset(0)
            make.top.equalTo(self.explanTimeLabel.snp.bottom).offset(0)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(0)
        }
        //
    }

    func cellWith(_ model:FlightPlanModel){
        self.flightDataLabel.text = model.flightDate
        self.acRegLabel.text = model.flightNo
        self.flightVoyageLabel.text = model.flightVoyage
        self.planTimeLabel.text = model.planTime
        self.flightStatusLabel.text = model.flightStatus
        if flightStatusLabel.text == "计划中"{
            self.flightStatusLabel.textColor = BlueColor_FlightStatus
        }else if  flightStatusLabel.text == "开舱门"{
            self.flightStatusLabel.textColor = GreenColor_FlightStatus
        }else if flightStatusLabel.text == "关舱门"{
            self.flightStatusLabel.textColor = RedColor_FlightStatus
        }else if flightStatusLabel.text == "已滑入"{
            self.flightStatusLabel.textColor = OrangeColor_FlightStatus
        }

        //是否‘填写’
         let isUpdate = model.isUpdate
            if isUpdate == 3{
                self.submitButton.setTitle("已填写", for: .normal)
                self.submitButton.setTitleColor(GrayColor, for: .normal)
                self.submitButton.backgroundColor = BtnColor_Flight
            }else{
                self.submitButton.setTitle("去填写", for: .normal)
                self.submitButton.setTitleColor(WhiteColor, for: .normal)
                self.submitButton.backgroundColor = BlueColor_FlightStatus
            }            
        self.copyButton.setTitle("复制", for: .normal)
        self.copyButton.setTitleColor(WhiteColor, for: .normal)
        self.copyButton.backgroundColor = BlueColor_FlightStatus
        
        if let flightNo = model.flightNo{
            self.exflightNoLabel.text = "航班号:"+"  "+flightNo
        }else{
            self.exflightNoLabel.text = "航班号:"
        }
        if let flightDate = model.flightDate{
            self.exfligtDateLabel.text = "航班日期:"+"  "+flightDate
        }else{
            self.exfligtDateLabel.text = "航班日期:"
        }
        if let arrivalTime = model.arrivalTime{
            self.exarrivalTimeLabel.text = "到岗时间:"+arrivalTime
        }else{
            self.exarrivalTimeLabel.text = "到岗时间:"
        }
        if let enterTime = model.enterTime{
            self.exenterTimeLabel.text = "进场时间:"+"  "+enterTime
        }else{
            self.exenterTimeLabel.text = "进场时间:"
        }
        if let acReg = model.acReg{
            self.exacRegLabel.text = "机号:"+"  "+acReg
        }else{
            self.exacRegLabel.text = "机号:"
        }
        if let acType = model.acType{
            self.exacTypeLabel.text = "机型:"+"  "+acType
        }else{
            self.exacTypeLabel.text = "机型:"
        }
        if let flightVoyage = model.flightVoyage{
            self.exflightVoyageLabel.text = "航线:"+"  "+flightVoyage
        }else{
            self.exflightVoyageLabel.text = "航线:"
        }
        if let planTime = model.planTime{
            self.explanTimeLabel.text = "计划时间:"+"  "+planTime
        }else{
            self.explanTimeLabel.text = "计划时间:"
        }
        if let captain = model.captain{
            self.excaptainLabel.text = "机长:"+"  "+captain
        }else{
            self.excaptainLabel.text = "机长:"
        }
        if let h001 = model.h001Name{
            self.exh001Label.text = "乘务长:"+"  "+h001
        }else{
            self.exh001Label.text = "乘务长:"
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
