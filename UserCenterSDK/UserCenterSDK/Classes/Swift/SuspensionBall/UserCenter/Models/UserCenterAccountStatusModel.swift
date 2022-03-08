//
//  UserCenterAccountStatusModel.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/8.
//  Copyright © 2020 niujf. All rights reserved.
//

import KakaJSON

struct UserCenterStatusModel<Element>: Convertible {
    let auth_token: String = ""
    let fb_user_modules: Element? = nil
}

struct UserCenterAccountStatusModel: Convertible {
    let type: String = ""
    let caption: String = ""
    let is_set: Int = 0
    let is_bind: Bool = false
    let email: String = ""
    let mobile: String = ""
    let zone: String = ""
}
