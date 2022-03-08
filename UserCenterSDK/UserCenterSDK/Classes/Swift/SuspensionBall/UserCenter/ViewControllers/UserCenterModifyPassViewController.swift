//
//  UserCenterModifyPassViewController.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/18.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class UserCenterModifyPassViewController: BaseViewController {
    private var type: Int
    private var auth_token: String
    private var phoneN: String
    private var email: String
    private var zone: String
    
    private var emailTimer: String?
    private var phoneTimer: String?

    private lazy var modifyPassView: UserCenterModifyPassView = {
        let modifyPassView = UserCenterModifyPassView(frame: .zero, type: type, phoneN: phoneN, email: email)
        return modifyPassView
    }()
    
    init(type: Int, auth_token: String, phoneN: String, email: String, zone: String) {
        self.type = type
        self.auth_token = auth_token
        self.phoneN = phoneN
        self.email = email
        self.zone = zone
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildView()
        addCallBack()
        offsetMargin = 70
    }
    
    deinit {
        print("\(self) 释放了")
        GCDTimer.cancelTask(emailTimer)
        GCDTimer.cancelTask(phoneTimer)
    }
}

extension UserCenterModifyPassViewController {
    private func addChildView() {
        view.addSubview(modifyPassView)
        modifyPassView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(SDK.size)
        }
    }
}

extension UserCenterModifyPassViewController {
    private func addCallBack() {
        modifyPassView.base_exitBtnCallback = {
            UserCenterSDK.share.gotoGame()
        }
        
        modifyPassView.base_backBtnCallback = { [unowned self] in
            self.navigationController?.popViewController(animated: false)
        }
        
        modifyPassView.byEmailView.textField.rightBtnCallback = { [unowned self]
            (btn: UIButton) in
            self.emailTimer = GCDTimer.execTask({
                (timeN) in
                btn.setTitle("\(timeN)s", for: .normal)
                btn.isEnabled = false
            }) {//倒计时完成
                btn.setTitle(SDK.R.string.usercenter_sendCodeAgain, for: .normal)
                btn.isEnabled = true
            }
            
            //发送验证码
            SWUViewModel.sendEmailSMSCode(type: "3", auth_token: self.auth_token, failed: { (failedString) in
                self.view.makeToast(failedString)
            })
        }
        
        modifyPassView.byPhoneView.byEmailView.textField.rightBtnCallback = { [unowned self]
            (btn: UIButton) in
            self.phoneTimer = GCDTimer.execTask({
                (timeN) in
                btn.setTitle("\(timeN)s", for: .normal)
                btn.isEnabled = false
            }) {//倒计时完成
                btn.setTitle(SDK.R.string.usercenter_sendCodeAgain, for: .normal)
                btn.isEnabled = true
            }
            SWUViewModel.sendPhoneSMSCode(type: "3", zone: self.zone, auth_token: self.auth_token, failed: { (failedString) in
                self.view.makeToast(failedString)
            })
        }
        
        //校验原密码
        modifyPassView.byPassView.nextBtnCallback = { [unowned self]
            (pass: String) in
            guard pass.count > 0 else {
                self.view.makeToast(SDK.R.string.u_pass)
                return
            }
            UserCenterViewModel.checkPass(pass: pass, finishCallBack: {
                let UserCenterNewPassVC = UserCenterNewPassViewController()
                UserCenterNewPassVC.pass = pass
                self.navigationController?.pushViewController(UserCenterNewPassVC, animated: false)
            }) { (failedString) in
                self.view.makeToast(failedString)
            }
        }
        
        //校验验证码
        modifyPassView.byEmailView.nextBtnCallback = { [unowned self]
            (code: String) in
            guard code.count > 0 else {
                self.view.makeToast(SDK.R.string.u_smsCode)
                return
            }
            SWUViewModel.checkEmailCode(type: "3", code: code, auth_token: self.auth_token, finishCallBack: {
                let UserCenterNewPassVC = UserCenterNewPassViewController()
                UserCenterNewPassVC.auth_token = self.auth_token
                UserCenterNewPassVC.code = code
                UserCenterNewPassVC.type = "0"
                self.navigationController?.pushViewController(UserCenterNewPassVC, animated: false)
            }) { (failedString) in
                self.view.makeToast(failedString)
            }
        }
        
        //校验验证码
        modifyPassView.byPhoneView.byEmailView.nextBtnCallback = { [unowned self] 
            (code: String) in
            guard code.count > 0 else {
                self.view.makeToast(SDK.R.string.u_smsCode)
                return
            }
            SWUViewModel.checkPhoneCode(type: "3", zone: self.zone, code: code, auth_token: self.auth_token, finishCallBack: {
                let UserCenterNewPassVC = UserCenterNewPassViewController()
                UserCenterNewPassVC.auth_token = self.auth_token
                UserCenterNewPassVC.code = code
                UserCenterNewPassVC.type = "1"
                self.navigationController?.pushViewController(UserCenterNewPassVC, animated: false)
            }) { (failedString) in
                self.view.makeToast(failedString)
            }
        }
    }
}
