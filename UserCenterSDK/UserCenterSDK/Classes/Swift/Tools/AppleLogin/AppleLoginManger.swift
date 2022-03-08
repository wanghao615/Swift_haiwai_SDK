//
//  AppleLoginManger.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/30.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit
import AuthenticationServices

class AppleLoginManger: NSObject {
    static let share = AppleLoginManger()
    private var successCallback: (([String: Any]) -> ())?
}

extension AppleLoginManger {
    @available(iOS 13.0, *)
    func appleBtn(type: ASAuthorizationAppleIDButton.ButtonType, stytle: ASAuthorizationAppleIDButton.Style) -> ASAuthorizationAppleIDButton {
        let appleBtn = ASAuthorizationAppleIDButton(authorizationButtonType: type, authorizationButtonStyle: stytle)
        return appleBtn
    }
    
    func login(successCallback: @escaping ([String: Any]) -> ()) {
          if #available(iOS 13.0, *) {
              self.successCallback = successCallback
              //基于用户的Apple ID 授权用户，生成用户授权请求的一种机制
              let appleIDProvider =  ASAuthorizationAppleIDProvider()
              //创建新的Apple ID授权请求
              let request = appleIDProvider.createRequest()
              //在用户授权期间请求的联系信息
              request.requestedScopes = [.fullName, .email]
              //由ASAuthorizationAppleIDProvider创建的授权请求，管理授权请求的控制器
              let authorizationController = ASAuthorizationController.init(authorizationRequests: [request])
              //设置授权控制器通知授权请求的成功与失败的代理
              authorizationController.delegate = self;
              //提供展示上下文的代理，在这个上下文中，系统可以展示授权界面给用户
              authorizationController.presentationContextProvider = self;
              authorizationController.performRequests()
          }
      }
}

extension AppleLoginManger: ASAuthorizationControllerDelegate {
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if  let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential{
            let identityToken = String(data: appleIDCredential.identityToken ?? Data(), encoding: .utf8)
            let authorizationCode = String(data: appleIDCredential.authorizationCode ?? Data(), encoding: .utf8)
            let userIdentifier = appleIDCredential.user
            // 用于判断当前登录的苹果账号是否是一个真实用户，取值有：unsupported、unknown、likelyReal
            let realUserStatus = appleIDCredential.realUserStatus.rawValue
//            let familyName = appleIDCredential.fullName?.familyName ?? ""
//            let givenName = appleIDCredential.fullName?.givenName ?? ""
//            let email = appleIDCredential.email ?? ""
            debugPrint(identityToken as Any)
            debugPrint(authorizationCode as Any)
            debugPrint(userIdentifier)
            debugPrint("\(realUserStatus)")
            let dict = ["identityToken": identityToken, "userID": userIdentifier, "authorizationCode": authorizationCode, "realUserStatus": "\(realUserStatus)"]
            if successCallback != nil {
                successCallback! (dict as [String : Any])
            }
        }else {
            debugPrint("授权信息不符合")
        }
    }
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        var errorStr : String?
        switch (error as NSError).code {
        case ASAuthorizationError.canceled.rawValue :
                errorStr = "用户取消了授权请求"
        case ASAuthorizationError.failed.rawValue :
                errorStr = "授权请求失败"
        case ASAuthorizationError.invalidResponse.rawValue :
                errorStr = "授权请求无响应"
        case ASAuthorizationError.notHandled.rawValue :
                errorStr = "未能处理授权请求"
        case ASAuthorizationError.unknown.rawValue :
                errorStr = "授权请求失败原因未知"
        default:
            break
        }
        debugPrint(errorStr as Any)
    }
}

//MARK: - 代理 ASAuthorizationControllerPresentationContextProviding 管理视图弹出在哪里
extension AppleLoginManger: ASAuthorizationControllerPresentationContextProviding {
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.windows.last ?? ASPresentationAnchor()
    }
}
