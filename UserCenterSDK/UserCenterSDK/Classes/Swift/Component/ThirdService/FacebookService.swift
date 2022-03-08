//
//  FacebookService.swift
//  KingNetSDK
//
//  Created by admin on 2021/1/26.
//  Copyright © 2021 niujf. All rights reserved.
//

import FBSDKCoreKit
import FBSDKLoginKit

class FacebookService: NSObject {}

extension FacebookService: LoginServiceProtocol {
    func config(_ application: UIApplication) {
        ApplicationDelegate.shared.application( application, didFinishLaunchingWithOptions: nil )
    }
    
    func loginWithPara(_ para: Any, callback: @escaping ([String : Any]) -> ()) {
        let loginManger = LoginManager()
        loginManger.logOut()
        loginManger.logIn(permissions: ["public_profile", "email"], from: para as? UIViewController) { (result, error) in
            if error != nil {
                debugPrint(error as Any)
            }else if (result?.isCancelled ?? true) {
                debugPrint("facebook user cancel")
            }else {
                let dict = ["accessToken": (result?.token?.tokenString) ?? "", "userID": (result?.token?.userID) ?? "", "appID": (result?.token?.appID) ?? ""]
                callback(dict)
            }
        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return ApplicationDelegate.shared.application( app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
    }
}
