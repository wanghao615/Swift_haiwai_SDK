//
//  LoginEmailViewController.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/28.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class LoginEmailViewController: BaseViewController {
    private lazy var loginEmailView: LoginEmailView = {
        let loginEmailView = LoginEmailView()
        return loginEmailView
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        offsetMargin = 50
        addChildView()
        addCallback()
    }
    
    deinit {
        print("\(self) 释放了")
    }
}

extension LoginEmailViewController {
    private func addChildView() {
        view.addSubview(loginEmailView)
        loginEmailView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(SDK.size)
        }
    }
}

extension LoginEmailViewController {
    private func addCallback() {
        loginEmailView.base_backBtnCallback = { [unowned self] in
            self.navigationController?.popViewController(animated: false)
        }
        
        loginEmailView.registerBtnCallback = {[unowned self] in
            self.navigationController?.pushViewController(LoginRegisterViewController(), animated: false)
        }
        
        loginEmailView.loginBtnCallback = { [unowned self]
            (email, pass) in
            guard email.count > 0 else {
                self.view.makeToast(SDK.R.string.bindingEmail_emailAccount)
                return
            }
            guard pass.count > 0 else {
                self.view.makeToast(SDK.R.string.u_pass)
                return
            }
            LoginViewModel.login(email: email, pass: pass, finishCallBack: {
                let title = email + "," + SDK.R.string.login_welcome
                UserCenterSDK.share.loginSuccessWithTitle(title)
            }) { (failedString) in
                self.view.makeToast(failedString)
            }
        }
        
        loginEmailView.forgetBtnCallback = { [unowned self] in
            self.navigationController?.pushViewController(LoginInputEmailViewController(), animated: false)
        }
    }
}
