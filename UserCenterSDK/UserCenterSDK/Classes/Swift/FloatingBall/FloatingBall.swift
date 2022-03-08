//
//  FloatingBall.swift
//  KingNetSDK
//
//  Created by admin on 2021/1/6.
//  Copyright © 2021 niujf. All rights reserved.
//

import UIKit

fileprivate let KBtnWidth: CGFloat = 44.0
fileprivate let KBtnMargin: CGFloat = 20.0
fileprivate let KMenuWidth: CGFloat = 200.0
//content
fileprivate let centerWidth: CGFloat = 20.0
fileprivate let upgradeWidth: CGFloat = 27.0
fileprivate let upgradeHeight: CGFloat = 22.0
fileprivate let serverWidth: CGFloat = 18.0
fileprivate let serverHeight: CGFloat = 22.0

class FloatingBall: UIView {
    var callback: ((Int) -> ())?
    
    var isUpgrade: Bool = false {
        didSet {
            if isUpgrade {//账号升级
                leftBtn.setBackgroundImage(SDK.R.image.floatingBall_upgrade, for: .normal)
                leftLable.text = SDK.R.string.accountUpgrade_a
                baseBtn.setBackgroundImage(SDK.R.image.floatingBall_dot, for: .normal)
            }else {//个人中心
                leftBtn.setBackgroundImage(SDK.R.image.floatingBall_center, for: .normal)
                leftLable.text = SDK.R.string.usercenter_title
                baseBtn.setBackgroundImage(SDK.R.image.floatingBall_high, for: .normal)
            }
            rightBtn.setBackgroundImage(SDK.R.image.floatingBall_service, for: .normal)
            rightLable.text = SDK.R.string.service_title
        }
    }
    
    var isBallHidden: Bool = false {
        didSet {
            if isBallHidden {
                if baseBtn.isSelected {//展开状态
                    showMenu(btn: baseBtn)
                }
                isHidden = true
            }else {
                isHidden = false
            }
        }
    }
    
    private var isExpansion: Bool = false
    private var isPan: Bool = false
    
    private lazy var baseBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.addTarget(self, action: #selector(showMenu(btn:)), for: .touchUpInside)
        return btn
    }()
    
    private var expansionBgImageView: UIImageView = {
        let im = UIImageView()
        im.isUserInteractionEnabled = true
        im.isHidden = true
        return im
    }()
    
    private var leftBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.addTarget(self, action: #selector(leftBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    private var rightBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.addTarget(self, action: #selector(rightBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    private var leftLable: UILabel = {
        let l = UILabel()
        l.textColor = SDK.Color.theme
        l.numberOfLines = 0
        l.font = SDK.Font.arial(10)
        return l
    }()
    
    private var rightLable: UILabel = {
        let l = UILabel()
        l.textColor = SDK.Color.theme
        l.numberOfLines = 0
        l.font = SDK.Font.arial(10)
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addChildView()
        //添加拖拽手势
        let panGes: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(moveBall(gesture:)))
        self.addGestureRecognizer(panGes)
        stickyEdge()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FloatingBall {
    private func addChildView() {
        baseBtn.frame = CGRect(x: 0, y: 0, width: KBtnWidth, height: KBtnWidth)
        expansionBgImageView.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height)
        addSubview(expansionBgImageView)
        addSubview(baseBtn)
        expansionBgImageView.addSubview(leftBtn)
        expansionBgImageView.addSubview(leftLable)
        expansionBgImageView.addSubview(rightBtn)
        expansionBgImageView.addSubview(rightLable)
        if isUpgrade {//账户升级
            leftBtn.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(80)
                make.top.equalToSuperview().offset(4)
                make.size.equalTo(CGSize(width: upgradeWidth, height: upgradeHeight))
            }
            rightBtn.snp.makeConstraints { (make) in
                make.left.equalTo(leftBtn.snp.right).offset(37)
                make.top.equalToSuperview().offset(5)
                make.size.equalTo(CGSize(width: serverWidth, height: serverHeight))
            }
        }else {
            leftBtn.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(69)
                make.top.equalToSuperview().offset(6)
                make.size.equalTo(CGSize(width: centerWidth, height: centerWidth))
            }
            rightBtn.snp.makeConstraints { (make) in
                make.left.equalTo(leftBtn.snp.right).offset(42)
                make.top.equalToSuperview().offset(5)
                make.size.equalTo(CGSize(width: serverWidth, height: serverHeight))
            }
        }
        leftLable.snp.makeConstraints { (make) in
            make.centerX.equalTo(leftBtn)
            make.top.equalTo(leftBtn.snp.bottom).offset(3)
        }
        rightLable.snp.makeConstraints { (make) in
            make.centerX.equalTo(rightBtn)
            make.top.equalTo(leftLable)
        }
    }
}

extension FloatingBall {
    private func stickyEdge() {
        GCDTool.delay(3) {//粘边
            //判断是屏幕的左边还是右边
            if self.isExpansion || self.isPan { return }
            self.baseBtn.setBackgroundImage(SDK.R.image.floatingBall, for: .normal)
            if self.center.x < kScreenWidth / 2 {
                self.x = -KBtnWidth/2
            } else {
                self.x = kScreenWidth - KBtnWidth/2
            }
        }
    }
}

extension FloatingBall {
    @objc private func leftBtnClicked() {
        if isUpgrade {
            if callback != nil { callback! (0) }
        }else {
            if callback != nil { callback! (1) }
        }
    }
    
    @objc private func rightBtnClicked() {
        if callback != nil { callback! (2) }
    }
}

extension FloatingBall {
    @objc private func showMenu(btn: UIButton) {
        btn.isSelected = !btn.isSelected
        if btn.isSelected {//展开content
            isExpansion = true
            baseBtn.setBackgroundImage(nil, for: .normal)
            expansionBgImageView.isHidden = false
            let leftBtnMargin: CGFloat
            //判断是屏幕的左边还是右边
            if self.center.x < kScreenWidth / 2 {
                self.x = KBtnMargin
                expansionBgImageView.image = SDK.R.image.floatingBall_menu_left
                baseBtn.frame = CGRect(x: 0, y: 0, width: KBtnWidth, height: KBtnWidth)
                //更新x
                if isUpgrade {//账户升级
                    leftBtnMargin = 80
                }else {
                    leftBtnMargin = 69
                }
            } else {
                self.x = kScreenWidth - KMenuWidth - KBtnMargin
                expansionBgImageView.image = SDK.R.image.floatingBall_menu_right
                baseBtn.frame = CGRect(x: KMenuWidth - KBtnWidth, y: 0, width: KBtnWidth, height: KBtnWidth)
                //更新x
                if isUpgrade {//账户升级
                    leftBtnMargin = 50
                }else {
                    leftBtnMargin = 47
                }
            }
            self.width = KMenuWidth
            leftBtn.snp.updateConstraints { (make) in
                make.left.equalToSuperview().offset(leftBtnMargin)
            }
        }else {//收回
            isExpansion = false
            if isUpgrade {
                baseBtn.setBackgroundImage(SDK.R.image.floatingBall_dot, for: .normal)
            }else {
                baseBtn.setBackgroundImage(SDK.R.image.floatingBall_high, for: .normal)
            }
            baseBtn.frame = CGRect(x: 0, y: 0, width: KBtnWidth, height: KBtnWidth)
            expansionBgImageView.isHidden = true
            //判断是屏幕的左边还是右边
            if self.center.x < kScreenWidth / 2 {
                self.x = KBtnMargin
            } else {
                self.x = kScreenWidth - KBtnWidth - KBtnMargin
            }
            self.width = KBtnWidth
            stickyEdge()
        }
        //更新content的frame
        expansionBgImageView.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height)
    }
    
    @objc private func moveBall(gesture: UIPanGestureRecognizer) {
        //如果已经showMenu就不再拖动
        if isExpansion { return }
        let point: CGPoint = gesture.location(in: self.superview)
        switch gesture.state {
        case .began:
            isPan = true
        case .changed:
            self.center = point
        case .ended:
            if point.x < kScreenWidth / 2 {//屏幕左边
                UIView.animate(withDuration: 0.5) {
                    self.x = KBtnMargin
                }
            }else {//右边
                UIView.animate(withDuration: 0.5) {
                    self.x = kScreenWidth - KBtnWidth - KBtnMargin
                }
            }
            if point.y < KBtnWidth / 2 {
                UIView.animate(withDuration: 0.5) {//屏幕顶部
                    self.y = 0
                }
            }
            if point.y > kScreenHeight - KBtnWidth / 2 {
                UIView.animate(withDuration: 0.5) {//屏幕底部
                    self.y = kScreenHeight - KBtnWidth
                }
            }
            //更新悬浮球图片
            if isUpgrade {
                baseBtn.setBackgroundImage(SDK.R.image.floatingBall_dot, for: .normal)
            }else {
                baseBtn.setBackgroundImage(SDK.R.image.floatingBall_high, for: .normal)
            }
            isPan = false
            stickyEdge()
        default:
            break
        }
    }
}

