//
//  InitProtocol.swift
//  KingNetSDK
//
//  Created by admin on 2021/1/25.
//  Copyright © 2021 niujf. All rights reserved.
//
import UIKit

protocol InitServiceProtocol {
    ///初始化参数配置
    func config(_ application: UIApplication)
}

protocol LoginServiceProtocol: InitServiceProtocol {
    ///调起登录
    func loginWithPara(_ para: Any, callback: @escaping ([String : Any]) -> ())
    ///登录的回调
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool
}

