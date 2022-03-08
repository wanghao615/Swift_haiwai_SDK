//
//  APIUser.swift
//  SwiftDemo
//
//  Created by niujf on 2019/4/28.
//  Copyright © 2019 niujf. All rights reserved.
//

import Foundation
import Moya

enum APIUser {
    /********************AppIterationRemind****************/
    case appIteration_remind(parameter: [String: Any])
    /********************初始化****************/
    case sdk_init(parameter: [String: Any])
    case sdk_autoLogin(parameter: [String: Any])
    /********************登录模块****************/
    case login_register(parameter: [String: Any])
    case login_l(parameter: [String: Any])
    case login_emailInfo(parameter: [String: Any])
    case login_thirdAuthorize(parameter: [String: Any])
    case login_guest(parameter: [String: Any])
    /********************绑定邮箱****************/
    case bindingEmail_bind(parameter: [String: Any])
    case accountUpgrade_upgrade(parameter: [String: Any])
    /********************账户升级****************/
    case accountUpgrade_third(parameter: [String: Any])
    /********************通用模块****************/
    case u_sendEmailCode(parameter: [String: Any])
    case u_sendPhoneCode(parameter: [String: Any])
    case u_checkEmailCode(parameter: [String: Any])
    case u_checkPhoneCode(parameter: [String: Any])
    case u_updatePassByEmail(parameter: [String: Any])
    case u_updatePassByPhone(parameter: [String: Any])
    /********************客服模块****************/
    case service_feedType(parameter: [String: Any])
    case service_sumit(parameter: [String: Any])
    case service_feedList(parameter: [String: Any])
    case service_feedDetail(_ detailId: Int, parameter: [String: Any])
    case service_feedReplyList(parameter: [String: Any])
    case service_feedAdditionalQ(parameter: [String: Any])
    /********************个人中心模块****************/
    case usercenter_accountStatus(parameter: [String: Any])
    case usercenter_logout(parameter: [String: Any])
    case usercenter_bindingThirdAccount(parameter: [String: Any])
    case usercenter_checkPass(parameter: [String: Any])
    case usercenter_updatePassByOld(parameter: [String: Any])
    case usercenter_bindPhone(parameter: [String: Any])
    /********************内购模块****************/
    case iap_getProductInfo(parameter: [String: Any])
    case iap_creatOrder(_ resourceId: String, parameter: [String: Any])
    case iap_verOrder(_ resourceId: String, parameter: [String: Any])
}

extension APIUser: TargetType {
    var baseURL: URL {
        switch self {
        case .iap_creatOrder, .iap_verOrder:
            return URL.init(string: SDKTool.IAPOrderInfo)!
        default:
            return URL.init(string: User_BaseUrl + SDK.requestLanguage)!
        }
    }
    
    var path: String {
        switch self {
        case .appIteration_remind:
            return AppIteration_Remind
        case .sdk_init:
            return SDK_Init
        case .sdk_autoLogin:
            return SDK_AutoLogin
        // MARK: - 登录
        case .login_register:
            return Login_Register
        case .login_l:
            return Login_L
        case .login_emailInfo:
            return Login_EmailInfo
        case .login_thirdAuthorize:
            return Login_ThirdAuthorize
        case .login_guest:
            return Login_Guest
        // MARK: - 绑定邮箱
        case .bindingEmail_bind:
            return BindingEmail_Bind
        case .accountUpgrade_upgrade:
            return BindingEmail_Upgrade
        // MARK: - 账户升级
        case .accountUpgrade_third:
            return AccountUpgrade_Third
        // MARK: - 通用模块
        case .u_sendEmailCode:
            return U_SendEmailCode
        case .u_sendPhoneCode:
            return U_SendPhoneCode
        case .u_checkEmailCode:
            return U_CheckEmailCode
        case .u_checkPhoneCode:
            return U_CheckPhoneCode
        case .u_updatePassByEmail:
            return U_UpdatePassByEmail
        case .u_updatePassByPhone:
            return U_UpdatePassPhone
        // MARK: - 客服
        case .service_feedType:
            return Service_FeedType
        case .service_sumit:
            return Service_Submit
        case .service_feedList:
            return Service_FeedList
        case let .service_feedDetail(detailId, parameter: _):
            return Service_FeedList + "/\(detailId)"
        case .service_feedReplyList:
            return Service_FeedReplyList
        case .service_feedAdditionalQ:
            return Service_FeedAdditionalQ
        // MARK: - 个人中心
        case .usercenter_accountStatus:
            return UserCenter_AccountStatus
        case .usercenter_logout:
            return UserCenter_Logout
        case .usercenter_bindingThirdAccount:
            return UserCenter_BindingThirdAccount
        case .usercenter_checkPass:
            return UserCenter_CheckPass
        case .usercenter_updatePassByOld:
            return UserCenter_UpdatePassByOld
        case .usercenter_bindPhone:
            return UserCenter_BindPhone
        // MARK: - 内购
        case .iap_getProductInfo:
            return IAP_GetProductInfo
        case let .iap_creatOrder(resourceId, parameter: _):
            return IAP_CreatOrder + resourceId
        case let .iap_verOrder(resourceId, parameter: _):
            return IAP_VerOrder + resourceId
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .appIteration_remind:
            return .get
        case .service_feedType:
            return .get
        case .service_feedList:
            return .get
        case .service_feedDetail:
            return .get
        case .service_feedReplyList:
            return .get
        case .iap_getProductInfo:
            return .get
        default:
            return .post
        }
    }
    
    ///这个是做单元测试模拟的数据，必须要实现，只在单元测试文件中有作用
    var sampleData: Data {
         return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case let .appIteration_remind(parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
        case let .sdk_init(parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
        case let .sdk_autoLogin(parameter: parameter):
        return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
        // MARK: - 登录
        case let .login_register(parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
        case let .login_l(parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
        case let .login_thirdAuthorize(parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
        case let .login_guest(parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
        case let .login_emailInfo(parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
        // MARK: - 绑定邮箱
        case let .bindingEmail_bind(parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
        case let .accountUpgrade_upgrade(parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
        // MARK: - 账户升级
        case let .accountUpgrade_third(parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
        // MARK: - 通用模块
        case let .u_sendEmailCode(parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
        case let .u_sendPhoneCode(parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
        case let .u_checkEmailCode(parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
        case let .u_checkPhoneCode(parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
        case let .u_updatePassByEmail(parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
        case let .u_updatePassByPhone(parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
        // MARK: - 客服
        case let .service_feedType(parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
        case let .service_sumit(parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
        case let .service_feedList(parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
        case let .service_feedDetail(_, parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
        case let .service_feedReplyList(parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
        case let .service_feedAdditionalQ(parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
        // MARK: - 个人中心
        case let .usercenter_accountStatus(parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
        case let .usercenter_logout(parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
        case let .usercenter_bindingThirdAccount(parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
        case let .usercenter_checkPass(parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
        case let .usercenter_updatePassByOld(parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
        case let .usercenter_bindPhone(parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
        // MARK: - 内购
        case let .iap_getProductInfo(parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
        case let .iap_creatOrder(_, parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
        case let .iap_verOrder(_, parameter: parameter):
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return [
                "Accept": "application/json",
                //"content-type":"form-data"
                "encrypt-type": "xxtea",
                //"content-type":"application/x-www-form-urlencoded"
               ]
    }
}
