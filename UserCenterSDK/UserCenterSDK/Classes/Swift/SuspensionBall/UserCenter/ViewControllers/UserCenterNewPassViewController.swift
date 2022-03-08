//
//  UserCenterNewPassViewController.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/23.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class UserCenterNewPassViewController: BaseViewController {
    var pass: String = ""
    var auth_token: String = ""
    var code: String = ""
    var type: String = ""
    
    private lazy var newPassView: UserCenterNewPassView = {
        let newPassView = UserCenterNewPassView()
        return newPassView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildView()
        addCallBack()
        offsetMargin = 80
    }
    
    deinit {
        print("\(self) 释放了")
    }
}

extension UserCenterNewPassViewController {
    private func addChildView() {
        view.addSubview(newPassView)
        newPassView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(SDK.size)
        }
    }
}

extension UserCenterNewPassViewController {
    private func addCallBack() {
        newPassView.base_exitBtnCallback = {
            UserCenterSDK.share.gotoGame()
        }
        
        newPassView.base_backBtnCallback = { [unowned self] in
            self.navigationController?.popViewController(animated: false)
        }
        
        newPassView.sumitBtnCallback = { [unowned self] 
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
            if self.pass.count > 0 {//通过原密码
                UserCenterViewModel.updatePassByOld(oldPass: self.pass, pass: pass, finishCallBack: {
                    let successVC = U_SuccessViewController()
                    successVC.type = successType.usercenterModule
                    self.navigationController?.pushViewController(successVC, animated: false)
                }) { (failedString) in
                    self.view.makeToast(failedString)
                }
            }
            if self.type == "0" {//邮箱
                SWUViewModel.updatePassByEmail(auth_token: self.auth_token, code: self.code, pass: pass, finishCallBack: {
                    let successVC = U_SuccessViewController()
                    successVC.type = successType.usercenterModule
                    self.navigationController?.pushViewController(successVC, animated: false)
                }) { (failedString) in
                    self.view.makeToast(failedString)
                }
            }else {//手机
                SWUViewModel.updatePassByPhone(auth_token: self.auth_token, code: self.code, pass: pass, finishCallBack: {
                    let successVC = U_SuccessViewController()
                    successVC.type = successType.usercenterModule
                    self.navigationController?.pushViewController(successVC, animated: false)
                }) { (failedString) in
                    self.view.makeToast(failedString)
                }
            }
        }
    }
}


