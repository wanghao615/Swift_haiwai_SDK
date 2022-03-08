//
//  GoogleLogin.swift
//  KingNetSDK
//
//  Created by admin on 2021/1/25.
//  Copyright © 2021 niujf. All rights reserved.
//

import GoogleSignIn

//@objc(GoogleService)
class GoogleService: NSObject {
    var target: UIViewController?
    var callback: (([String : Any]) -> ())?
}

extension GoogleService: LoginServiceProtocol {
    func loginWithPara(_ para: Any, callback: @escaping ([String : Any]) -> ()) {
        GIDSignIn.sharedInstance()?.signOut()
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = para as? UIViewController
        GIDSignIn.sharedInstance()?.signIn()
        self.callback = callback
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    func config(_ application: UIApplication) {
        let para = Mediator.share.servicePara
        let selfS: String = String(describing: GoogleService.self)
        guard let paraDict = para[selfS] as? [String: Any] else {
            debugPrint("class_\(selfS)没有相关的配置参数")
            return
        }
        guard let clientID = paraDict["clientID"] as? String else {
            debugPrint("clientID为空")
            return
        }
        GIDSignIn.sharedInstance()?.clientID = clientID
    }
}

extension GoogleService: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
      if let error = error {
        if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
          print("The user has not signed in before or they have since signed out.")
        } else {
          print("\(error.localizedDescription)")
        }
        return
      }
      // Perform any operations on signed in user here.
      let userId = user.userID                  // For client-side use only!
      let idToken = user.authentication.idToken // Safe to send to the server
      let clientId = user.authentication.clientID
      // ...
      if user != nil {
        let dict = ["userId": userId, "idToken": idToken, "clientID": clientId]
        if callback != nil {
            callback! (dict as [String : Any])
        }
      }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
      // Perform any operations when the user disconnects from app here.
      // ...
    }
}
