//
//  SDK.swift
//  KingNetSDK
//
//  Created by admin on 2020/11/26.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

struct SDK {
    // MARK: - basic property
    ///初始化配置文件
    static let configurator = "SDKConfigurator"
    ///事件列表
    static let eventList = "AdjustEvent"
    /// SDK版本号
    static var version: String = ""
    ///请求设置的语言
    static var requestLanguage: String = ""
    ///appid
    static var appid: String = ""
    ///gameId
    static var gameId: String = ""
    ///设备UUID
    static var equipUUID: String = ""
    ///系统的语言
    static var sysLanguage: String {
        return UserDefaults.standard.string(forKey: "appLanguage") ?? ""
    }
    
    ///主size
    static let size: CGSize = CGSize(width: 388 * K_Ratio, height: 248 * K_Ratio)
    ///注册箱的SDKSize
    static let registerSize: CGSize = CGSize(width: 380 * K_Ratio, height: 298 * K_Ratio)
    ///选择框的size
    static let alertSelSize: CGSize = CGSize(width: 308 * K_Ratio, height: 208 * K_Ratio)
    ///客服的SDKSize
    static let severSize: CGSize = CGSize(width: 388 * K_Ratio, height: 308 * K_Ratio)
    ///绑定邮箱的SDKSize
    static let bindingEmailSize: CGSize = CGSize(width: 380 * K_Ratio, height: 290 * K_Ratio)
    
    // MARK: - colorSetting
    enum Color {
        static var theme = SColor(103, 106, 114)
        static var themeBlue = SColor(0, 149, 254)
        static var themeBorder = AColor(103, 116, 114, 0.1)
        static var themePlaceHolder = SColor(173, 174, 178)
        static var themeTextfieldBorder = SColor(239, 240, 240)
        static var themePicker = SColor(210, 211, 215)
        static var themePickerSelView = SColor(237, 238, 240)
        static var themeUserCenterBorder = AColor(103, 106, 114, 0.1)
        static var themeRemindBGColor = SColor(248, 248, 234)
        static var themeRemindColor = RColor(0xffb83b)
    }
    
    static var AColor = {
        UIColor.init(r: $0, g: $1, b: $2, a:$3)
    }
    
    static var SColor = {
        UIColor.init(r: $0, g: $1, b: $2)
    }
    
    static var RColor = {
        UIColor.init(rgb: $0)
    }
    
    // MARK: - FONT
    enum Font {
        static func arial(_ size: CGFloat) -> UIFont? {
            UIFont(name: "Arial", size: size)
        }
        static func helveticaBold(_ size: CGFloat) -> UIFont? {
            UIFont(name: "Helvetica-Bold", size: size)
        }
    }
    
    // MARK: - 资源名
    enum R {
        enum image {
            /*****************appIterationRemind***************/
            static var appIteration_remind = UIImage(named: IBundle("appIteration_remind"))
            /*****************Base***************/
            static var main_back = UIImage(named: IBundle("main_back"))
            static var main_back_arrow = UIImage(named: IBundle("main_back_arrow"))
            static var main_back_close = UIImage(named: IBundle("main_back_close"))
            /*****************通用***************/
            static var u_btnBack = UIImage(named: IBundle("u_btnBack"))
            static var u_btnBack_high = UIImage(named: IBundle("u_btnBack_high"))
            static var u_pass = UIImage(named: IBundle("u_pass"))
            static var u_logo = UIImage(named: IBundle("logo"))
            /*****************用户协议***************/
            static var userProtocol_agree = UIImage(named: IBundle("userProtocol_agree"))
            static var userProtocol_agree_high = UIImage(named: IBundle("userProtocol_agree_high"))
            /*****************悬浮球***************/
            static var floatingBall_high = UIImage(named: IBundle("floatingBall_high"))
            static var floatingBall = UIImage(named: IBundle("floatingBall"))
            static var floatingBall_dot = UIImage(named: IBundle("floatingBall_dot"))
            static var floatingBall_menu_left = UIImage(named: IBundle("floatingBall_menu_left"))
            static var floatingBall_menu_right = UIImage(named: IBundle("floatingBall_menu_right"))
            static var floatingBall_upgrade = UIImage(named: IBundle("floatingBall_upgrade"))
            static var floatingBall_center = UIImage(named: IBundle("floatingBall_center"))
            static var floatingBall_service = UIImage(named: IBundle("floatingBall_service"))
            /*****************登录***************/
            static var login_email = UIImage(named: IBundle("email_id"))
            static var login_google = UIImage(named: IBundle("google"))
            static var login_facebook = UIImage(named: IBundle("facebook"))
            static var login_line = UIImage(named: IBundle("line"))
            static var login_naver = UIImage(named: IBundle("naver"))
            static var login_twitter = UIImage(named: IBundle("twitter"))
            static var login_guest = UIImage(named: IBundle("guest"))
            static var login_agree = UIImage(named: IBundle("login_agree"))
            static var login_agreeNo = UIImage(named: IBundle("login_agreeNo"))
            static var login_success = UIImage(named: IBundle("loginSuccess"))
            /*****************绑定邮箱***************/
            static var bindingEmail_email = UIImage(named: IBundle("bindingEmail_email"))
            /*****************账户升级***************/
            static var accountUpgrade_accBg = UIImage(named: IBundle("accountUpgrade_accBg"))
            /*****************个人中心***************/
            static var usercenter_btnBack = UIImage(named: IBundle("usercenter_btnBack"))
            static var usercenter_btnBack_high = UIImage(named: IBundle("usercenter_btnBack_high"))
            static var usercenter_exitBtnBack = UIImage(named: IBundle("usercenter_exitBtnBack"))
            static var usercenter_exitBtnBack_high = UIImage(named: IBundle("usercenter_exitBtnBack_high"))
            static var usercenter_google_high = UIImage(named: IBundle("usercenter_google_high"))
            static var usercenter_google = UIImage(named: IBundle("usercenter_google"))
            static var usercenter_facebook_high = UIImage(named: IBundle("usercenter_facebook_high"))
            static var usercenter_facebook = UIImage(named: IBundle("usercenter_facebook"))
            static var usercenter_line_high = UIImage(named: IBundle("usercenter_line_high"))
            static var usercenter_line = UIImage(named: IBundle("usercenter_line"))
            static var usercenter_naver_high = UIImage(named: IBundle("usercenter_naver_high"))
            static var usercenter_naver = UIImage(named: IBundle("usercenter_naver"))
            static var usercenter_twitter_high = UIImage(named: IBundle("usercenter_twitter_high"))
            static var usercenter_twitter = UIImage(named: IBundle("usercenter_twitter"))
            static var usercenter_AlertUback = UIImage(named: IBundle("usercenter_alertUback"))
            static var usercenter_cancel = UIImage(named: IBundle("usercenter_cancel"))
            static var usercenter_cancel_high = UIImage(named: IBundle("usercenter_cancel_high"))
            static var usercenter_passEye = UIImage(named: IBundle("usercenter_passEye"))
            static var usercenter_passEye_high = UIImage(named: IBundle("usercenter_passEye_high"))
            static var usercenter_passNum = UIImage(named: IBundle("usercenter_passNum"))
            static var usercenter_success = UIImage(named: IBundle("usercenter_success"))
            static var usercenter_phone = UIImage(named: IBundle("usercenter_phone"))
            static var usercenter_phoneArrow = UIImage(named: IBundle("usercenter_phoneArrow"))
            static var usercenter_phoneArrow_up = UIImage(named: IBundle("usercenter_phoneArrow_up"))
            /*****************客服***************/
            static var service_feedback_arrow = UIImage(named: IBundle("service_feedback_arrow"))
            static var service_arrowDown = UIImage(named: IBundle("service_arrowDown"))
            static var service_arrowUp = UIImage(named: IBundle("service_arrowUp"))
        }
        
        enum string {
            /*****************Base***************/
            static var main_title = Localized("KN_Login")
            /*****************通用***************/
            static var u_sumit = Localized("KN_LoginSumit")
            static var u_modifyPass = Localized("KN_LoginModifyPass")
            static var u_bindingAccount = Localized("KN_UserBindingAccount")
            static var u_smsCode = Localized("KN_LoginWriteCode")
            static var u_pass = Localized("KN_LoginPassWord")
            static var u_next = Localized("KN_LoginNext")
            static var u_account = Localized("KN_LoginAccount")
            static var u_phone = Localized("KN_Phone")
            static var u_passByEmail = Localized("KN_LoginByEmail")
            static var u_passByPhone = Localized("KN_LoginByPhone")
            static var u_accountExit = Localized("KN_UserPrefAccount")
            static var u_passRule = Localized("KN_LoginPassRule")
            static var u_cancel = Localized("KN_Cancel")
            static var u_confirm = Localized("KN_Confirm")
            /*****************用户协议***************/
            static var userProtocol_agree = Localized("KN_Agree")
            static var userProtocol_game = Localized("KN_AgreeGameProtocol")
            static var userProtocol_user = Localized("KN_AgreeUserProtocol")
            static var userProtocol_remind = Localized("KN_NoAgreeUserProtocol")
            /*****************登录***************/
            static var login_type = Localized("KN_LoginType")
            static var login_email = Localized("KN_LoginEmail")
            static var login_emailAccount = Localized("KN_LoginEmailAccount")
            static var login_l = Localized("KN_Login")
            static var login_register = Localized("KN_LoginRegister")
            static var login_retrievePass = Localized("KN_LoginRetrievePassword")
            static var login_agree = Localized("KN_LoginAgreement")
            static var login_checkAgree = Localized("KN_LoginCheckRegulations")
            static var login_agreeTips = Localized("KN_LoginAgreementToast")
            static var login_startGame = Localized("KN_LoginStartGame")
            static var login_welcome = Localized("KN_LoginWelcome")
            static var login_regulations = Localized("KN_LoginRegulations")
            static var login_gameRegulations = Localized("KN_LoginGameRegulations")
            static var login_checkRegulations = Localized("KN_LoginCheckRegulations")
            /*****************绑定邮箱***************/
            static var bindingEmail_remind = Localized("KN_UserBindRemind")
            static var bindingEmail_InputEmail = Localized("KN_LoginJustEmail")
            static var bindingEmail_emailAccount = Localized("KN_LoginEmailAccount")
            static var bindingEmail_success = Localized("KN_UserBindingSuccess")
            /*****************账户升级***************/
            static var accountUpgrade_a = Localized("KN_UserAccountUpgrade")
            static var accountUpgrade_binding = Localized("KN_UserBindingAccountUpgrade")
            static var accountUpgrade_remind = Localized("KN_UserAccountRemind")
            static var accountUpgrade_bindingSuccess = Localized("KN_UserAccountBindingSuccess")
            /*****************个人中心***************/
            static var usercenter_title = Localized("KN_User")
            static var usercenter_noBinding = Localized("KN_UserNoBinding")
            static var usercenter_hasBinding = Localized("KN_UserHasBinding")
            static var usercenter_bindingPhone = Localized("KN_UserBindingPhone")
            static var usercenter_bindingThird = Localized("KN_UserBindingThird")
            static var usercenter_exit = Localized("KN_UserExit")
            static var usercenter_modifyPass = Localized("KN_LoginModifyPass")
            static var usercenter_modifyPassByPass = Localized("KN_LoginByOriginPass")
            static var usercenter_sendCode = Localized("KN_LoginSendCode")
            static var usercenter_sendCodeAgain = Localized("KN_LoginPassAgain")
            static var usercenter_certificationSuccess = Localized("KN_LoginCertificationSuccess")
            static var usercenter_newPass = Localized("KN_LoginNewPass")
            static var usercenter_passInconsistent = Localized("KN_LoginPasswordInconsistent")
            static var usercenter_toGame = Localized("KN_ContinueGame")
            static var usercenter_updatePassSuccess = Localized("KN_LoginPassResetSuccess")
            static var usercenter_phoneBinding = Localized("KN_UserBindingPhone")
            static var usercenter_phoneBindingDes = Localized("KN_UserBindingPhoneDes")
            static var usercenter_InputPhoneN = Localized("KN_UserBindingInputPhoneN")
            static var usercenter_phoneBindingSuccess = Localized("KN_UserBindingPhoneSuccess")
            /*****************客服***************/
            static var service_title = Localized("KN_Service")
            static var service_sumit = Localized("KN_ServiceSumitFeed")
            static var service_checkMyFeed = Localized("KN_ServiceCheckMyFeedback")
            static var service_type = Localized("KN_ServiceType")
            static var service_aboutAccount = Localized("KN_ServiceAboutAccount")
            static var service_qTitle = Localized("KN_ServiceTitle")
            static var service_qTitleDes = Localized("KN_ServiceTitleDes")
            static var service_qContent = Localized("KN_ServiceCotent")
            static var service_accountInfo = Localized("KN_ServiceAccountInfo")
            static var service_contact = Localized("KN_ServiceContact")
            static var service_contactType = Localized("KN_ServiceContactType")
            static var service_inputTitle = Localized("KN_ServiceFeedbackTitle")
            static var service_inputContent = Localized("KN_ServiceFeedbackContent")
            static var service_submitSuccess = Localized("KN_ServiceSumitSuccess")
            static var service_myFeedTitle = Localized("KN_ServiceTitle")
            static var service_myFeedStatus = Localized("KN_ServiceStatus")
            static var service_myFeedProcessed = Localized("KN_ServiceProcessed")
            static var service_myFeedProcessedSuccess = Localized("KN_ServiceProcessedSuccess")
            static var service_myFeedProcessing = Localized("KN_ServiceProcessing")
            static var service_myFeedReplied = Localized("KN_ServiceReplied")
            static var service_feedBackDetail = Localized("KN_ServiceFeedBackDetail")
            static var service_replyQ = Localized("KN_ServiceReplyContent")
            static var service_reply = Localized("KN_ServiceReplyQues")
            static var service_playerReply = Localized("KN_ServicePlayerReply")
            static var service_replyContent = Localized("KN_ServiceReplyContent")
            static var service_additionalContent = Localized("KN_ServiceSumitContent")
            static var service_replyContentDetail = Localized("KN_ServiceReplyContentDetail")
            /*****************内购***************/
            static var iap_getProductInfo = Localized("KN_IAPGetIAPinfo")
            static var iap_success = Localized("KN_IAPSuccess")
            static var iap_fail = Localized("KN_IAPFail")
            static var iap_verOrder = Localized("KN_IAPCheck")
            static var iap_purchasing = Localized("KN_IAP")
            static var iap_creatOrder = Localized("KN_IAPGetOrder")
            static var iap_NoProduct = Localized("KN_IAPNoProduct")
        }
    }
    
    static var IBundle = {
        return "SDKImageResource.bundle/" + ($0 ?? "")
    }
    
    static func Localized(_ key: String) -> String {
        let language: String = UserDefaults.standard.value(forKey: "appLanguage") as! String
        let bundlePath: String? = Bundle.main.path(forResource:"internationalization", ofType:"bundle")
        if let path = bundlePath {
            let LocalizedBundle = Bundle.init(path: path)
            let lprojPath :String? = LocalizedBundle?.path(forResource: language, ofType: "lproj")
            if let lprojPath = lprojPath {
                let lprojBundle = Bundle.init(path: lprojPath)
                return lprojBundle?.localizedString(forKey: key, value: nil, table: "InfoPlist") ?? ""
            }
        }
        return ""
    }
}

