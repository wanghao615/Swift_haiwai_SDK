//
//  LoginNewPassViewController.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/29.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit
import class OCModule.Statistics

class LoginNewPassViewController: BaseViewController {
    var auth_token: String = ""
    var code: String = ""
    var type: String = ""
    var email: String = ""
    
    private lazy var loginNewPassView: LoginNewPassView = {
        let loginNewPassView = LoginNewPassView()
        return loginNewPassView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        offsetMargin = 80
        addChildView()
        addCallback()
    }
    
    deinit {
        print("\(self) 释放了")
    }
}

extension LoginNewPassViewController {
    private func addChildView() {
        view.addSubview(loginNewPassView)
        loginNewPassView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(SDK.size)
        }
    }
}

extension LoginNewPassViewController {
    private func addCallback() {
        loginNewPassView.base_backBtnCallback = { [unowned self] in
            self.navigationController?.popViewController(animated: false)
        }
        
        loginNewPassView.sumitBtnCallback = { [unowned self]
           (pass: String, againPass: String) in
           guard pass.count > 0 else {
               self.view.makeToast(SDK.R.string.u_pass)
               return
           }
           guard againPass.count > 0 else {
               self.view.makeToast(SDK.R.string.usercenter_newPass)
               return
           }
           guard pass == againPass else {
               self.view.makeToast(SDK.R.string.usercenter_passInconsistent)
               return
           }
           if self.type == "0" {//邮箱
            SWUViewModel.updatePassByEmail(auth_token: self.auth_token, code: self.code, pass: pass, userName: self.email, finishCallBack: {
                    let emailVC = LoginEmailViewController()
                    var targetVC : UIViewController!
                    for vc: UIViewController in self.navigationController!.viewControllers {
                        if vc.isKind(of: emailVC.classForCoder) {
                            targetVC = vc
                        }
                    }
                    if targetVC != nil {
                        self.navigationController?.popToViewController(targetVC, animated: false)
                    }
                }) { (failedString) in
                    self.view.makeToast(failedString)
                }
            }else {//手机
            SWUViewModel.updatePassByPhone(auth_token: self.auth_token, code: self.code, pass: pass, userName: self.email, finishCallBack: {
                    let emailVC = LoginEmailViewController()
                    var targetVC : UIViewController!
                    for vc: UIViewController in self.navigationController!.viewControllers {
                        if vc.isKind(of: emailVC.classForCoder) {
                            targetVC = vc
                        }
                    }
                    if targetVC != nil {
                        self.navigationController?.popToViewController(targetVC, animated: false)
                    }
                }) { (failedString) in
                    self.view.makeToast(failedString)
                }
            }
        }
    }
}
