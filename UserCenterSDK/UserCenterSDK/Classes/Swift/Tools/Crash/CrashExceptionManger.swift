//
//  CrashExceptionManger.swift
//  UserCenterSDK
//
//  Created by admin on 2021/3/18.
//  Copyright © 2021 os. All rights reserved.
//

import UIKit
import class OCModule.BridgeManger

func registerUncaughtExceptionHandler()
{
    NSSetUncaughtExceptionHandler(UncaughtExceptionHandler)
}

func UncaughtExceptionHandler(exception: NSException) {
    let arr = exception.callStackSymbols
    let reason = exception.reason
    let name = exception.name.rawValue
    var crash = String()
    crash += "Stack:\n"
    crash = crash.appendingFormat("slideAdress:0x%0x\r\n", BridgeManger.calculate())
    crash += "\r\n\r\n name:\(name) \r\n reason:\(String(describing: reason)) \r\n \(arr.joined(separator: "\r\n")) \r\n\r\n"
     CrashManager.saveCrash(appendPathStr: .nsExceptionCrashPath, exceptionInfo: crash)
}
