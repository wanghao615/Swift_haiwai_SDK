//
//  BindingEmailProtocol.swift
//  KingNetSDK
//
//  Created by admin on 2021/2/4.
//  Copyright © 2021 niujf. All rights reserved.
//

import UIKit

@objc enum AccountType: Int {
    case bind
    case upgrade
}

@objc protocol BindingEmailProtocol {
    func type(_ type: AccountType)
}
