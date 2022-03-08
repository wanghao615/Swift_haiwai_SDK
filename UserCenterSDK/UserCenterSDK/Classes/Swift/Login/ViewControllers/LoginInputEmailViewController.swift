//
//  LoginInputEmailViewController.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/29.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class LoginInputEmailViewController: BaseViewController {
    
    private lazy var inputEmailView: LoginInputEmailView = {
        let inputEmailView = LoginInputEmailView()
        return inputEmailView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        offsetMargin = 70
        addChildView()
        addCallback()
    }
    
    deinit {
        print("\(self) 释放了")
    }
}

extension LoginInputEmailViewController {
    private func addChildView() {
        view.addSubview(inputEmailView)
        inputEmailView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(SDK.size)
        }
    }
}

extension LoginInputEmailViewController {
    private func addCallback() {
        inputEmailView.base_backBtnCallback = { [unowned self] in
            self.navigationController?.popViewController(animated: false)
        }
        
        inputEmailView.nextBtnCallback = { [unowned self] 
            (email) in
            guard email.count > 0 else {
                self.view.makeToast(SDK.R.string.bindingEmail_emailAccount)
                return
            }
            LoginViewModel.emailInfo(email: email, finishCallBack: {
                (dict: [String: Any]) in
                let mobileDict: [String: Any] = JSON(dict["mobile"] as Any).dictionaryObject ?? [:]
                self.navigationController?.pushViewController(LoginRetrievePassViewController.init(email: email, formatEmail: dict["email"] as? String, auth_token: dict["auth_token"] as? String, phone: mobileDict["mobile"] as? String, zone: mobileDict["zone"] as? String), animated: false)
            }) { (failedString) in
                self.view.makeToast(failedString)
            }
        }
    }
}
