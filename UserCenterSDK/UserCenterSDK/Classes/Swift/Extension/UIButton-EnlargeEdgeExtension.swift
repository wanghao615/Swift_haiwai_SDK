//
//  UIButton-EnlargeEdgeExtension.swift
//  KingNetSDK
//
//  Created by admin on 2020/11/30.
//  Copyright © 2020 niujf. All rights reserved.
//
import UIKit

extension UIButton {
    private static var topKey: Void?
    private static var bottomKey: Void?
    private static var leftKey: Void?
    private static var rightKey: Void?

    var top: NSNumber {
        get {
            (objc_getAssociatedObject(self, &Self.topKey) as? NSNumber) ?? 0
        }
        set {
            objc_setAssociatedObject(self, &Self.topKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }

    var bottom: NSNumber {
        get {
            (objc_getAssociatedObject(self, &Self.bottomKey) as? NSNumber) ?? 0
        }
        set {
            objc_setAssociatedObject(self, &Self.bottomKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }

    var left: NSNumber {
        get {
            (objc_getAssociatedObject(self, &Self.leftKey) as? NSNumber) ?? 0
        }
        set {
            objc_setAssociatedObject(self, &Self.leftKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }

    var right: NSNumber {
        get {
            (objc_getAssociatedObject(self, &Self.rightKey) as? NSNumber) ?? 0
        }
        set {
            objc_setAssociatedObject(self, &Self.rightKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }

    func setEnlargeEdge(_ enlargedEdge: Float) {
        setEnlargeEdge(top: enlargedEdge, bottom: enlargedEdge, left: enlargedEdge, right: enlargedEdge)
    }

    func setEnlargeEdge(top: Float, bottom: Float, left: Float, right: Float) {
        self.top = NSNumber.init(value: top)
        self.bottom = NSNumber.init(value: bottom)
        self.left = NSNumber.init(value: left)
        self.right = NSNumber.init(value: right)
    }

    func enlargedRect() -> CGRect {
        let top = self.top
        let bottom = self.bottom
        let left = self.left
        let right = self.right
        if top.floatValue >= 0, bottom.floatValue >= 0, left.floatValue >= 0, right.floatValue >= 0 {
            return CGRect.init(x: self.bounds.origin.x - CGFloat(left.floatValue),
                               y: self.bounds.origin.y - CGFloat(top.floatValue),
                               width: self.bounds.size.width + CGFloat(left.floatValue) + CGFloat(right.floatValue),
                               height: self.bounds.size.height + CGFloat(top.floatValue) + CGFloat(bottom.floatValue))
        }else {
            return self.bounds
        }
    }

     override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let rect = self.enlargedRect()
        if rect.equalTo(self.bounds) {
            return super.point(inside: point, with: event)
        }
        return rect.contains(point) ? true : false
    }
}
