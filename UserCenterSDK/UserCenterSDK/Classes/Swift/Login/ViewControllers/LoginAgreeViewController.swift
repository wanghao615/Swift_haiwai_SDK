//
//  LoginAgreeViewController.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/29.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit
import class OCModule.BridgeManger

class LoginAgreeViewController: UIViewController {
    private lazy var loginAgreeView: LoginAgreeView = {
        let loginAgreeView = LoginAgreeView()
        loginAgreeView.user_protocol = SDKTool.user_protocol
        loginAgreeView.user_privacy_protocol = SDKTool.user_privacy_protocol
        return loginAgreeView
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

extension LoginAgreeViewController {
    private func addChildView() {
        view.addSubview(loginAgreeView)
        loginAgreeView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(SDK.size)
        }
    }
}

extension LoginAgreeViewController {
    private func addCallback() {
        loginAgreeView.base_backBtnCallback = { [unowned self] in
            self.navigationController?.popViewController(animated: false)
        }
    }
}
