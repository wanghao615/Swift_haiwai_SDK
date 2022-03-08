//
//  AdjustService.swift
//  UserCenterSDK
//
//  Created by admin on 2021/2/23.
//  Copyright © 2021 os. All rights reserved.
//

import UIKit
import AdjustSdk

class AdjustService: NSObject {
    public static var adjustAdid: String {
        return Adjust.adid() ?? ""
    }
    public static var adjustIdfa: String {
        return Adjust.idfa() ?? ""
    }
}

extension AdjustService: InitServiceProtocol {
    func config(_ application: UIApplication) {
        let para = Mediator.share.servicePara
        let selfS: String = String(describing: AdjustService.self)
        guard let paraDict = para[selfS] as? [String: Any] else {
            debugPrint("class_\(selfS)没有相关的配置参数")
            return
        }
        guard let appToken = paraDict["appToken"] as? String else {
            debugPrint("appToken为空")
            return
        }
        var environment: String = ""
        #if DEBUG
        environment = ADJEnvironmentSandbox
        #else
        environment = ADJEnvironmentProduction
        #endif
        let adjustConfig = ADJConfig(appToken: appToken, environment: environment)
        adjustConfig?.logLevel = ADJLogLevelVerbose
        Adjust.appDidLaunch(adjustConfig!)
    }
}

extension AdjustService {
    public static func event(token: String, para: [String: String]?) {
        let event = ADJEvent(eventToken: token)
        if let para = para {
            for(key, value) in para {
                event?.addCallbackParameter(key, value: value);
            }
        }
        Adjust.trackEvent(event);
    }
}
