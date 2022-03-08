//
//  ProtocolRouter.swift
//  KingNetSDK
//
//  Created by admin on 2021/2/4.
//  Copyright © 2021 niujf. All rights reserved.
//

fileprivate let pros: String = "Protocol"
fileprivate let vc: String = "ViewController"

import UIKit

class ProtocolRouter: NSObject {
    static func matchObj(pro: Protocol) -> AnyObject? {
        let protocolS: String = NSStringFromProtocol(pro)
        if protocolS.contains(pros) {
            var classS = (protocolS as NSString).substring(to: protocolS.count - 8)
            classS += vc
            let cls: AnyClass? = classFromCls(classS)
            guard let clsType = cls as? UIViewController.Type else {
                 debugPrint("没有找到配置相关的类")
                 return nil
            }
            return clsType.init()
        }
        return nil
    }
}
