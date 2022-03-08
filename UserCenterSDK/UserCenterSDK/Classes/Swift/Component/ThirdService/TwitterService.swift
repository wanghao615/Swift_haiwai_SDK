//
//  TwitterService.swift
//  KingNetSDK
//
//  Created by admin on 2021/1/26.
//  Copyright © 2021 niujf. All rights reserved.
//

//import TwitterKit
//
//class TwitterService: NSObject {}
//
//extension TwitterService: LoginServiceProtocol{
//    func config(_ application: UIApplication) {
//        let para = Mediator.share.servicePara
//        let selfS: String = String(describing: TwitterService.self)
//        guard let paraDict = para[selfS] as? [String: Any] else {
//            debugPrint("class_\(selfS)没有相关的配置参数")
//            return
//        }
//        guard let consumerKey = paraDict["consumerKey"] as? String else {
//            debugPrint("consumerKey为空")
//            return
//        }
//        guard let consumerSecret = paraDict["consumerSecret"] as? String else {
//            debugPrint("consumerSecret为空")
//            return
//        }
//        TWTRTwitter.sharedInstance().start(withConsumerKey: consumerKey, consumerSecret: consumerSecret)
//    }
//    
//    func loginWithPara(_ para: Any, callback: @escaping ([String : Any]) -> ()) {
//        TWTRTwitter.sharedInstance().logIn(completion: { (session, error) in
//            if (session != nil) {
//                let dict = ["userName": (session?.userName) ?? "", "userID": (session?.userID) ?? "", "authToken": (session?.authToken) ?? "", "authTokenSecret": (session?.authTokenSecret) ?? ""]
//                callback(dict)
//            } else {
//                debugPrint("error: \(error?.localizedDescription ?? "error")");
//            }
//        })
//    }
//    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
//        return TWTRTwitter.sharedInstance().application(app, open: url, options: options)
//    }
//}
