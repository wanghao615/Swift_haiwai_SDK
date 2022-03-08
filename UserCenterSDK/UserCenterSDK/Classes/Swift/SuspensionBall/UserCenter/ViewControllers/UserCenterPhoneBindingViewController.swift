//
//  UserCenterPhoneBindingViewController.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/24.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class UserCenterPhoneBindingViewController: BaseViewController {
    private var phoneTimer: String?

    private lazy var phoneBindingView: UserCenterPhoneBindingView = {
        let phoneBindingView = UserCenterPhoneBindingView()
        return phoneBindingView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildView()
        addCallBack()
        offsetMargin = 80
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        phoneBindingView.tableViewIsHidden = true
    }
    
    deinit {
        print("\(self) 释放了")
        GCDTimer.cancelTask(phoneTimer)
    }
}

extension UserCenterPhoneBindingViewController {
    private func addChildView() {
        view.addSubview(phoneBindingView)
        phoneBindingView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(SDK.size)
        }
    }
}

extension UserCenterPhoneBindingViewController {
    private func addCallBack() {
        phoneBindingView.base_exitBtnCallback = {
            UserCenterSDK.share.gotoGame()
        }
        
        phoneBindingView.base_backBtnCallback = { [unowned self] in
            self.navigationController?.popViewController(animated: false)
        }
        
        phoneBindingView.smsBtnCallback = { [unowned self]
            (btn: UIButton, zone, phone) in
            guard phone.count > 0 else {
                self.view.makeToast(SDK.R.string.usercenter_InputPhoneN)
                return
            }
            self.phoneTimer = GCDTimer.execTask({
                (timeN) in
                btn.setTitle("\(timeN)s", for: .normal)
                btn.isEnabled = false
            }) {//倒计时完成
                btn.setTitle(SDK.R.string.usercenter_sendCodeAgain, for: .normal)
                btn.isEnabled = true
            }
            //发送验证码
            SWUViewModel.sendPhoneSMSCode(type: "5", zone: zone, auth_token: "", phoneN: phone) { (failedString) in
                self.view.makeToast(failedString)
            }
        }
        
        phoneBindingView.submitCallback = { [unowned self]
            (zone, phone, code) in
            guard phone.count > 0 else {
                self.view.makeToast(SDK.R.string.usercenter_InputPhoneN)
                return
            }
            guard code.count > 0 else {
                self.view.makeToast(SDK.R.string.u_smsCode)
                return
            }
            UserCenterViewModel.bindPhone(mobile: phone, code: code, zone: zone, finishCallBack: {
                let successVC = U_SuccessViewController()
                successVC.topTitle = SDK.R.string.usercenter_phoneBinding
                successVC.titleS = SDK.R.string.usercenter_phoneBindingSuccess
                successVC.type = successType.usercenterModule
                self.navigationController?.pushViewController(successVC, animated: false)
            }) { (failedString) in
                self.view.makeToast(failedString)
            }
        }
    }
}
