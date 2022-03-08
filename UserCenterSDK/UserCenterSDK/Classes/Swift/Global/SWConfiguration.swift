//
//  SWConfiguration.swift
//  KingNetSDK
//
//  Created by admin on 2020/11/26.
//  Copyright © 2020 niujf. All rights reserved.
//
import UIKit
/************************application相关*******************/
/// 当前app版本号
let KAppCurrentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
let KAppName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? Bundle.main.infoDictionary!["CFBundleName"] as! String
let KAPPBundleIdentifier = Bundle.main.bundleIdentifier!
let KServiceName = UIDevice.current.serviceName
let KSystemVersion = UIDevice.current.systemVersion
let keyWindow = UIApplication.shared.keyWindow

/************************屏幕坐标、尺寸相关*******************/

let IS_IPHONE4  = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:640,height:960), (UIScreen.main.currentMode?.size)!) : false
let IS_IPHONE5  = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:640,height:1336), (UIScreen.main.currentMode?.size)!) : false
let IS_IPHONE6  = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:750,height:1334), (UIScreen.main.currentMode?.size)!) : false
let IS_IPHONE6P  = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:1242,height:2208), (UIScreen.main.currentMode?.size)!) : false
let IS_IPHONE6PBigMode = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:1125,height:2001), (UIScreen.main.currentMode?.size)!) : false
let IS_IPHONEX = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:1125,height:2436), (UIScreen.main.currentMode?.size)!) : false
let IS_IPHONEXR = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:828,height:1792), (UIScreen.main.currentMode?.size)!) : false
let IS_IPHONEXSM  = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:1242,height:2688), (UIScreen.main.currentMode?.size)!) : false
let IS_IPHONE12MINI  = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:1125,height:2436), (UIScreen.main.currentMode?.size)!) : false
let IS_IPHONE12  = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:1170,height:2532), (UIScreen.main.currentMode?.size)!) : false
let IS_IPHONE12PROMAX  = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:1284,height:2778), (UIScreen.main.currentMode?.size)!) : false

///屏幕高度
let kScreenHeight = UIScreen.main.bounds.height
///屏幕宽度
let kScreenWidth = UIScreen.main.bounds.width

///屏幕比例
let K_Ratio: CGFloat = ((IS_IPHONE6 || IS_IPHONEX) ? 1 : (IS_IPHONE6P ? 1.1 : (IS_IPHONE5 ? 1.01 : ((IS_IPHONEXR || IS_IPHONEXSM) ? 1.34 : (IS_IPHONE4 ? 0.85 : (IS_IPHONE6PBigMode ? 1.01 : 1.35))))))
