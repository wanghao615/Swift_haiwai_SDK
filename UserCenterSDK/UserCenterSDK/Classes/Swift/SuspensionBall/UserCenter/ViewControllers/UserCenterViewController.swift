//
//  UserCenterViewController.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/8.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit
import class OCModule.Statistics

class UserCenterViewController: UIViewController {
    var auth_token: String = ""
    var email: String = ""
    var phoneN: String = ""
    var zoneS: String = ""

    private lazy var centerView: UserCenterView = {
        let centerView = UserCenterView()
        return centerView
    }()
    
    private lazy var alertSelView: AlertSelView = {
        let alertSelView = AlertSelView()
        alertSelView.topTitle = SDK.R.string.u_accountExit
        alertSelView.title = SDK.R.string.usercenter_exit
        return alertSelView
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        addChildView()
        addCallBack()
        loadRequest()
    }
    
    deinit {
        print("\(self) 释放了")
    }
}

extension UserCenterViewController {
    private func addChildView() {
        view.addSubview(centerView)
        centerView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(SDK.size)
        }
    }
}

extension UserCenterViewController {
    private func addCallBack() {
        centerView.base_exitBtnCallback = {
            UserCenterSDK.share.gotoGame()
        }
        
        centerView.paraCallback = { [unowned self]
            (auth_token, email, phoneN, zone) in
            self.auth_token = auth_token
            self.email = email
            self.phoneN = phoneN
            self.zoneS = zone
        }
        
        centerView.btnTypeCallback = { [unowned self]
            (type) in
            switch type {
            case 0, 1://绑定邮箱，绑定手机 || 绑定邮箱，没有绑定手机
                self.navigationController?.pushViewController(UserCenterModifyPassViewController(type: type, auth_token: self.auth_token, phoneN: self.phoneN, email: self.email, zone: self.zoneS), animated: false)
            case 2://没有绑定邮箱
//                let bindingEmailVC = BindingEmailViewController()
//                bindingEmailVC.type = AccountType.bind
//                self.navigationController?.pushViewController(bindingEmailVC, animated: false)
                NRouter.openUrl(url: "N://bind/email", parameter: ["type": AccountType.bind, "nav": self.navigationController ?? ""]) { (isSuccess) in
                  print("账号绑定是否成功")
                  print(isSuccess)
                }
            case 3://绑定手机号
             self.navigationController?.pushViewController(UserCenterPhoneBindingViewController(), animated: false)
            case 4://切换账号,弹框确定
                self.view.addSubview(self.alertSelView)
                self.alertSelView.snp.makeConstraints { (make) in
                    make.center.equalToSuperview()
                    make.size.equalTo(SDK.alertSelSize)
                }
            default:
                break
            }
        }
        
        centerView.thirdBtnCallback = { [unowned self]//三方登录
            (tag) in
            switch tag {
            case 13:
                self.googleLogin()
            case 14:
                self.facebookLogin()
            case 11:
                self.lineLogin()
            case 12:
                self.twitterLogin()
            case 10:
                self.naverLogin()
            default:
                break
            }
        }
        
        alertSelView.confirmCallback = {
            UserCenterViewModel.logout(finishCallBack: {
                //清除账户信息
                SDKTool.clearAccount()
                //退出登录
                UserCenterSDK.share.accountLogout()
            }) { (failedString) in
                self.view.makeToast(failedString)
            }
        }
    }
}
 
extension UserCenterViewController {
    private func loadRequest() {
        UserCenterViewModel.accountStatus(finishCallBack: {
           (statusModel) in
            self.centerView.accountStatusModel = statusModel
        }) {
           (failedString) in
            self.view.makeToast(failedString)
        }
    }
}

// MARK: - third part login

extension UserCenterViewController {
    ///google
    private func googleLogin() {
        let googleService = Mediator.share.fetchService(Service.google.rawValue)
        (googleService as? LoginServiceProtocol)?.loginWithPara(self, callback: { [unowned self]
            (dict) in
            self.thirdLogin("6", "google", JSON(dict).description)
        })
    }
    
    private func facebookLogin() {
        let facebookService = Mediator.share.fetchService(Service.facebook.rawValue)
        (facebookService as? LoginServiceProtocol)?.loginWithPara(self, callback: { [unowned self]
            (dict) in
            self.thirdLogin("7", "facebook", JSON(dict).description)
        })
    }
    
    private func lineLogin() {
        let lineService = Mediator.share.fetchService(Service.line.rawValue)
        (lineService as? LoginServiceProtocol)?.loginWithPara(self, callback: { [unowned self]
            (dict) in
            self.thirdLogin("10", "line", JSON(dict).description)
        })
    }
    
    private func twitterLogin() {
        let twitterService = Mediator.share.fetchService(Service.twitter.rawValue)
        (twitterService as? LoginServiceProtocol)?.loginWithPara(0, callback: { [unowned self]
            (dict) in
            self.thirdLogin("11", "twitter", JSON(dict).description)
        })
    }
    
    private func naverLogin() {
        let naverService = Mediator.share.fetchService(Service.naver.rawValue)
        (naverService as? LoginServiceProtocol)?.loginWithPara(self, callback: { [unowned self]
            (dict) in
            self.thirdLogin("9", "naver", JSON(dict).description)
        })
    }
    
    private func thirdLogin(_ channel: String, _ code: String, _ auth_info: String) {
        UserCenterViewModel.bindingThird(channel: channel, code: code, auth_info: auth_info, finishCallBack: {
            let vc = U_SuccessViewController()
            vc.topTitle = SDK.R.string.usercenter_bindingThird
            vc.title = SDK.R.string.bindingEmail_success
            vc.type = .usercenterModule
            self.navigationController?.pushViewController(vc, animated: false)
        }) { (failedString) in
            self.view.makeToast(failedString)
        }
    }
}

