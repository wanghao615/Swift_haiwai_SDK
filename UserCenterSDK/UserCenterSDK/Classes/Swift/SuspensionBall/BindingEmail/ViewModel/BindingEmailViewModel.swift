//
//  BindingEmailViewModel.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/24.
//  Copyright © 2020 niujf. All rights reserved.
//

import class OCModule.SVProgressManger
import class OCModule.Statistics

struct BindingEmailViewModel {
    static func bind(username: String,
                             code: String,
                             pass: String,
                             finishCallBack: @escaping () -> (),
                             failed: @escaping (String) -> ()) {
        let para = ["appid": SDK.appid,
                    "pass": pass.n.md5,
                    "token": SDKTool.token,
                    "username": username,
                    "code": code]
        SVProgressManger.show()
        NetworkRequest(APIUser.bindingEmail_bind(parameter:para), completion: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            finishCallBack()
            }, failed: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            failed(result)
        })
    }
    
    static func upgrade(email: String,
                      pass: String,
                      code: String,
                      finishCallBack: @escaping () -> (),
                      failed: @escaping (String) -> ()){
        let para = ["appid": SDK.appid,
                    "username": email,
                    "pass": pass.n.md5,
                    "code": code,
                    "equip": SDK.equipUUID,
                    "token": SDKTool.token,
        ]
        SVProgressManger.show()
        NetworkRequest(APIUser.accountUpgrade_upgrade(parameter:para), completion: {
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
