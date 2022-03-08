//
//  ServiceModel.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/2.
//  Copyright © 2020 niujf. All rights reserved.
//

import KakaJSON

struct ServiceTypeModel: Convertible {
    var name: String = ""
    var type: Int = 0
    
    func kj_modelKey(from property: Property) -> ModelPropertyKey {
        switch property.name {
        case "type": return "id"
        // 模型剩下的其他属性，直接用属性名作为JSON的key（属性名和key保持一致）
        default: return property.name
        }
    }
}
