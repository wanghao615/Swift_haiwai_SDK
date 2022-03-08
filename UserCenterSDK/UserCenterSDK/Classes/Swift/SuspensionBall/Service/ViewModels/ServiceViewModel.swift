//
//  ServiceViewModel.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/2.
//  Copyright © 2020 niujf. All rights reserved.
//

import KakaJSON
import class OCModule.SVProgressManger

struct ServiceViewModel {
    ///问题类型
    static func feedTypeRequest(finishCallBack: @escaping (_ typeArr: [ServiceTypeModel]) -> (),
                                failed: @escaping (String) -> ()) {
        let para = ["appid": SDK.appid]
        SVProgressManger.show()
        NetworkRequest(APIUser.service_feedType(parameter:para), completion: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            let jsonArr = JSON(result).arrayObject
            //let arr = jsonArr.map {JSON($0).dictionaryValue}
            let typesModels = jsonArr?.kj.modelArray(type: ServiceTypeModel.self)
            finishCallBack(typesModels as! [ServiceTypeModel])
            }, failed: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            failed(result)
        })
    }
    ///提交反馈
    static func submitRequest(parameter: [String: Any],
                              finishCallBack: @escaping () -> (),
                              failed: @escaping (String) -> ()) {
        let para = ["token": SDKTool.token ,
                   "appid": SDK.appid,
                   "server": "",
                   "role_name": "",
                   "role_id": "",
                   "title": parameter["title"]!,
                   "description": parameter["content"]!,
                   "contact": parameter["contact"]!,
                   "type": parameter["type"]!]
        SVProgressManger.show()
        NetworkRequest(APIUser.service_sumit(parameter:para as [String : Any]), completion: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            finishCallBack()
            }, failed: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            failed(result)
        })
    }
    ///反馈问题列表
    static func feedList(page: String,
                         finishCallBack: @escaping (_ feedlistModel: [MyFeedListModel]) -> (),
                         failed: @escaping (String) -> ()) {
        print("page:\(page)")
        let para = ["appid": SDK.appid,
                    "page": page,
                    "pageSize": "10",
                    "token": SDKTool.token]
        SVProgressManger.show()
        NetworkRequest(APIUser.service_feedList(parameter:para), completion: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            let resultDict = JSON(result).dictionaryValue
            let resultArr = JSON(resultDict["items"] as Any).arrayObject
            //let arr = resultArr.map {JSON($0).dictionaryValue}
            let feedListModels = resultArr?.kj.modelArray(type: MyFeedListModel.self)
            finishCallBack(feedListModels as! [MyFeedListModel])
            }, failed: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            failed(result)
        })
    }
    
    static func feedDetail(detailId: Int,
                           finishCallBack: @escaping (MyFeedListModel) -> (),
                           failed: @escaping (String) -> ()) {
        let para = ["appid": SDK.appid,
                    "token": SDKTool.token]
        SVProgressManger.show()
        NetworkRequest(APIUser.service_feedDetail(detailId, parameter: para), completion: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            let result = JSON(result).dictionaryValue
            let detailModel = model(from: result, type: MyFeedListModel.self)
            finishCallBack(detailModel as! MyFeedListModel)
            }, failed: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            failed(result)
        })
    }
    
    static func feedReplyLsit(feedId: Int,
                              finishCallBack: @escaping ([FeedReplyListModel]) -> (),
                              failed: @escaping (String) -> ()) {
        let para = ["appid": SDK.appid,
                    "feedback_id": "\(feedId)",
                    "token": SDKTool.token]
        SVProgressManger.show()
        NetworkRequest(APIUser.service_feedReplyList(parameter:para), completion: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            print(JSON(result))
            let jsonArr = JSON(result).arrayObject
            //let arr = jsonArr.map {JSON($0).dictionaryValue}
            let replyListModels = jsonArr?.kj.modelArray(type: FeedReplyListModel.self)
            finishCallBack(replyListModels as! [FeedReplyListModel])
            }, failed: {
            (result) -> (Void) in
            SVProgressManger.dismiss()
            failed(result)
        })
    }
    
    static func feedReply(feedId: Int,
                          replyContent: String,
                          finishCallBack: @escaping () -> (),
                          failed: @escaping (String) -> ()) {
        let para = ["appid": SDK.appid,
                    "id": "\(feedId)",
                    "reply": replyContent,
                    "token": SDKTool.token]
        SVProgressManger.show()
        NetworkRequest(APIUser.service_feedAdditionalQ(parameter:para), completion: {
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
