//
//  UserCenterSDK.swift
//  KingNetSDK
//
//  Created by admin on 2021/1/29.
//  Copyright © 2021 niujf. All rights reserved.
//
import UIKit
import class OCModule.SVProgressManger
import class OCModule.Statistics
import class OCModule.BridgeManger

@objc public class UserCenterSDK: NSObject {
    private lazy var ball: FloatingBall = {
        let ball = FloatingBall()
        return ball
    }()
    
    private lazy var selView: AlertSelView = {
        let selView = AlertSelView()
        selView.topTitle = SDK.R.string.accountUpgrade_a
        selView.title = SDK.R.string.accountUpgrade_remind
        return selView
    }()
    
    private lazy var remindView: AppIterationRemind = {
        let remindView = AppIterationRemind()
        return remindView
    }()
    
    @objc public static let share = UserCenterSDK()
    @objc public var loginSuccessCallback: ((String, String, String) -> ())?
    @objc public var logoutSuccessCallback: (() -> ())?
    var isProtocol: Bool = false
    var nav: BaseNavgationViewController?
    var callUrl: String = ""
    
    deinit {
        print("")
    }
}

/*********************public: 对接调用****************/
extension UserCenterSDK {
    @objc public func SDKInit(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        
        //init service
        Mediator.share.registerService(application)
        //init plist SWConfiguration
        SDKTool.sdkSWConfiguration()
        SDKTool.eventList()
        //SVProgressHUD
        SVProgressManger.configuration()
        //dana
        Statistics.configuration()
        SDKTool.equipUUID(Statistics.getDataUUID())
//        //init service SWConfiguration
        UserCenterSDK.share.SDKInitConfiguration()
        //callback
        addCallback()
        //registerUrl
        registerUrl()
        //crash
        crashReport()
    }
    
    @objc public func callback(application: UIApplication, url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return Router.application(application, openURL: url, options: options)
    }
    
    /// 自动登录
    @objc public func accountAutoLogin() {
        //dana
        Statistics.dupgrade()
        //appIterationRemind
        UserCenterSDK.share.appIterationRemind()
    }
}

/*********************内购****************/
extension UserCenterSDK {
    @objc public func IAPStatus(dict: [String: String], statusCallback: @escaping (String) -> ()) {
        IAPManger.startDict(dict, statusCallback: statusCallback)
    }
}

/*********************private: SDK自己调用****************/
extension UserCenterSDK {
    private func SDKInitConfiguration() {
        //dana
        //registerPara
        let idfa: String = BridgeManger.getIdfa()
        var dict = ["openid": "",
                    "bundle_name": KAppName ,
                    "bundle_id": KAPPBundleIdentifier,
                    "idfa": idfa,
                    "platform": "iOS",
                    "channel": "appstore",
                    "_os": "iOS",
                    "_osver": KSystemVersion,
                    "_sdkserver": SDK.version,
                    "terminal": "iOS",
                    "agency": "",
                    "media_source": "",
                    "package_id": SDK.appid,
                    "gameid": SDK.gameId]
        Statistics.register(withDict: dict)
        Statistics.activation()
        
        if SDKTool.user_id.count==0 {
            dict["ouid"]  = "-1"
        }else{
            dict["ouid"]  = SDKTool.user_id
        }

        AdjustService.event(token: SDKTool.adjustEventList["activation"] as! String, para: nil)
        SWInitViewModel.sdkSWConfiguration(finishCallBack: { [weak self]
            (client_id, game_id, isProtocol) in
            self?.isProtocol = isProtocol
            Statistics.register(withDict: ["plat": client_id])
        }) { (error) in
            SVProgressManger.showError(withStatus: error)
        }
    }
    
    private func appIterationRemind() {
        SWInitViewModel.appIterationRemind(finishCallBack: { [weak self]
            (remindModel) in
            self?.popRemindView(remindModel)
            self?.callUrl = remindModel.url
        }) { [weak self] in
            self?.login()
        }
    }
    
    private func login() {
        if SDKTool.loginCode.count > 0, SDKTool.user_id.count > 0 {
            SWInitViewModel.sdkAutoLogin(finishCallBack: { [weak self] in
                self?.floatingBallShow()
                if self?.loginSuccessCallback != nil {
                    self?.loginSuccessCallback! (SDKTool.userName, SDKTool.user_id, SDKTool.access_token)
                }
            }) { (error) in
                SVProgressManger.showError(withStatus: error)
            }
        }else {
            toLoginInterface()
        }
    }
    
    private func popRemindView(_ model: AppIterationRemindModel) {
        let remindViewW: CGFloat = 400.0 * K_Ratio
        let remindViewH: CGFloat = 300.0 * K_Ratio
        let remindViewX: CGFloat = (kScreenWidth - remindViewW) / 2
        let remindViewY: CGFloat = (kScreenHeight - remindViewH) / 2
        remindView.frame = CGRect(x: remindViewX, y: remindViewY, width: remindViewW, height: remindViewH)
        remindView.remindModel = model
        ball.isBallHidden = true
        keyWindow?.rootViewController?.view.addSubview(remindView)
    }
    
    private func toLoginInterface() {
        if !SDKTool.IsProtocolAlert, isProtocol {
            let protocolVC = UserProtocolViewController()
            protocolVC.confirmCallback = { [weak self] in
                self?.nav?.removeFromParent()
                self?.nav?.view.removeFromSuperview()
                self?.nav = BaseNavgationViewController(rootViewController: LoginViewController())
                if let nav = self?.nav {
                   keyWindow?.rootViewController?.addChild(nav)
                   keyWindow?.rootViewController?.view.addSubview(nav.view)
                }
            }
            nav = BaseNavgationViewController(rootViewController: protocolVC)
        }else {
            nav = BaseNavgationViewController(rootViewController: LoginViewController())
        }
        if let nav = nav {
            keyWindow?.rootViewController?.addChild(nav)
            keyWindow?.rootViewController?.view.addSubview(nav.view)
        }
    }
    
    func loginSuccessWithTitle(_ title: String) {
        if loginSuccessCallback != nil {
            loginSuccessCallback! (SDKTool.userName, SDKTool.user_id, SDKTool.access_token)
        }
        if title.count > 0 {
            signoutSdk()
            keyWindow?.rootViewController?.view.makeToast(title, position: .top, image: SDK.R.image.login_success)
        }
    }
    
    func signoutSdk() {
        nav?.removeFromParent()
        nav?.view.removeFromSuperview()
        //判断有没有登录成功
        if SDKTool.loginCode.count > 0, SDKTool.user_id.count > 0 {
            floatingBallShow()
        }
    }
    
    func gotoGame() {
        nav?.removeFromParent()
        nav?.view.removeFromSuperview()
        ball.isBallHidden = false
    }
    
    @objc public  func accountLogout() {
        nav?.removeFromParent()
        nav?.view.removeFromSuperview()
        ball.isBallHidden = true;
        ball.removeFromSuperview()
        if logoutSuccessCallback != nil {
            logoutSuccessCallback!()
        }
    }
    
    private func floatingBallShow() {
        let btnWH: CGFloat = 44.0
        ball.frame = CGRect(x: 20, y: kScreenHeight/2 - 22 , width: btnWH, height: btnWH)
        if Int(SDKTool.upgraded) == 0 {//账号升级
            ball.isUpgrade = true
        }else {
            ball.isUpgrade = false
        }
        ball.isBallHidden = false
        keyWindow?.rootViewController?.view.addSubview(ball)
    }
    
    func changeBallStatus() {
        ball.isUpgrade = false;
    }
    
    private func jumpVC(_ vc: UIViewController) {
        let nav = BaseNavgationViewController(rootViewController: vc)
        self.nav = nav
        keyWindow?.rootViewController?.addChild(nav)
        keyWindow?.rootViewController?.view.addSubview(nav.view)
    }
    
    func popUpgradeSelectView() {
        let selViewW: CGFloat = 320.0
        let selViewH: CGFloat = 220.0
        let selViewX: CGFloat = (kScreenWidth - selViewW) / 2
        let selViewY: CGFloat = (kScreenHeight - 208) / 2
        selView.frame = CGRect(x: selViewX, y: selViewY, width: selViewW, height: selViewH)
        ball.isBallHidden = true
        keyWindow?.rootViewController?.view.addSubview(selView)
    }
}

/*********************crash report****************/
extension UserCenterSDK {
    private func crashReport() {
        crashHandle { (crashInfoArr) in
            if crashInfoArr.count == 0 { return }
            for info in crashInfoArr {
                GCDTool.async_main {
                    let info = JSON(info).stringValue
                    Statistics.unitEvent("apperror", dict: ["type": info])
                }
            }
        }
    }
}
/*********************callback****************/
extension UserCenterSDK {
    private func addCallback() {
        ball.callback = { [weak self]
            (tag) in
            switch tag {
            case 0:
                self?.jumpVC(AccountUpgradeViewController())
                self?.ball.isBallHidden = true
            case 1:
                self?.jumpVC(UserCenterViewController())
                self?.ball.isBallHidden = true
            case 2:
                self?.jumpVC(ServiceCenterController())
                self?.ball.isBallHidden = true
            default:
                break
            }
        }
        
        selView.confirmCallback = { [weak self] in
            self?.jumpVC(AccountUpgradeViewController())
        }
        
        selView.cancelCallback = { [weak self] in
            self?.ball.isBallHidden = false
        }
        
        remindView.confirmCallback = {
            if let url = URL(string: self.callUrl), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        
        remindView.cancelCallback = { [weak self] in
            self?.login()
        }
    }
}

/*********************registerUrl****************/
extension UserCenterSDK {
    private func registerUrl() {
        //NRouter
        NRouter.registerUrlWithHandler(urlPattern: "N://bind/email") {
            (dict) in
            print(dict as Any)
            let para = dict?[NRouterParameterInfo] as? [String: Any]
            guard let nav = para?["nav"] as? BaseNavgationViewController else {
                return
            }
            let type = para?["type"]
            let vc = BindingEmailViewController()
            vc.type = type as? AccountType
            nav.pushViewController(vc, animated: false)
        }
    }
}
/*********************事件****************/
extension UserCenterSDK {
    
    /// 自定义事件
    /// - Parameters:
    ///   - event: 事件名称
    ///   - roleName: 角色名称
    ///   - roleId: 角色id
    ///   - serverId: 服务id
    @objc public func unite(event: String,
                            roleName: String,
                            roleId: String,
                            serverId: String,
                            isOnce: Bool) {
        if SDKTool.event(eventName: event, isOnce: isOnce){
            var dict = ["roleid": roleId, "rolename": roleName, "serverid": serverId]
            
            dict["package_id"] = SDK.appid
            dict["gameid"] = SDK.gameId
            dict["ouid"] = SDKTool.user_id
            
            Statistics.unitEvent(event, dict: dict)
            
            if SDKTool.adjustEventList.keys.contains(event)  {
                AdjustService.event(token: SDKTool.adjustEventList[event] as! String, para: dict)
            }else{
                SVProgressManger.showError(withStatus: "没有此事件")
            }
           
        }
    }
}
