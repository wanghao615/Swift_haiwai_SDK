//
//  LoginRetrievePassViewController.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/29.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class LoginRetrievePassViewController: BaseViewController {
    
    private var emailTimer: String?
    private var emailAndPhone_emailTimer: String?
    private var emailAndPhone_phoneTimer: String?
    
    private lazy var loginRetrievePassView: LoginRetrievePassView = {
        let loginRetrievePassView = LoginRetrievePassView.init(frame: .zero, email: formatEmail ?? "", phone: phone)
        return loginRetrievePassView
    }()
    
    private var email: String
    private var formatEmail: String?
    private var auth_token: String?
    private var phone: String?
    private var zone: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        offsetMargin = 80
        addChildView()
        addCallback()
    }
    
    init(email: String, formatEmail: String?, auth_token: String?, phone: String?, zone: String?) {
        self.email = email
        self.formatEmail = formatEmail
        self.auth_token = auth_token
        self.phone = phone
        self.zone = zone
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("\(self) 释放了")
        GCDTimer.cancelTask(emailTimer)
        GCDTimer.cancelTask(emailAndPhone_emailTimer)
        GCDTimer.cancelTask(emailAndPhone_phoneTimer)
    }
}

extension LoginRetrievePassViewController {
    private func addChildView() {
        view.addSubview(loginRetrievePassView)
        loginRetrievePassView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(SDK.size)
        }
    }
}

extension LoginRetrievePassViewController {
    private func addCallback() {
        loginRetrievePassView.base_backBtnCallback = { [unowned self] in
            self.navigationController?.popViewController(animated: false)
        }
        
        loginRetrievePassView.emailView.textField.rightBtnCallback = { [unowned self]
            (btn: UIButton) in
            self.emailTimer = GCDTimer.execTask({
                (timeN) in
                btn.setTitle("\(timeN)s", for: .normal)
                btn.isEnabled = false
            }) {//倒计时完成
                btn.setTitle(SDK.R.string.usercenter_sendCodeAgain, for: .normal)
                btn.isEnabled = true
            }
            SWUViewModel.sendEmailSMSCode(type: "3", auth_token: self.auth_token ?? "", email: self.email, userName: self.email) { (failedString) in
                self.view.makeToast(failedString)
            }
        }
        
        loginRetrievePassView.emailView.nextBtnCallback = { [unowned self]
            (code) in
            guard code.count > 0 else {
                self.view.makeToast(SDK.R.string.u_smsCode)
                return
            }
            SWUViewModel.checkEmailCode(type: "3", code: code, auth_token: self.auth_token ?? "", finishCallBack: {
                let newPassVC = LoginNewPassViewController()
                newPassVC.auth_token = self.auth_token ?? ""
                newPassVC.code = code
                newPassVC.type = "0"
                newPassVC.email = self.email
                self.navigationController?.pushViewController(newPassVC, animated: false)
            }) { (failedString) in
                self.view.makeToast(failedString)
            }
        }
        
        loginRetrievePassView.emailAndPhone.emailView.textField.rightBtnCallback = { [unowned self]
            (btn: UIButton) in
            self.emailAndPhone_emailTimer = GCDTimer.execTask({
                (timeN) in
                btn.setTitle("\(timeN)s", for: .normal)
                btn.isEnabled = false
            }) {//倒计时完成
                btn.setTitle(SDK.R.string.usercenter_sendCodeAgain, for: .normal)
                btn.isEnabled = true
            }
            SWUViewModel.sendEmailSMSCode(type: "3", auth_token: self.auth_token ?? "", email: self.email, userName: self.email) { (failedString) in
                self.view.makeToast(failedString)
            }
        }
        
        loginRetrievePassView.emailAndPhone.emailView.nextBtnCallback = { [unowned self]
            (code) in
            guard code.count > 0 else {
                self.view.makeToast(SDK.R.string.u_smsCode)
                return
            }
            SWUViewModel.checkEmailCode(type: "3", code: code, auth_token: self.auth_token ?? "", finishCallBack: {
                let newPassVC = LoginNewPassViewController()
                newPassVC.auth_token = self.auth_token ?? ""
                newPassVC.code = code
                newPassVC.type = "0"
                newPassVC.email = self.email
                self.navigationController?.pushViewController(newPassVC, animated: false)
            }) { (failedString) in
                self.view.makeToast(failedString)
            }
        }
        
        loginRetrievePassView.emailAndPhone.phoneView.textField.rightBtnCallback = { [unowned self]
            (btn: UIButton) in
            self.emailAndPhone_phoneTimer = GCDTimer.execTask({
                (timeN) in
                btn.setTitle("\(timeN)s", for: .normal)
                btn.isEnabled = false
            }) {//倒计时完成
                btn.setTitle(SDK.R.string.usercenter_sendCodeAgain, for: .normal)
                btn.isEnabled = true
            }
            SWUViewModel.sendPhoneSMSCode(type: "3", zone: self.zone ?? "", auth_token: self.auth_token ?? "") { (failedString) in
                self.view.makeToast(failedString)
            }
        }
        
        loginRetrievePassView.emailAndPhone.phoneView.nextBtnCallback = { [unowned self] 
            (code) in
            guard code.count > 0 else {
                self.view.makeToast(SDK.R.string.u_smsCode)
                return
            }
            SWUViewModel.checkPhoneCode(type: "3", zone: self.zone ?? "", code: code, auth_token: self.auth_token ?? "", finishCallBack: {
                let newPassVC = LoginNewPassViewController()
                newPassVC.auth_token = self.auth_token ?? ""
                newPassVC.code = code
                newPassVC.type = "1"
                newPassVC.email = self.email
                self.navigationController?.pushViewController(newPassVC, animated: false)
            }) { (failedString) in
                self.view.makeToast(failedString)
            }
        }
    }
}
