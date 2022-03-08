//
//  BindingEmailViewController.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/24.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit
import class OCModule.BridgeManger
import class OCModule.Statistics

class BindingEmailViewController: BaseViewController {
    var type: AccountType? {
        didSet {
            switch type {
            case .bind:
                bindingEmailView.base_title = SDK.R.string.u_bindingAccount
            case .upgrade:
                bindingEmailView.base_title = SDK.R.string.accountUpgrade_a
            default:
                break
            }
        }
    }
    
    private var emailTimer: String?
    
    private lazy var bindingEmailView: BindingEmailView = {
        let bindingEmailView = BindingEmailView()
        return bindingEmailView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildView()
        addCallback()
        offsetMargin = 80
    }
    
    deinit {
        print("\(self) 释放了")
        GCDTimer.cancelTask(emailTimer)
    }
}

extension BindingEmailViewController: BindingEmailProtocol {
    func type(_ type: AccountType) {
        switch type {
        case .bind:
            bindingEmailView.base_title = SDK.R.string.u_bindingAccount
        case .upgrade:
            bindingEmailView.base_title = SDK.R.string.accountUpgrade_a
        default:
            break
        }
    }
}

extension BindingEmailViewController {
    private func addChildView() {
        view.addSubview(bindingEmailView)
        bindingEmailView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(SDK.bindingEmailSize)
        }
    }
}

extension BindingEmailViewController {
    private func addCallback() {
        bindingEmailView.base_exitBtnCallback = {
            UserCenterSDK.share.gotoGame()
        }
        
        bindingEmailView.base_backBtnCallback = { [unowned self] in
            self.navigationController?.popViewController(animated: false)
        }
        
        bindingEmailView.smsBtnCallback = { [unowned self]
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
            
            SWUViewModel.sendEmailSMSCode(type: self.type == .bind ? "4" : "6", auth_token: "", email: email, userName: email) { (failedString) in
                self.view.makeToast(failedString)
            }
        }
        
        bindingEmailView.sumitBtnCallback = { [unowned self] 
            (email, code, pass) in
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
            if self.type == .bind {
                BindingEmailViewModel.bind(username: email, code: code, pass: pass, finishCallBack: {
                    let successVC = U_SuccessViewController()
                    successVC.topTitle = SDK.R.string.u_bindingAccount
                    successVC.titleS = SDK.R.string.bindingEmail_success
                    successVC.type = successType.bindingEmailModule
                    self.navigationController?.pushViewController(successVC, animated: false)
                }) { (failedString) in
                    self.view.makeToast(failedString)
                }
            }else {
                BindingEmailViewModel.upgrade(email: email, pass: pass, code: code, finishCallBack: {
                    Statistics.upAccount()
                    let successVC = U_SuccessViewController()
                    successVC.topTitle = SDK.R.string.accountUpgrade_a
                    successVC.titleS = SDK.R.string.accountUpgrade_bindingSuccess
                    successVC.type = successType.bindingEmailModule
                    self.navigationController?.pushViewController(successVC, animated: false)
                    UserCenterSDK.share.changeBallStatus()
                }) { (failedString) in
                    self.view.makeToast(failedString)
                }
            }
        }
    }
}
