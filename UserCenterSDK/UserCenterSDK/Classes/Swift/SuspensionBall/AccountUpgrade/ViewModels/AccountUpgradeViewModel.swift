//
//  AccountUpgradeViewModel.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/31.
//  Copyright © 2020 niujf. All rights reserved.
//

import class OCModule.SVProgressManger
import class OCModule.Statistics

struct AccountUpgradeViewModel {
    static func third(channel: String,
                      code: String,
                      auth_info: String,
                      finishCallBack: @escaping () -> (),
                      failed: @escaping (String) -> ()){
        let para = ["appid": SDK.appid,
                    "channel": channel,
                    "code": code,
                    "plat": "os",
                    "reg_from": "SDK",
                    "client_type": "3",
                    "equip": SDK.equipUUID,
                    "token": SDKTool.token,
                    "redirect_uri": "",
                    "auth_info": auth_info,
        ]
        SVProgressManger.show()
        NetworkRequest(APIUser.accountUpgrade_third(parameter:para), completion: {
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
