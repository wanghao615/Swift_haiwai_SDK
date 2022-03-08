//
//  UserPtotocolDetailViewController.swift
//  KingNetSDK
//
//  Created by admin on 2021/1/6.
//  Copyright © 2021 niujf. All rights reserved.
//

import UIKit

class UserPtotocolDetailViewController: UIViewController {
    var titleS: String? {
        didSet {
            userProtocolDetailView.title = titleS
        }
    }
    
    var content: String? {
        didSet {
            userProtocolDetailView.content = content
        }
    }
    
    private lazy var userProtocolDetailView: UserProtocolDetailView = {
        let userProtocolDetailView = UserProtocolDetailView()
        return userProtocolDetailView
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

extension UserPtotocolDetailViewController {
    private func addChildView() {
        view.addSubview(userProtocolDetailView)
        userProtocolDetailView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(SDK.size)
        }
    }
}

extension UserPtotocolDetailViewController {
    private func addCallback() {
        userProtocolDetailView.base_exitBtnCallback = { [unowned self] in
            self.navigationController?.popViewController(animated: false)
        }
    }
}
