//
//  MyFeedListModel.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/4.
//  Copyright © 2020 niujf. All rights reserved.
//

import KakaJSON

struct MyFeedListModel: Convertible {
    var created_at: String = ""
    var feedId: Int = 0
    var title: String = ""
    var status: Int = 0
    var content: String = ""
    var reply: String = ""
    var can_reply: Int = 0
    
    func kj_modelKey(from property: Property) -> ModelPropertyKey {
        switch property.name {
        case "feedId": return "id"
        case "content": return "description"
        // 模型剩下的其他属性，直接用属性名作为JSON的key（属性名和key保持一致）
        default: return property.name
        }
    }
}

