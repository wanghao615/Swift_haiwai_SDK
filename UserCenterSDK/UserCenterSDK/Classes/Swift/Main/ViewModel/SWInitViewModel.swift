//
//  SWInitViewModel.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/31.
//  Copyright © 2020 niujf. All rights reserved.
//

import class OCModule.SVProgressManger

struct SWInitViewModel {
    static func appIterationRemind(finishCallBack: @escaping (AppIterationRemindModel) -> (),                                     nextCallback: @escaping () -> ()) {
          let para = ["appid": SDK.appid,
                      "app_version": KAppCurrentVersion,
                      "sdk_version": SDK.version]
          SVProgressManger.show()
          NetworkRequest(APIUser.appIteration_remind(parameter:para), completion: {
              (result) -> (Void) in
               let jsonDict = JSON(result).dictionaryObject
               if jsonDict != nil {
                  let remindModel = jsonDict?.kj.model(type: AppIterationRemindModel.self)
                  finishCallBack(remindModel as! AppIterationRemindModel)
               }else {
                  nextCallback()
               }
               SVProgressManger.dismiss()
              }, failed: {
               (result) -> (Void) in
               SVProgressManger.dismiss()
               nextCallback()
           })
       }
    
       static func sdkSWConfiguration(finishCallBack: @escaping (String, String, Bool) -> (),
                                           failed: @escaping (String) -> ()) {
       let para = ["appid": SDK.appid,
                   "app_version": KAppCurrentVersion,
                   "sdk_version": SDK.version]
       SVProgressManger.show()
       NetworkRequest(APIUser.sdk_init(parameter:para), completion: {
           (result) -> (Void) in
            let jsonDict = JSON(result).dictionaryObject
            let model: SWSDKInitModel<[Login_Type]> = jsonDict?.kj.model(type: SWSDKInitModel<[Login_Type]>.self) as! SWSDKInitModel<[Login_Type]>
            //缓存配置信息
            SDKTool.resourceId = model.py_resource_id
            SDKTool.serverOrderCallback = model.py_server_callback
            SDKTool.IAPOrderInfo = model.py_url
            SDKTool.currency = model.py_currency
            //缓存支持的登录type
            let supportLoginType: [Login_Type] = model.support_login_type ?? []
            var typeArr: [String] = []
            for loginType in supportLoginType where loginType.type != "guest"{
                typeArr.append(loginType.type)
            }
            SDKTool.supportLoginTypeArr = typeArr
            //缓存协议信息
            SDKTool.user_protocol = model.user_protocol
            SDKTool.user_privacy_protocol = model.user_privacy_protocol
            //缓存是否账号升级的弹框
            SDKTool.popAlert = model.switch_upgrade_account
            SVProgressManger.dismiss()
            finishCallBack(model.client_id, model.game_id, model.sw_protocol)
           }, failed: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            failed(result)
        })
    }
    
    static func sdkAutoLogin(finishCallBack: @escaping () -> (),
                                    failed: @escaping (String) -> ()) {
        let para = ["user_id": SDKTool.user_id,
                    "login_code": SDKTool.loginCode,
                    "appid": SDK.appid,
                    "login_type": SDKTool.loginType]
       SVProgressManger.show()
       NetworkRequest(APIUser.sdk_autoLogin(parameter:para), completion: {
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
    }
}
