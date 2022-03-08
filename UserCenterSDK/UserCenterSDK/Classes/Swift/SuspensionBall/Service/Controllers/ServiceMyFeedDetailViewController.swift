//
//  ServiceMyFeedDetailViewController.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/7.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class ServiceMyFeedDetailViewController: UIViewController {
    var status: Int?
    var feedId: Int?

    private lazy var myFeedDetailView: ServiceMyFeedDetailView = {
        let myFeedDetailView = ServiceMyFeedDetailView()
        return myFeedDetailView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildView()
        addCallback()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestHead()
        requestList()
    }
    
    deinit {
        print("\(self) 释放了")
    }
}

extension ServiceMyFeedDetailViewController {
    private func addChildView() {
        view.addSubview(myFeedDetailView)
        myFeedDetailView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(SDK.severSize)
        }
    }
}

extension ServiceMyFeedDetailViewController {
    private func addCallback() {
        myFeedDetailView.base_backBtnCallback = { [unowned self] in
            self.navigationController?.popViewController(animated: false)
        }
        
        myFeedDetailView.base_exitBtnCallback = {
            UserCenterSDK.share.gotoGame()
        }
        
        myFeedDetailView.additionalQCallback = { [unowned self] in
            let additionalQVC = ServiceAdditionalQViewController()
            additionalQVC.feedId = self.feedId
            self.navigationController?.pushViewController(additionalQVC, animated: false)
        }
    }
}

extension ServiceMyFeedDetailViewController {
    private func requestHead() {
        guard let feedId = feedId else { return }
        ServiceViewModel.feedDetail(detailId: feedId, finishCallBack: {
           (detailModel) in
            self.myFeedDetailView.detailModel = detailModel
        }) { (failedString) in
            self.view.makeToast(failedString)
        }
    }
    
    private func requestList() {
        guard let feedId = feedId else { return }
        ServiceViewModel.feedReplyLsit(feedId: feedId, finishCallBack: {
            (replyListModels) in
            self.myFeedDetailView.replyListModels = replyListModels
        }) { (failedString) in
            self.view.makeToast(failedString)
        }
    }
}


