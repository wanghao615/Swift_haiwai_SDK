//
//  FeedReplyListModel.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/7.
//  Copyright © 2020 niujf. All rights reserved.
//
import KakaJSON

struct FeedReplyListModel: Convertible {
    var created_at: String = ""
    var type: Int = 0
    var content: String = ""
}
