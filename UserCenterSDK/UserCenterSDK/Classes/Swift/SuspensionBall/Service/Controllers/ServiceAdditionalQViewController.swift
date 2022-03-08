//
//  ServiceAdditionalQViewController.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/7.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class ServiceAdditionalQViewController: UIViewController {
    
    var feedId: Int?
    
    private lazy var additionalQView: ServiceAdditionalQView = {
        let additionalQView = ServiceAdditionalQView()
        return additionalQView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildView()
        addCallback()
    }
    
    deinit {
        print("\(self) 释放了")
    }
}

extension ServiceAdditionalQViewController {
    private func addChildView() {
        view.addSubview(additionalQView)
        additionalQView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(SDK.severSize)
        }
    }
}

extension ServiceAdditionalQViewController {
    private func addCallback() {
        additionalQView.base_backBtnCallback = { [unowned self] in
            self.navigationController?.popViewController(animated: false)
        }
        
        additionalQView.base_exitBtnCallback = {
            UserCenterSDK.share.gotoGame()
        }
        
        additionalQView.sumitCallback = { [unowned self] 
            (text) in
            guard let feedId = self.feedId else { return }
            ServiceViewModel.feedReply(feedId: feedId, replyContent: text, finishCallBack: {
                self.navigationController?.popViewController(animated: false)
            }) { (failedString) in
                self.view.makeToast(failedString)
            }
        }
    }
}
