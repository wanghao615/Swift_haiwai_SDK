//
//  NSObject-Extension.swift
//  KingNetSDK
//
//  Created by admin on 2021/1/25.
//  Copyright © 2021 niujf. All rights reserved.
//
import UIKit

fileprivate let SDKName: String = "UserCenterSDK"

extension NSObject {
    func classFromCls(_ clst: String) -> AnyClass? {
        assert(!clst.isEmpty, "传入的calss字符串为空")
        //适用于项目，不适用于framework
        //let clsB = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String
        var cls: AnyClass?
        if clst.contains(SDKName) {
            cls = NSClassFromString(clst)
        }else {
            cls = NSClassFromString(SDKName + "." + clst)
        }
        return cls
    }
    
    static func classFromCls(_ clst: String) -> AnyClass? {
        assert(!clst.isEmpty, "传入的calss字符串为空")
        var cls: AnyClass?
        if clst.contains(SDKName) {
            cls = NSClassFromString(clst)
        }else {
            cls = NSClassFromString(SDKName + "." + clst)
        }
        return cls
    }
}

