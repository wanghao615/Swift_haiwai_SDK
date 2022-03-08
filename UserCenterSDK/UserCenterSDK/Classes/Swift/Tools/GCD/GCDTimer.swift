//
//  GCDTimer.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/21.
//  Copyright © 2020 niujf. All rights reserved.
//
import UIKit

struct GCDTimer {
    private static var semaphore_ = DispatchSemaphore(value: 1)
    private static var timers_: [String: Any]?
    
    @discardableResult
    static func execTask(_ task: @escaping (Int) -> (), _ finish: @escaping () -> ()) -> String? {
        //倒计时时间
        var timeout: Int = 60
        //队列
        let queue: DispatchQueue = DispatchQueue.global()
        //创建定时器
        let timer: DispatchSource = DispatchSource.makeTimerSource(flags: [], queue: queue) as! DispatchSource
        //设置时间
        timer.schedule(deadline: .now(), repeating: .seconds(1), leeway: DispatchTimeInterval.milliseconds(100))
        semaphore_.wait()
        defer { semaphore_.signal() }
        //定时器的唯一标识
        let name = String(format: "%d", timers_?.count ?? 0)
        timers_?[name] = timer
        timer.setEventHandler(handler: {
            if timeout <= 0 {
                timer.cancel()
                DispatchQueue.main.async {
                    finish()
                }
            }else {
                timeout -= 1
                DispatchQueue.main.async {
                    task(timeout)
                }
            }
        })
        timer.resume()
        return name
    }
    
    static func cancelTask(_ name: String?) {
        if name?.count == 0 || timers_ == nil { return }
        semaphore_.wait()
        defer { semaphore_.signal() }
        let timer: DispatchSource = timers_?[name!] as! DispatchSource
        timer.cancel()
        timers_?.removeValue(forKey: name!)
    }
}

