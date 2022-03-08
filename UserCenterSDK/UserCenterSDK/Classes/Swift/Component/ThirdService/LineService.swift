//
//  LineService.swift
//  KingNetSDK
//
//  Created by admin on 2021/1/26.
//  Copyright © 2021 niujf. All rights reserved.
//

//import LineSDK

//class LineService: NSObject {}

//extension LineService: LoginServiceProtocol {
//    func config(_ application: UIApplication) {
//        let para = Mediator.share.servicePara
//        let selfS: String = String(describing: LineService.self)
//        guard let paraDict = para[selfS] as? [String: Any] else {
//            debugPrint("class_\(selfS)没有相关的配置参数")
//            return
//        }
//        guard let channelID = paraDict["channelID"] as? String else {
//            debugPrint("channelID为空")
//            return
//        }
//        LoginManager.shared.setup(channelID: channelID, universalLinkURL: nil)
//    }
//    
//    func loginWithPara(_ para: Any, callback: @escaping ([String : Any]) -> ()) {
//        LoginManager.shared.login(permissions: [.profile], in: para as? UIViewController) {
//            result in
//            switch result {
//            case .success(let loginResult):
//                //print(loginResult.accessToken.value)
//                // Do other things you need with the login result
//                let dict = ["accessToken": loginResult.accessToken.value, "userID": (loginResult.userProfile?.userID) ?? ""]
//                callback(dict)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
//        return LoginManager.shared.application(app, open: url)
//    }
//}
