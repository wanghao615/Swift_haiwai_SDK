//
//  SWSDKInitModel.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/31.
//  Copyright © 2020 niujf. All rights reserved.
//


import KakaJSON

struct SWSDKInitModel<Element>: Convertible {
    var user_protocol: String = ""
    var user_privacy_protocol: String = ""
    var game_id: String = ""
    var py_currency: String = ""
    var py_url: String = ""
    var app_name: String = ""
    var py_resource_id: String = ""
    var py_server_callback: String = ""
    var client_id: String = ""
    var sw_protocol: Bool = false
    var support_login_type: Element? = nil
    var switch_upgrade_account: Int = 0
}

struct Login_Type: Convertible {
    var caption: String = ""
    var type: String = ""
    var order_id: Int = 0
}

struct AppIterationRemindModel: Convertible {
    var created_at: String = ""
    var type: Int = 0
    var title: String = ""
    var content: String = ""
    var is_force: Int = 0
    var url: String = ""
}
