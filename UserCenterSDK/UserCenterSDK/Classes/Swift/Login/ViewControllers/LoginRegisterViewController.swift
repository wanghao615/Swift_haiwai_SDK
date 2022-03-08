//
//  LoginRegisterViewController.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/28.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit
import class OCModule.Statistics

class LoginRegisterViewController: BaseViewController {
    
    private var emailTimer: String?
    
    private lazy var loginRegisterView: LoginRegisterView = {
        let loginRegisterView = LoginRegisterView()
        return loginRegisterView
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        offsetMargin = 60
        addChildView()
        addCallback()
    }
    
    deinit {
        print("\(self) 释放了")
        GCDTimer.cancelTask(emailTimer)
    }

}

extension LoginRegisterViewController {
    private func addChildView() {
        view.addSubview(loginRegisterView)
        loginRegisterView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(SDK.registerSize)
        }
    }
}

extension LoginRegisterViewController {
    private func addCallback() {
        loginRegisterView.base_backBtnCallback = { [unowned self] in
            self.navigationController?.popViewController(animated: false)
        }
        
        loginRegisterView.codeCallback = { [unowned self]
            (btn: UIButton, email) in
            guard email.count > 0 else {
                self.view.makeToast(SDK.R.string.bindingEmail_emailAccount)
                return
            }
            self.emailTimer = GCDTimer.execTask({
                (timeN) in
                btn.setTitle("\(timeN)s", for: .normal)
                btn.isEnabled = false
            }) {//倒计时完成
                btn.setTitle(SDK.R.string.usercenter_sendCodeAgain, for: .normal)
                btn.isEnabled = true
            }
            SWUViewModel.sendEmailSMSCode(type: "5", auth_token: "", email: email, userName: email) { (failedString) in
                self.view.makeToast(failedString)
            }
        }
        
        loginRegisterView.agreeContentCallback = { [unowned self] in
            let agreeVC = LoginAgreeViewController()
            self.navigationController?.pushViewController(agreeVC, animated: false)
        }
        
        loginRegisterView.loginBtnCallback = { [unowned self] 
            (email, code, pass, isAgree: Bool) in
            guard email.count > 0 else {
                self.view.makeToast(SDK.R.string.bindingEmail_emailAccount)
                return
            }
            guard code.count > 0 else {
                self.view.makeToast(SDK.R.string.u_smsCode)
                return
            }
            guard pass.count > 0 else {
                self.view.makeToast(SDK.R.string.u_pass)
                return
            }
            guard isAgree else {
                self.view.makeToast(SDK.R.string.login_agreeTips)
                return
            }
            Statistics.clickRegister()
            LoginViewModel.register(email: email, code: code, pass: pass, finishCallBack: {
                UserCenterSDK.share.loginSuccessWithTitle("")
                let successVC = U_SuccessViewController()
                successVC.topTitle = SDK.R.string.login_register
                successVC.titleS = SDK.R.string.login_startGame
                successVC.type = successType.loginModule
                self.navigationController?.pushViewController(successVC, animated: false)
            }) { (failedString) in
                self.view.makeToast(failedString)
            }
        }
    }
}
