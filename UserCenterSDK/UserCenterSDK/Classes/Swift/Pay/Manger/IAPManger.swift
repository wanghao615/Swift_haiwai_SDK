//
//  IAPManger.swift
//  KingNetSDK
//
//  Created by admin on 2021/1/4.
//  Copyright © 2021 niujf. All rights reserved.
//
import UIKit
import class OCModule.Statistics
import class OCModule.SVProgressManger

class IAPManger: NSObject {
    static var statusCallback: ((String) -> ())?
    
    static func startDict(_ dict: [String: String], statusCallback: @escaping (String) -> ()) {
        self.statusCallback = statusCallback
        let productId: String = dict["productId"] ?? ""
        let roleName: String = dict["userName"] ?? ""
        let roleId: String = dict["userId"] ?? ""
        let serverId: String = dict["serverId"] ?? ""
        //获取商品信息
        IAPViewModel.getProductInfo(finishCallBack: {
            (dictServer: [String: Any]) in
            let price = dictServer[productId]
            //请求苹果后台获取商品信息
            IAPTool.share.requestWithProductId(productId) {
                //dana统计
                let danaDict = ["step": "1",
                                "pay_amount": JSON(price as Any).stringValue,
                                "currency": SDKTool.currency,
                                "itemid": productId,
                                "itemnum": "1",
                                "type": "2",
                                "orderid": "-1",
                                "rolename": roleName,
                                "serverid": serverId,
                                "roleid": roleId]
                Statistics.startPay(withDict: danaDict)
                //创建订单信息
                var model: IAPOrderModel = IAPOrderModel()
                model.real_price = JSON(price as Any).stringValue
                model.appOrderID = dict["orderId"] ?? ""
                model.SID = serverId
                model.amount = JSON(price as Any).stringValue
                model.productName = dict["productName"] ?? ""
                model.productId = productId
                model.appUserName = roleName
                model.roleId = roleId
                model.callback_url = dict["callback_url"] ?? ""
                model.appUserID = dict["userId"] ?? ""
                model.location = "zh_CN@currency=CNY"
                model.real_loc = "zh_CN@currency=CNY"
                model.order_id = dict["orderId"] ?? ""
                model.states = "Pending"
                model.app_extra1 = dict["app_extra1"] ?? ""
                model.app_extra2 = dict["app_extra2"] ?? ""
                createOrder(model)
            } skProductfailed: { (failedStrig) in
                iapFail(price: dict["price"] ?? "", productId: productId, orderId: "", roleName: roleName, serverId: serverId, roleId: roleId, status: failedStrig)
                SVProgressManger.showError(withStatus: failedStrig)
            }

            
        }) { (failedStrig) in
            iapFail(price: dict["price"] ?? "", productId: productId, orderId: "", roleName: roleName, serverId: serverId, roleId: roleId, status: failedStrig)
            SVProgressManger.showError(withStatus: failedStrig)
        }
    }
    
    private static func createOrder(_ model: IAPOrderModel) {
        IAPViewModel.creatOrder(model: model, finishCallBack: {
            (orderId: String) in
            //dana
            let dictS = ["step": "2",
                         "pay_amount": model.real_price,
                         "currency": SDKTool.currency,
                         "itemid": model.productId,
                         "itemnum": "1",
                         "type": "2",
                         "orderid": orderId,
                         "rolename": model.appUserName,
                         "serverid": model.SID,
                         "roleid": model.appUserID]
            Statistics.startPay(withDict: dictS)
            SVProgressManger.dismiss()
            SVProgressManger.show(withStatus: SDK.R.string.iap_purchasing)
            IAPTool.share.addPayment()
            checkOrderId(orderId, model.appUserName, model.appUserID, model.SID, model.real_price)
        }) { (failedStrig) in
            iapFail(price: model.real_price, productId: model.productId, orderId: "", roleName: model.appUserName, serverId: model.SID, roleId: model.roleId, status: failedStrig)
            SVProgressManger.showError(withStatus: failedStrig)
        }
    }
    
    private static func checkOrderId(_ orderId: String,
                                     _ roleName: String,
                                     _ roleId: String,
                                     _ serverId: String,
                                     _ price: String) {
        print("订单号: " + orderId)
        IAPTool.share.removeProgressCallback = {
            SVProgressManger.dismiss()
            SVProgressManger.showError(withStatus: SDK.R.string.iap_fail)
        }
        
        IAPTool.share.skPurchasedCancelCallback = {
            (productId: String, price: String) in
            SVProgressManger.dismiss()
            SVProgressManger.showError(withStatus: SDK.R.string.iap_fail)
            let dict = ["currency": SDKTool.currency,
                        "pay_amount": price,
                        "orderid": orderId,
                        "type": "2",
                        "itemid": productId,
                        "itemnum": "1",
                        "rolename": roleName,
                        "serverid": serverId,
                        "roleid": roleId]
            Statistics.cancelPay(withDict: dict)
        }
        
        IAPTool.share.skOrderCallback = {
            (base64S: String, appleOderId: String, productId: String) in
            if productId.count > 0 {//统计
                let dict = ["pay_amount": price,
                            "currency": SDKTool.currency,
                            "rolename": roleName,
                            "serverid": serverId,
                            "roleid": roleId]
                Statistics.ecommerce_purchase(withDict: dict)
                var payTimes = SDKTool.payTimes
                payTimes += 1
                SDKTool.payTimes = payTimes
                if payTimes == 1 {
                    var fistPayDict = ["orderid": orderId,
                                       "pay_amount": price,
                                       "currency": SDKTool.currency,
                                       "itemid": productId,
                                       "type": "2",
                                       "rolename": roleName,
                                       "serverid": serverId,
                                       "roleid": roleId]
                    
                    fistPayDict["ouid"] = SDKTool.user_id
                    fistPayDict["package_id"] = SDK.appid
                    fistPayDict["gameid"] = SDK.gameId
                    
                    Statistics.fistPay(withDict: fistPayDict)
                    AdjustService.event(token: SDKTool.adjustEventList["firstpay"] as! String, para: fistPayDict)
                }
                //开始校验
                IAPViewModel.verOrder(base64Order: base64S, appOrder: appleOderId, OrderId: orderId, finishCallBack: {
                    SVProgressManger.showSuccess(withStatus: SDK.R.string.iap_success)
                    GCDTool.delay(1) {
                        SVProgressManger.dismiss()
                    }
                    if statusCallback != nil { statusCallback! ("0") }
                    if SDKTool.upgraded == "0", SDKTool.popAlert == 1{//通过游客登录,且需要账号升级弹框提醒
                        UserCenterSDK.share.popUpgradeSelectView()
                    }
                }) { (failedStrig) in
                    print(failedStrig);
                    SVProgressManger.showError(withStatus: failedStrig)
                }
            }
        }
    }
}

extension IAPManger {
    private static func iapFail(price: String,
                                productId: String,
                                orderId: String,
                                roleName: String,
                                serverId: String,
                                roleId: String,
                                status: String) {
        if statusCallback != nil { statusCallback! ("1") }
        let dict = ["currency": SDKTool.currency,
                    "pay_amount": price,
                    "orderid": orderId,
                    "type": "2",
                    "itemid": productId,
                    "status": status,
                    "rolename": roleName,
                    "serverid": serverId,
                    "roleid": roleId]
        Statistics.payFail(withDict: dict)
    }
}
