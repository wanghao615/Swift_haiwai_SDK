//
//  Router.swift
//  KingNetSDK
//
//  Created by admin on 2021/1/26.
//  Copyright © 2021 niujf. All rights reserved.
//
import UIKit

@objc public class Router: NSObject {
    @available(iOS 9.0, *)
    @objc public class func application(_ app: UIApplication, openURL: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let urlS = openURL.absoluteString
        var service: AnyObject?
        if urlS.contains("google") {
            service = Mediator.share.fetchService(Service.google.rawValue)
        }
        if urlS.contains("facebook") {
            service = Mediator.share.fetchService(Service.facebook.rawValue)
        }
        if urlS.contains("naver") {
            service = Mediator.share.fetchService(Service.naver.rawValue)
        }
        if urlS.contains("line") {
            service = Mediator.share.fetchService(Service.line.rawValue)
        }
        if urlS.contains("twitter") {
            service = Mediator.share.fetchService(Service.twitter.rawValue)
        }
        return (service! as? LoginServiceProtocol)?.application(app, open: openURL, options: options) ?? true
    }
}
