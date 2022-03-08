//
//  LoginViewController.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/25.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit
import class OCModule.Statistics

class LoginViewController: UIViewController {
    private lazy var loginView: LoginView = {
        let loginView = LoginView()
        return loginView
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        addChildView()
        addCallback()
    }
    
    deinit {
        print("\(self) 释放了")
    }
}

extension LoginViewController {
    private func addChildView() {
        view.addSubview(loginView)
        loginView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(SDK.size)
        }
    }
}

extension LoginViewController {
    private func addCallback() {
        loginView.thirdBtnCallback = { [unowned self]
            (title) in
            switch title {
            case "account":
                self.navigationController?.pushViewController(LoginEmailViewController(), animated: false)
                Statistics.clickLogin(withDict: ["type": "1"])
            case "apple":
                self.appleLogin()
                Statistics.clickLogin(withDict: ["type": "3"])
            case "google":
                self.googleLogin()
                Statistics.clickLogin(withDict: ["type": "4"])
            case "facebook":
                self.facebookLogin()
                Statistics.clickLogin(withDict: ["type": "5"])
            case "line":
                self.lineLogin()
                Statistics.clickLogin(withDict: ["type": "7"])
            case "twitter":
                self.twitterLogin()
                Statistics.clickLogin(withDict: ["type": "8"])
            case "naver":
                self.naverLogin()
                Statistics.clickLogin(withDict: ["type": "6"])
            default:
                break
            }
        }
        
        loginView.touristBtnCallback = {
            Statistics.clickLogin(withDict: ["type": "2"])
            LoginViewModel.guestLogin(finishCallBack: {
                (username, isRegister: Bool) in
                let title: String = username + "," + SDK.R.string.login_welcome
                UserCenterSDK.share.loginSuccessWithTitle(title)
            }) { (failedString) in
                self.view.makeToast(failedString)
            }
        }
    }
}

extension LoginViewController {
    private func appleLogin() {
        let appleLoginManger = AppleLoginManger.share
        appleLoginManger.login(successCallback: { [unowned self]
            (dict: [String: Any]) in
            let jsonStr = JSON(dict).description
            self.thirdAuthorize("12", "apple", jsonStr)
        })
    }
    
    private func googleLogin() {
        //googleService
        let googleService = Mediator.share.fetchService(Service.google.rawValue)
        (googleService as? LoginServiceProtocol)?.loginWithPara(self, callback: { [unowned self]
            (dict) in
            self.thirdAuthorize("6", "google", JSON(dict).description)
        })
    }
    
    private func facebookLogin() {
        let facebookService = Mediator.share.fetchService(Service.facebook.rawValue)
        (facebookService as? LoginServiceProtocol)?.loginWithPara(self, callback: { [unowned self]
            (dict) in
            self.thirdAuthorize("7", "facebook", JSON(dict).description)
        })
    }
    
    private func lineLogin() {
        let lineService = Mediator.share.fetchService(Service.line.rawValue)
        (lineService as? LoginServiceProtocol)?.loginWithPara(self, callback: { [unowned self]
            (dict) in
            self.thirdAuthorize("10", "line", JSON(dict).description)
        })
    }
    
    private func twitterLogin() {
        let twitterService = Mediator.share.fetchService(Service.twitter.rawValue)
        (twitterService as? LoginServiceProtocol)?.loginWithPara(self, callback: { [unowned self]
            (dict) in
            self.thirdAuthorize("11", "twitter", JSON(dict).description)
        })
    }
    
    private func naverLogin() {
        let naverService = Mediator.share.fetchService(Service.naver.rawValue)
        (naverService as? LoginServiceProtocol)?.loginWithPara(self, callback: { [unowned self]
            (dict) in
            print(dict)
            self.thirdAuthorize("9", "naver", JSON(dict).description)
        })
    }
    
    private func thirdAuthorize(_ channel: String, _ code: String, _ auth_info: String) {
        LoginViewModel.thirdAuthorize(channel: channel, code: code, auth_info: auth_info, finishCallBack: {
            (username) in
            let title: String = username + "," + SDK.R.string.login_welcome
            UserCenterSDK.share.loginSuccessWithTitle(title)
        }) { (failedString) in
            self.view.makeToast(failedString)
        }
    }
}
