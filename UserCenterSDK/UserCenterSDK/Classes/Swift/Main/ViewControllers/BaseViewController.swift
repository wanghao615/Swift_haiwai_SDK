//
//  BaseViewController.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/1.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var offsetMargin: Int?

    override public func viewDidLoad() {
        super.viewDidLoad()
        ///监听键盘
        NotificationCenter.default.addObserver(self, selector: #selector(moveKeyboard(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension BaseViewController {
    @objc private func moveKeyboard(notification: NSNotification) {
        guard let offsetMargin = offsetMargin else { return }
        /** 键盘完全弹出时间 */
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        /** 动画趋势 */
        let rawAnimationCurveValue = (notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber).intValue
        guard let animationCurve = UIView.AnimationCurve(rawValue: rawAnimationCurveValue) else { return }
        /** 动画执行完毕frame */
        let keyboard_frame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        /** 获取键盘y值 */
        let keyboard_y: CGFloat = keyboard_frame.origin.y
        /** view上平移的值 */
        var offset = kScreenHeight - keyboard_y
        if keyboard_y != kScreenHeight {
            offset = CGFloat(offsetMargin)
        }else {
            offset = 0
        }
        /** 执行动画  */
        UIView.animate(withDuration: duration) {
            UIView.setAnimationCurve(animationCurve)
            self.view.frame = CGRect(x: 0, y: -offset, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }
    }
}
