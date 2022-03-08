//
//  APIUserConfig.swift
//  SwiftDemo
//
//  Created by niujf on 2019/4/28.
//  Copyright © 2019 niujf. All rights reserved.
//

import Foundation

///baseUrl
let User_BaseUrl = "https://user.gamehaza.com/"

///参数加密key
let Para_Key = "oxKddFw0opc2ayAqm-WJCfzwdukeFwMFxPy6ClJWe_s"
let XXTEA_Key = "YhAY9FjSeo2WC7oeyhhoGZupa8g"
let Ver_Key = "cf9b337069cb5dec34d1b3f266306bd8"

///path
/***********************AppIterationRemind*********************/
let AppIteration_Remind = "/sdk/config/appIteration"
/***********************初始化*********************/
let SDK_Init = "/sdk/config/sdkInit"
let SDK_AutoLogin = "/sdk/account/loginCode"
/***********************登录模块*********************/
let Login_Register = "/sdk/account/regAccount"
let Login_L = "/sdk/account/loginAccount"
let Login_EmailInfo = "/sdk/account/bindInfo"
let Login_ThirdAuthorize = "/third/authorize"
let Login_Guest = "/sdk/guest/login"
/***********************绑定邮箱*********************/
let BindingEmail_Bind = "/sdk/account/bindAccount"
let BindingEmail_Upgrade = "/sdk/guest/upgradeToAccount"
/***********************账户升级*********************/
let AccountUpgrade_Third = "/sdk/guest/upgradeToThirdAccount"
/***********************通用模块*********************/
let U_SendEmailCode = "/sdk/email/sendCode"
let U_SendPhoneCode = "/sdk/account/code"
let U_CheckEmailCode = "/sdk/email/checkCode"
let U_CheckPhoneCode = "/sdk/account/checkCode"
let U_UpdatePassByEmail = "/sdk/account/findPassByEmail"
let U_UpdatePassPhone = "/sdk/account/findPassByMobile"
/***********************个人中心*********************/
let UserCenter_AccountStatus = "/sdk/config/moduleList"
let UserCenter_Logout = "/sdk/account/logout"
let UserCenter_BindingThirdAccount = "/sdk/account/bindThirdAccount"
let UserCenter_CheckPass = "/sdk/account/checkPass"
let UserCenter_UpdatePassByOld = "/sdk/account/updatePassByOld"
let UserCenter_BindPhone = "/sdk/account/bindMobile"
/***********************客服模块*********************/
let Service_FeedType = "/sdk/feedback/type"
let Service_Submit = "/sdk/account/postFeedback"
let Service_FeedList = "/sdk/account/feedback";
let Service_FeedReplyList = "/sdk/account/feedbackReplyList";
let Service_FeedAdditionalQ = "/sdk/account/replyFeedback"
/***********************内购模块*********************/
let IAP_GetProductInfo = "/sdk/config/getProductInfo"
let IAP_CreatOrder = "?action=applemgaespost&resource_id="
let IAP_VerOrder = "?action=applesdknewnotifymg&resource_id="
