//
//  AppDelegate.swift
//  UserCenter_SwiftTest
//
//  Created by admin on 2021/2/7.
//  Copyright © 2021 os. All rights reserved.
//

import UIKit
import UserCenterSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
        window?.makeKeyAndVisible()
        window?.rootViewController = GameViewController()
        UserCenterSDK.share.SDKInit(application: application, launchOptions: launchOptions)
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return UserCenterSDK.share.callback(application: app, url: url, options: options)
    }
}

