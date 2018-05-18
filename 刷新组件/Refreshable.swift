//
//  Refreshable.swift
//  CrewLogger
//
//  Created by apple on 2018/5/11.
//  Copyright © 2018年 apple. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import MJRefresh

enum LeeRefreshStatus {
    case none
    case beginHeaderRefresh
    case endHeaderRefresh
    case beginFooterRefresh
    case endFooterRefresh
    case noMoreData
}

/* ============================ OutputRefreshProtocol ================================ */
// viewModel 中 output使用
protocol OutputRefreshProtocol {
     // 告诉外界的tableView当前的刷新状态
    var refreshStatus:Variable<LeeRefreshStatus>{get}
   
}
extension OutputRefreshProtocol {
    func autoSetRefreshHeaderStatus(header:MJRefreshHeader?,footer:MJRefreshFooter?)->Disposable{
        return refreshStatus.asObservable().subscribe(onNext: {  (status) in
            switch status{
            case .beginHeaderRefresh:
                header?.beginRefreshing()
            case .endHeaderRefresh:
                header?.endRefreshing()
            case .beginFooterRefresh:
                footer?.beginRefreshing()
            case .endFooterRefresh:
                footer?.endRefreshing()
            case .noMoreData:
                header?.endRefreshing()
                footer?.endRefreshingWithNoMoreData()
            default:
                break
            }
        })
        
    }
}
/* ============================ Refreshable ================================ */
// 需要使用 MJExtension 的控制器使用
protocol Refreshable {
    
}
extension Refreshable where Self:UIViewController{
    func initRefreshHeader(_ scrollView:UIScrollView,_ action:@escaping ()->Void)->MJRefreshHeader{
        scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            action()
        })
        return scrollView.mj_header
    }
    func initRefreshFooter(_ scrollView:UIScrollView,_ action:@escaping ()->Void)->MJRefreshFooter{
        scrollView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            action()
        })
        return scrollView.mj_footer
    }
}

extension Refreshable where Self:UIScrollView{
    func initRefreshHeader(_ action:@escaping ()->Void)->MJRefreshHeader{
        mj_header = MJRefreshNormalHeader(refreshingBlock: {
            action()
        })
        return mj_header
    }
    func initRefreshFooter(_ action:@escaping ()->Void)->MJRefreshFooter{
        mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            action()
        })
        return mj_footer
    }
}

















