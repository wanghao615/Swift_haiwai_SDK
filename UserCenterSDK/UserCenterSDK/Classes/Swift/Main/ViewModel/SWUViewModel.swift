//
//  SWUViewModel.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/29.
//  Copyright © 2020 niujf. All rights reserved.
//
import class OCModule.SVProgressManger

struct SWUViewModel {
    static func sendEmailSMSCode(type: String,
                                 auth_token: String,
                                 email: String = "",
                                 userName: String = "",
                                 failed: @escaping (String) -> ()) {
        let para = ["appid": SDK.appid,
                    "email": email,
                    "type": type,
                    "username": userName,
                    "auth_token": auth_token]
        NetworkRequest(APIUser.u_sendEmailCode(parameter: para), completion: {
            (result) -> (Void) in
            }, failed: {
            (result) -> (Void) in
            failed(result)
        })
    }
    
    static func sendPhoneSMSCode(type: String,
                                 zone: String,
                                 auth_token: String = "",
                                 phoneN: String = "",
                                 failed: @escaping (String) -> ()) {
        let para = ["appid": SDK.appid,
                    "mobile": phoneN,
                    "type": type,
                    "zone": zone,
                    "auth_token": auth_token]
        NetworkRequest(APIUser.u_sendPhoneCode(parameter: para), completion: {
            (result) -> (Void) in
            }, failed: {
            (result) -> (Void) in
            failed(result)
        })
    }
    
    static func checkEmailCode(type: String,
                               code: String,
                               auth_token: String,
                               email: String = "",
                               finishCallBack: @escaping () -> (),
                               failed: @escaping (String) -> ()) {
        let para = ["appid": SDK.appid,
                    "email": email,
                    "type": type,
                    "code": code,
                    "auth_token": auth_token]
        SVProgressManger.show()
        NetworkRequest(APIUser.u_checkEmailCode(parameter: para), completion: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            finishCallBack()
            }, failed: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            failed(result)
        })
    }
    
    static func checkPhoneCode(type: String,
                               zone: String,
                               code: String,
                               auth_token: String,
                               mobileN: String = "",
                               finishCallBack: @escaping () -> (),
                               failed: @escaping (String) -> ()) {
        let para = ["appid": SDK.appid,
                    "mobile": mobileN,
                    "type": type,
                    "code": code,
                    "zone": zone,
                    "auth_token": auth_token]
        SVProgressManger.show()
        NetworkRequest(APIUser.u_checkPhoneCode(parameter: para), completion: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            finishCallBack()
            }, failed: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            failed(result)
        })
    }
    
    static func updatePassByEmail(auth_token: String,
                                  code: String,
                                  pass: String,
                                  userName: String = "",
                                  finishCallBack: @escaping () -> (),
                                  failed: @escaping (String) -> ()) {
        let para = ["appid": SDK.appid,
                    "auth_token": auth_token,
                    "code": code,
                    "pass": pass.n.md5,
                    "username": userName]
        SVProgressManger.show()
        NetworkRequest(APIUser.u_updatePassByEmail(parameter: para), completion: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            let jsonDict = JSON(result).dictionaryValue
            SDKTool.loginCode = jsonDict["login_code"]?.stringValue ?? ""
            SDKTool.token = jsonDict["token"]?.stringValue ?? ""
            finishCallBack()
            }, failed: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            failed(result)
        })
    }
    
    static func updatePassByPhone(auth_token: String,
                                  code: String,
                                  pass: String,
                                  userName: String = "",
                                  finishCallBack: @escaping () -> (),
                                  failed: @escaping (String) -> ()) {
        let para = ["appid": SDK.appid,
                    "auth_token": auth_token,
                    "code": code,
                    "pass": pass.n.md5,
                    "username": userName]
        SVProgressManger.show()
        NetworkRequest(APIUser.u_updatePassByPhone(parameter: para), completion: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            let jsonDict = JSON(result).dictionaryValue
            SDKTool.loginCode = jsonDict["login_code"]?.stringValue ?? ""
            SDKTool.token = jsonDict["token"]?.stringValue ?? ""
            finishCallBack()
            }, failed: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            failed(result)
        })
    }
}
