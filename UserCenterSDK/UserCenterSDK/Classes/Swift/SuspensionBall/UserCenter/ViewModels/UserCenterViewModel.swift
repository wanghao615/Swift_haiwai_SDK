//
//  UserCenterViewModel.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/8.
//  Copyright © 2020 niujf. All rights reserved.
//
import class OCModule.BridgeManger
import class OCModule.SVProgressManger

struct UserCenterViewModel {
    static func accountStatus(finishCallBack: @escaping (UserCenterStatusModel<[UserCenterAccountStatusModel]>) -> (),
                              failed: @escaping (String) -> ()) {
        let para = ["appid": SDK.appid,
                    "token": SDKTool.token]
        SVProgressManger.show()
        NetworkRequest(APIUser.usercenter_accountStatus(parameter:para), completion: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            let jsonDict = JSON(result).dictionaryObject
            let statusModel = jsonDict?.kj.model(type: UserCenterStatusModel<[UserCenterAccountStatusModel]>.self)
            finishCallBack(statusModel as! UserCenterStatusModel<[UserCenterAccountStatusModel]>)
            }, failed: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            failed(result)
        })
    }
    
    static func logout(finishCallBack: @escaping () -> (),
                       failed: @escaping (String) -> ()) {
        let para = ["appid": SDK.appid,
                    "token": SDKTool.token]
        SVProgressManger.show()
        NetworkRequest(APIUser.usercenter_logout(parameter:para), completion: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            finishCallBack()
            }, failed: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            failed(result)
        })
    }
    
    static func bindingThird(channel: String,
                             code: String,
                             auth_info: String,
                             finishCallBack: @escaping () -> (),
                             failed: @escaping (String) -> ()) {
        let para = ["appid": SDK.appid,
                    "channel": channel,
                    "code": code,
                    "plat": "os",
                    "reg_from": "3",
                    "client_type": "3",
                    "auth_info": auth_info,
                    "redirect_uri": "",
                    "token": SDKTool.token]
        SVProgressManger.show()
        NetworkRequest(APIUser.usercenter_bindingThirdAccount(parameter:para), completion: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            finishCallBack()
            }, failed: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            failed(result)
        })
    }
    
    static func checkPass(pass: String,
                          finishCallBack: @escaping () -> (),
                          failed: @escaping (String) -> ()) {
        let para = ["appid": SDK.appid,
                    "pass": pass.n.md5,
                    "token": SDKTool.token]
        SVProgressManger.show()
        NetworkRequest(APIUser.usercenter_checkPass(parameter:para), completion: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            finishCallBack()
            }, failed: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            failed(result)
        })
    }

    static func updatePassByOld(oldPass: String,
                                pass: String,
                                finishCallBack: @escaping () -> (),
                                failed: @escaping (String) -> ()) {
        let para = ["appid": SDK.appid,
                    "old_pass": oldPass.n.md5,
                    "new_pass": pass.n.md5,
                    "token": SDKTool.token]
        SVProgressManger.show()
        NetworkRequest(APIUser.usercenter_updatePassByOld(parameter:para), completion: {
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
    
    static func bindPhone(mobile: String,
                          code: String,
                          zone: String,
                          finishCallBack: @escaping () -> (),
                          failed: @escaping (String) -> ()) {
        let para = ["appid": SDK.appid,
                    "token": SDKTool.token,
                    "code": code,
                    "zone": zone,
                    "mobile": mobile]
        SVProgressManger.show()
        NetworkRequest(APIUser.usercenter_bindPhone(parameter:para), completion: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            finishCallBack()
            }, failed: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            failed(result)
        })
    }
}
