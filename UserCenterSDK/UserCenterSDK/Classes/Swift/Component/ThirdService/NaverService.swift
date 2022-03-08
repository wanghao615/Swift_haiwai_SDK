//
//  NaverService.swift
//  KingNetSDK
//
//  Created by admin on 2021/1/26.
//  Copyright © 2021 niujf. All rights reserved.
//
import UIKit
import class OCModule.NaveLoginService

// TODO: 根本不支持swift，吾很无奈
class NaverService: NSObject {
    var naverService: NaveLoginService?
}

extension NaverService: LoginServiceProtocol {
    func config(_ application: UIApplication) {
        let para = Mediator.share.servicePara
        let selfS: String = String(describing: NaverService.self)
        guard let paraDict = para[selfS] as? [String: Any] else {
            debugPrint("class_\(selfS)没有相关的配置参数")
            return
        }
        naverService = NaveLoginService()
        naverService?.config(withDict: paraDict)
    }
    
    func loginWithPara(_ para: Any, callback: @escaping ([String : Any]) -> ()) {
        naverService?.login(withParams: para, callbackParams: callback)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return naverService?.application(app, open: url, options: options) ?? true
    }
}
