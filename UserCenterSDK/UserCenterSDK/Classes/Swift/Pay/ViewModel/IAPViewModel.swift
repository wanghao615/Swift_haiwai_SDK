//
//  IAPViewModel.swift
//  KingNetSDK
//
//  Created by admin on 2021/1/4.
//  Copyright © 2021 niujf. All rights reserved.
//
import class OCModule.SVProgressManger
import class OCModule.BridgeManger

struct IAPViewModel {
    static func getProductInfo(finishCallBack: @escaping ([String: Any]) -> (),
                               failed: @escaping (String) -> ()) {
        let para = ["package_name": KAPPBundleIdentifier,
                    "app_version": KAppCurrentVersion,
                    "sdk_version": SDK.version,
                    "appid": SDK.appid]
        SVProgressManger.show(withStatus: SDK.R.string.iap_getProductInfo)
        NetworkRequest(APIUser.iap_getProductInfo(parameter: para), completion: {
           (result) -> (Void) in
            let resultDict = JSON(result).dictionaryObject
            let listArr = JSON(resultDict?["list"] as Any).arrayValue
            var dict: [String: Any] = [:]
            for i in 0..<listArr.count {
                let listD = JSON(listArr[i]).dictionaryValue
                let key = JSON(listD["product_id"] as Any).stringValue
                dict[key] = listD["price"]
            }
            //SVProgressManger.dismiss()
            finishCallBack(dict)
           }, failed: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            failed(result)
        })
    }
    
    static func creatOrder(model: IAPOrderModel,
                           finishCallBack: @escaping (String) -> (),
                           failed: @escaping (String) -> ()) {
        var para = ["action": "applemgaespost",
                    "sid": model.SID,
                    "pay_rmb": model.amount,
                    "product_id": model.productId,
                    "product_name": model.productName,
                    "app_order_id": model.order_id,
                    "app_user_name": model.appUserName,
                    "app_callback_url": model.callback_url,
                    "real_price": model.real_price,
                    "location": model.location,
                    "real_loc": model.real_loc,
                    "openuid": SDKTool.user_id,
                    "app_name": KAppName,
                    "resource_id": SDKTool.resourceId,
                    "package_name": KAPPBundleIdentifier,
                    "device_type": "iOS",
                    "uid": model.appUserID,
                    "app_key": SDK.appid,
                    "callback_url": SDKTool.serverOrderCallback,
                    "app_extra1": model.app_extra1,
                    "app_extra2": model.app_extra2,
                    "imei": SDK.equipUUID]
        //签名
        let sign = BridgeManger.getSignWithDict(para)
        para["sign"] = sign
        let jsonStr = JSON(para).description
        let aesS = BridgeManger.encrypt(withAES: jsonStr)
        let dict = ["deyuliu": aesS]
        SVProgressManger.dismiss();
        SVProgressManger.show(withStatus: SDK.R.string.iap_creatOrder)
        NetworkRequest(APIUser.iap_creatOrder(SDKTool.resourceId, parameter: dict), completion: {
           (result) -> (Void) in
            let resultDict = JSON(result).dictionaryObject
            //SVProgressManger.dismiss()
            finishCallBack(resultDict?["order_id"] as! String)
           }, failed: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            failed(result)
        })
    }
    
    static func verOrder(base64Order: String,
                         appOrder: String,
                         OrderId: String,
                         finishCallBack: @escaping () -> (),
                         failed: @escaping (String) -> ()) {
        var para = ["order_id": OrderId,
                    "apple_order_id": appOrder,
                    "receipt-data": base64Order]
        let sign = (OrderId + appOrder + base64Order + Ver_Key).n.md5
        para["sign"] = sign
        let afPara = BridgeManger.getPara(OrderId)
        para["af"] = afPara
        let jsonStr = JSON(para).description
        let aesS = BridgeManger.encrypt(withAES: jsonStr)
        let dict = ["deyuliu": aesS]
        SVProgressManger.show(withStatus: SDK.R.string.iap_verOrder)
        NetworkRequest(APIUser.iap_verOrder(SDKTool.resourceId, parameter: dict), completion: {
           (result) -> (Void) in
            SVProgressManger.dismiss()
            finishCallBack()
           }, failed: {
            (result) -> (Void) in
            //print(result)
            SVProgressManger.dismiss()
            if !result.contains("OrderProcessing") {//正在处理订单
                retryVerOrder(SDKTool.resourceId, dict, finishCallBack, failed)
            }
        })
    }
    
    ///校验订单添加重试机制
    private static func retryVerOrder(_ resourceId: String,
                                      _ para: [String: Any],
                                      _ finishCallBack: @escaping () -> (),
                                      _ failed: @escaping (String) -> ()) {
        NetworkRequest(APIUser.iap_verOrder(resourceId, parameter: para), completion: {
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
