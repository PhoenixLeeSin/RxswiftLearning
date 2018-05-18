//
//  CrewViewController.swift
//  CrewLogger
//
//  Created by apple on 2018/5/2.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import MJRefresh
import RxDataSources
import RealmSwift

class CrewViewController: UIViewController{
    
    var tableView: UITableView!
    var refreshHeader:MJRefreshHeader!
    let viewModel = FlightViewModel()
    fileprivate let disposeBag = DisposeBag()

    lazy var expandCellStaus:[Bool] = {
        let source = [Bool]()
        return source
    }()
    var selectedCellIndexPaths:[IndexPath] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white


        setupUI()
        bindView()
        
        // 加载数据
        tableView.mj_header.beginRefreshing()
        
        //cellde扩展收缩
        tableView.rx.itemSelected.subscribe(onNext: { indexPath in
            self.tableView.deselectRow(at: indexPath, animated: false)
            if let index = self.selectedCellIndexPaths.index(of: indexPath){
                self.selectedCellIndexPaths.remove(at: index)
            }else{
                self.selectedCellIndexPaths.append(indexPath)
            }
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        })
            .disposed(by:disposeBag)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension CrewViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedCellIndexPaths.contains(indexPath){
            return 300
        }else{
            return 71
        }
    }
}
extension CrewViewController{
    fileprivate func setupUI(){
        self.tableView = UITableView()
        self.tableView!.register(PreFlightPreparationCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view).offset(0)
            make.top.equalTo(self.view.snp.top).offset(44)
            make.bottom.equalTo(self.view.snp.bottom).offset(0)
        }
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
    }
    fileprivate func bindView(){
            
        let dataSource = RxTableViewSectionedReloadDataSource<FlightPlanSection>(configureCell: {(datasource,tableview,indexpath,item) in            
            let cell = tableview.dequeueReusableCell(withIdentifier: "Cell", for: indexpath) as! PreFlightPreparationCell
            cell.cellWith(item)
            cell.submitButton.rx.tap
                .asObservable()
                .throttle(1, scheduler: MainScheduler.instance)
                .subscribe(onNext: { [weak self] _ in
                    let writeVC = WriteInfoViewController()
                    self?.navigationController?.pushViewController(writeVC, animated: true)                    
                })
                .disposed(by:self.disposeBag)
            return cell
        })
        
        let input = FlightViewModel.LeeInput(workcode: self.getUserInfo().username)
        let output = viewModel.transform(input: input)
        
        
        output.sections.asDriver().drive(tableView.rx.items(dataSource: dataSource))
                                  .disposed(by: disposeBag)
        
        output.refreshStatus.asObservable().subscribe(onNext: { [weak self] status  in
            switch status {
            case .beginHeaderRefresh:
                self?.tableView.mj_header.beginRefreshing()
            case .endHeaderRefresh:
                self?.tableView.mj_header.endRefreshing()
            case .beginFooterRefresh:
                self?.tableView.mj_footer.beginRefreshing()
            case .endFooterRefresh:
                self?.tableView.mj_footer.endRefreshing()
            case .noMoreData:
                self?.tableView.mj_footer.endRefreshingWithNoMoreData()
            default:
                break
            }            
        })
            .disposed(by:disposeBag)
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            output.requstCommond.onNext(true)
        })
    }
         /* 获取用户信息*/
   fileprivate func getUserInfo()->User{
        let realm = try! Realm(configuration: RealmConfiguration.shareInstance.setDefaultRealmForUser())
        let users = realm.objects(User.self)
        return users.first!
    }
}
