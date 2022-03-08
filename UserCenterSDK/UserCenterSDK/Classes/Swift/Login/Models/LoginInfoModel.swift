//
//  RegisterModel.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/28.
//  Copyright © 2020 niujf. All rights reserved.
//
import KakaJSON

struct LoginInfoModel: Convertible {
    let user_id: String = ""
    let username: String = ""
    let access_token: String = ""
    let upgraded: String = ""
    let token: String = ""
    let login_code: String = ""
    let game_url: String = ""
    var login_type: String = ""
    let is_register: Bool = false
}
