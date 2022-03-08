//
//  AccountUpgradeViewController.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/30.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit
import class OCModule.Statistics

class AccountUpgradeViewController: UIViewController {
    private lazy var accountUpgradeView: AccountUpgradeView = {
        let accountUpgradeView = AccountUpgradeView()
        return accountUpgradeView
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

extension AccountUpgradeViewController {
    private func addChildView() {
        view.addSubview(accountUpgradeView)
        accountUpgradeView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(SDK.size)
        }
    }
}

extension AccountUpgradeViewController {
    private func addCallback() {
        accountUpgradeView.base_exitBtnCallback = {
            UserCenterSDK.share.gotoGame()
        }
        
        accountUpgradeView.accBtnCallback = {
            //清除账户信息
            SDKTool.clearAccount()
            UserCenterSDK.share.accountLogout()
        }
        
        accountUpgradeView.thirdBtnCallback = {
              [unowned self] (title) in
              switch title {
              case "account":
                    // 普通方式
//                  let vc = BindingEmailViewController()
//                  vc.type = AccountType.upgrade
//                  self.navigationController?.pushViewController(vc, animated: false)
                    //protocol方式
//                  guard let bindEmail = ProtocolRouter.matchObj(pro: BindingEmailProtocol.self) else { return }
//                  (bindEmail as! BindingEmailProtocol).type(AccountType.upgrade)
//                  self.navigationController?.pushViewController(bindEmail as! UIViewController, animated: false)
                    //NRouter方式
                  NRouter.openUrl(url: "N://bind/email", parameter: ["type": AccountType.upgrade, "nav": self.navigationController ?? ""]) { (isSuccess) in
                    print("账号升级是否成功")
                    print(isSuccess)
                  }
              case "apple":
                  self.appleLogin()
              case "google":
                  self.googleLogin()
              case "facebook":
                  self.facebookLogin()
              case "line":
                  self.lineLogin()
              case "twitter":
                  self.twitterLogin()
              case "naver":
                  self.naverLogin()
              default:
                  break
            }
        }
    }
}

extension AccountUpgradeViewController {
    private func appleLogin() {
        let appleLoginManger = AppleLoginManger.share
        appleLoginManger.login(successCallback: {
            [unowned self] (dict: [String: Any]) in
            let jsonStr = JSON(dict).description
            self.thirdUpgrade("12", "apple", jsonStr)
        })
    }
    
    private func googleLogin() {
        let googleService = Mediator.share.fetchService(Service.google.rawValue)
        (googleService as? LoginServiceProtocol)?.loginWithPara(self, callback: { [unowned self]
            (dict) in
            self.thirdUpgrade("6", "google", JSON(dict).description)
        })
    }
    
    private func facebookLogin() {
        let facebookService = Mediator.share.fetchService(Service.facebook.rawValue)
        (facebookService as? LoginServiceProtocol)?.loginWithPara(self, callback: { [unowned self]
            (dict) in
            self.thirdUpgrade("7", "facebook", JSON(dict).description)
        })
    }
    
    private func lineLogin() {
        let lineService = Mediator.share.fetchService(Service.line.rawValue)
        (lineService as? LoginServiceProtocol)?.loginWithPara(self, callback: { [unowned self]
            (dict) in
            self.thirdUpgrade("10", "line", JSON(dict).description)
        })
    }
    
    private func twitterLogin() {
        let twitterService = Mediator.share.fetchService(Service.twitter.rawValue)
          (twitterService as? LoginServiceProtocol)?.loginWithPara(self, callback: { [unowned self]
              (dict) in
              self.thirdUpgrade("11", "twitter", JSON(dict).description)
          })
    }
    
    private func naverLogin() {
        let naverService = Mediator.share.fetchService(Service.naver.rawValue)
        (naverService as? LoginServiceProtocol)?.loginWithPara(self, callback: { [unowned self]
            (dict) in
            self.thirdUpgrade("9", "naver", JSON(dict).description)
        })
    }
    
    private func thirdUpgrade(_ channel: String, _ code: String, _ auth_info: String) {
        AccountUpgradeViewModel.third(channel: channel, code: code, auth_info: auth_info, finishCallBack: {
            Statistics.upAccount()
            UserCenterSDK.share.changeBallStatus()
            let successVC = U_SuccessViewController()
            successVC.topTitle = SDK.R.string.accountUpgrade_a
            successVC.titleS = SDK.R.string.accountUpgrade_bindingSuccess
            successVC.type = .accountUpgradeModule
            self.navigationController?.pushViewController(successVC, animated: false)
        }) { (failedString) in
            self.view.makeToast(failedString)
        }
    }
}
