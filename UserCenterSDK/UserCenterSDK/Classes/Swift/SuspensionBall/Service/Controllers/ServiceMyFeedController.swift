//
//  ServiceMyFeedController.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/3.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class ServiceMyFeedController: UIViewController {
    private var pageSize: Int = 1

    private lazy var myFeedView: ServiceMyFeedView = {
        let myFeedView = ServiceMyFeedView()
        return myFeedView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildView()
        addCallback()
        loadRequest()
    }
    
    deinit {
        print("\(self) 释放了")
    }
}

extension ServiceMyFeedController {
    fileprivate func addChildView() {
        view.addSubview(myFeedView)
        myFeedView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(SDK.severSize)
        }
    }
}

extension ServiceMyFeedController {
    fileprivate func addCallback() {
        myFeedView.base_exitBtnCallback = {
            UserCenterSDK.share.gotoGame()
        }
        
        myFeedView.base_backBtnCallback = { [unowned self] in
            self.navigationController?.popViewController(animated: false)
        }
        
        myFeedView.loadMoreDataCallback = { [unowned self] in
            self.pageSize += 1
            ServiceViewModel.feedList(page: String(self.pageSize), finishCallBack: {
                (feedlistModels) in
                self.myFeedView.moreListModels = feedlistModels
            }) { (failedString) in
                self.view.makeToast(failedString)
            }
        }
        
        myFeedView.selectRowCallback = { [unowned self] 
            (myFeedListModel) in
            let detailVC = ServiceMyFeedDetailViewController()
            detailVC.status = myFeedListModel.status
            detailVC.feedId = myFeedListModel.feedId
            self.navigationController?.pushViewController(detailVC, animated: false)
        }
    }
}

extension ServiceMyFeedController {
    fileprivate func loadRequest() {
        ServiceViewModel.feedList(page: "1", finishCallBack: {
            (feedlistModels) in
            self.myFeedView.listModels = feedlistModels
        }) { (failedString) in
            self.view.makeToast(failedString)
        }
    }
}
