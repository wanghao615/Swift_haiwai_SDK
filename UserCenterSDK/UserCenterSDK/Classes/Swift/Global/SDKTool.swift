//
//  SDKTool.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/23.
//  Copyright © 2020 niujf. All rights reserved.
//
import UIKit

 // TODO: 为了兼容oc,后面等重构完，可以优化
fileprivate let LOGIN_CODE = "LOGIN_CODE"
fileprivate let TOKEN = "TOKEN"
fileprivate let USER_ID = "USER_ID"
fileprivate let UPGRADED = "UPGRADED"
fileprivate let USER_NAME = "USER_NAME"
fileprivate let ACCESS_TOKEN = "ACCESS_TOKEN"
fileprivate let LOGINID = "LOGINID"
fileprivate let ISPROTOCOLALERT = "ISPROTOCOLALERT"
fileprivate let IAPPAYTIMES = "IAPPAYTIMES"
fileprivate let LOGIN_TYPE = "LOGIN_TYPE"

// MARK: - 这里需要暴漏给oc的头文件，需要用class，如果是swift的接口，可以用struct
@objc public class SDKTool: NSObject {
   static var loginCode: String {
        set { UserDefaults.standard.set(newValue, forKey: LOGIN_CODE) }
        get { UserDefaults.standard.string(forKey: LOGIN_CODE) ?? "" }
    }
    
   static var token: String {
        set { UserDefaults.standard.set(newValue, forKey: TOKEN) }
        get { UserDefaults.standard.string(forKey: TOKEN) ?? "" }
    }
    
    @objc public static var user_id: String {
        set { UserDefaults.standard.set(newValue, forKey: USER_ID) }
        get { UserDefaults.standard.string(forKey: USER_ID) ?? "-1" }
    }
    
    static var upgraded: String {
        set { UserDefaults.standard.set(newValue, forKey: UPGRADED) }
        get { UserDefaults.standard.string(forKey: UPGRADED) ?? "" }
    }
    
    static var userName: String {
        set { UserDefaults.standard.set(newValue, forKey: USER_NAME) }
        get { UserDefaults.standard.string(forKey: USER_NAME) ?? "" }
    }
    
    static var access_token: String {
        set { UserDefaults.standard.set(newValue, forKey: ACCESS_TOKEN) }
        get { UserDefaults.standard.string(forKey: ACCESS_TOKEN) ?? "" }
    }
    
    static var loginId: String {
        set { UserDefaults.standard.set(newValue, forKey: LOGINID) }
        get { UserDefaults.standard.string(forKey: LOGINID) ?? "" }
    }
    
    static var loginType: String {
        set { UserDefaults.standard.set(newValue, forKey: LOGIN_TYPE) }
        get { UserDefaults.standard.string(forKey: LOGIN_TYPE) ?? "" }
    }
    
    static var IsProtocolAlert: Bool {
        set { UserDefaults.standard.set(newValue, forKey: ISPROTOCOLALERT) }
        get { UserDefaults.standard.bool(forKey: ISPROTOCOLALERT) }
    }
    
    static var payTimes: Int {
        set { UserDefaults.standard.set(newValue, forKey: IAPPAYTIMES) }
        get { UserDefaults.standard.integer(forKey: IAPPAYTIMES) }
    }
    
    static var adString: String {
        let pasteboard: String = UIPasteboard.general.string ?? ""
        if pasteboard.contains("iosacid:") && pasteboard.count > 8 {
            let subStr = (pasteboard as NSString).substring(from: 8)
            return subStr
        }
        return ""
    }
    
    static var currency: String = ""
    static var resourceId: String = ""
    static var IAPOrderInfo: String = ""
    static var serverOrderCallback: String = ""
    static var user_protocol: String = ""
    static var user_privacy_protocol: String = ""
    static var supportLoginTypeArr: [String] = []
    static var popAlert: Int = 0
    static var adjustEventList: [String: Any] = [:]
}

// MARK: - method
extension SDKTool {
    static func sdkSWConfiguration() {
        if let url = Bundle.main.url(forResource:SDK.configurator, withExtension: "plist") {
           do {
              let data = try Data(contentsOf:url)
              let dict = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String:Any]
              let language: String = dict["currentLanguage"] as! String
              let version: String = dict["sdkVersion"] as! String
              let requestLanguage: String = dict["requestLanguage"] as! String
              let appid: String = dict["appID"] as! String
              let gameId: String = dict["gameID"] as! String
              //设置显示的语言
              UserDefaults.standard.set(language, forKey: "appLanguage")
              SDK.version = version
              SDK.requestLanguage = requestLanguage
              SDK.appid = appid
              SDK.gameId = gameId
           } catch {
              debugPrint("没有找到sdk配置文件")
           }
        }
    }
    
    static func eventList() {
        if let url = Bundle.main.url(forResource:SDK.eventList, withExtension: "plist") {
            do {
                let data = try Data(contentsOf:url)
                let dict = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String:Any]
                adjustEventList = dict
            } catch {
                debugPrint("没有找到sdk配置文件")
            }
        }
    }
    
    static func event(eventName: String, isOnce: Bool) -> Bool{
        if !(eventName.count > 0) || (UserDefaults.standard.bool(forKey: eventName) && isOnce) {
            return false
        }
        if isOnce {
            UserDefaults.standard.set(true, forKey: eventName)
        }
        return true
    }
    
    static func equipUUID(_ danaId: String) {
        if danaId.count > 0 {
            SDK.equipUUID = danaId
        }
    }

    static func clearAccount() {
        loginCode = ""
        token = ""
        user_id = ""
        upgraded = ""
        userName = ""
        access_token = ""
        loginId = ""
        payTimes = 0
    }
}
