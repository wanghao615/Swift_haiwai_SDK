//
//  Mediator.swift
//  KingNetSDK
//
//  Created by admin on 2021/1/25.
//  Copyright © 2021 niujf. All rights reserved.
//
import UIKit

class Mediator: NSObject {
    static let share = Mediator()
    var serviceDict: [String: AnyObject] = [:]
    var servicePara: [String: Any] = [:]
}

extension Mediator {
    func registerService(_ application: UIApplication) {
        if let url = Bundle.main.url(forResource:initService, withExtension: "plist") {
           do {
             let data = try Data(contentsOf:url)
             let dict = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String:Any]
             if let dict = dict, dict.count > 0 {
                servicePara = dict
                for (key, _) in dict {
                   let cls: AnyClass? = classFromCls(key)
                   guard let clsType = cls as? NSObject.Type else {
                        debugPrint("没有找到配置相关的类")
                        continue
                   }
                   debugPrint("初始化class")
                   debugPrint(clsType)
                   let objCls = clsType.init()
                   (objCls as? InitServiceProtocol)?.config(application)
                   serviceDict[key] = objCls
                    debugPrint("=====",serviceDict)
                }
                
             }
           } catch {
              debugPrint("没有找到配置文件")
           }
        }
    }
    
    //TODO: 读取plist文件，通过类名注册服务
    func fetchService(_ name: String) -> AnyObject? {
        assert(!name.isEmpty, "传入的serName为空")
        guard let sever = serviceDict[name] else {
            debugPrint("没有找到服务")
            return nil
        }
        return sever
    }
}



