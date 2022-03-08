//
//  GCDTool.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/7.
//  Copyright © 2020 niujf. All rights reserved.
//
import UIKit

struct GCDTool {
    typealias Task = () -> Void

    static func async(_ task: @escaping Task) {
        _async(task)
    }

    static func async(_ task: @escaping Task,
                             _ mainTask: @escaping Task) {
        _async(task, mainTask)
    }
    
    static func async_main(mainTask: @escaping Task) {
        let item = DispatchWorkItem(block: mainTask)
        DispatchQueue.main.async(execute: item)
    }

    private static func _async(_ task: @escaping Task,
                               _ mainTask: Task? = nil) {
        let item = DispatchWorkItem(block: task)
        DispatchQueue.global().async(execute: item)
        if let main = mainTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
    }
    
    @discardableResult
    static func delay(_ seconds: Double,
                             _ block: @escaping Task) -> DispatchWorkItem {
        let item = DispatchWorkItem(block: block)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds,
                                      execute: item)
        return item
    }
}


