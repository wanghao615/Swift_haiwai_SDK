//
//  LoginViewModel.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/28.
//  Copyright © 2020 niujf. All rights reserved.
//
import class OCModule.BridgeManger
import class OCModule.SVProgressManger
import class OCModule.Statistics

struct LoginViewModel {
    static func register(email: String,
                         code: String,
                         pass: String,
                         finishCallBack: @escaping () -> (),
                         failed: @escaping (String) -> ()) {
        let para = ["appid": SDK.appid,
                    "pass": pass.n.md5,
                    "username": email,
                    "code": code,
                    "device_id": SDK.equipUUID,
                    "device": KServiceName,
                    "reg_from": "SDK",
                    "upgrade_account": "0",
                    "ad_id": SDKTool.adString,
                    "plat": "os",
                    "validate_token": "",
                    "black_box": ""]
        SVProgressManger.show()
        NetworkRequest(APIUser.login_register(parameter:para), completion: {
            (result) -> (Void) in
            print(result)
            let resultDict = JSON(result).dictionaryObject
            let loginInfoModel: LoginInfoModel = resultDict?.kj.model(type: LoginInfoModel.self) as! LoginInfoModel
            saveLoginInfo(model: loginInfoModel)
            SVProgressManger.dismiss()
            finishCallBack()
            }, failed: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            failed(result)
        })
    }
    
    static func login(email: String,
                      pass: String,
                      finishCallBack: @escaping () -> (),
                      failed: @escaping (String) -> ()) {
        let para = ["appid": SDK.appid,
                    "pass": pass.n.md5,
                    "username": email]
        SVProgressManger.show()
        NetworkRequest(APIUser.login_l(parameter:para), completion: {
            (result) -> (Void) in
            let resultDict = JSON(result).dictionaryObject
            let loginInfoModel: LoginInfoModel = resultDict?.kj.model(type: LoginInfoModel.self) as! LoginInfoModel
            saveLoginInfo(model: loginInfoModel)
            SVProgressManger.dismiss()
            finishCallBack()
            }, failed: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            failed(result)
        })
    }
    
    static func emailInfo(email: String,
                          finishCallBack: @escaping ([String: Any]) -> (),
                          failed: @escaping (String) -> ()){
        let para = ["appid": SDK.appid,
                    "username": email]
        SVProgressManger.show()
        NetworkRequest(APIUser.login_emailInfo(parameter:para), completion: {
            (result) -> (Void) in
            let jsonDict = JSON(result).dictionaryObject
            SVProgressManger.dismiss()
            finishCallBack(jsonDict ?? [:])
            }, failed: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            failed(result)
        })
    }
    
    static func thirdAuthorize(channel: String,
                               code: String,
                               auth_info: String,
                               finishCallBack: @escaping (String) -> (),
                               failed: @escaping (String) -> ()){
        let para = ["appid": SDK.appid,
                    "channel": channel,
                    "code": code,
                    "plat": "os",
                    "reg_from": "SDK",
                    "client_type": "3",
                    "device_id": SDK.equipUUID,
                    "device_name": KServiceName,
                    "ad_id": SDKTool.adString,
                    "redirect_uri": "",
                    "auth_info": auth_info,
        ]
        SVProgressManger.show()
        NetworkRequest(APIUser.login_thirdAuthorize(parameter:para), completion: {
            (result) -> (Void) in
            let resultDict = JSON(result).dictionaryObject
            let loginInfoModel: LoginInfoModel = resultDict?.kj.model(type: LoginInfoModel.self) as! LoginInfoModel
            saveLoginInfo(model: loginInfoModel)
            SVProgressManger.dismiss()
            finishCallBack(loginInfoModel.username)
            }, failed: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            failed(result)
        })
    }
    
    static func guestLogin(finishCallBack: @escaping (String, Bool) -> (),
                           failed: @escaping (String) -> ()){
        let para = ["appid": SDK.appid,
                    "equip": SDK.equipUUID,
                    "device_id": SDK.equipUUID]
        SVProgressManger.show()
        NetworkRequest(APIUser.login_guest(parameter:para), completion: {
            (result) -> (Void) in
            let resultDict = JSON(result).dictionaryObject
            let loginInfoModel: LoginInfoModel = resultDict?.kj.model(type: LoginInfoModel.self) as! LoginInfoModel
            saveLoginInfo(model: loginInfoModel)
            SVProgressManger.dismiss()
            finishCallBack(loginInfoModel.username, loginInfoModel.is_register)
            }, failed: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            failed(result)
        })
    }
    
    static func saveLoginInfo(model: LoginInfoModel) {
         SDKTool.user_id = model.user_id
         SDKTool.loginCode = model.login_code
         SDKTool.token = model.token
         SDKTool.upgraded = model.upgraded
         SDKTool.userName = model.username
         SDKTool.access_token = model.access_token
         SDKTool.loginId = model.game_url
         SDKTool.loginType = model.login_type
    }
}
