//
//  AppIterationRemind.swift
//  KingNetSDK
//
//  Created by admin on 2021/2/2.
//  Copyright © 2021 niujf. All rights reserved.
//

import UIKit

class AppIterationRemind: UIView {
    var cancelCallback: (() -> ())?
    var confirmCallback: (() -> ())?
    
    var remindModel: AppIterationRemindModel? {
        didSet {
            newLable.text = remindModel?.title
            contentLable.text = remindModel?.content
            if remindModel?.is_force == 1 {
                cancelBtn.isHidden = true
            }
        }
    }
    
    private lazy var iconImageView: UIImageView = {
        let i = UIImageView()
        i.image = SDK.R.image.appIteration_remind
        return i
    }()
    
    private lazy var newLable: UILabel = {
        let l = UILabel()
        l.font = SDK.Font.arial(14)
        return l
    }()
    
    private lazy var scrollview: UIScrollView = {
        let s = UIScrollView()
        s.showsHorizontalScrollIndicator = false
        return s
    }()
    
    private lazy var contentLable: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.font = SDK.Font.arial(13)
        l.textColor = SDK.Color.theme
        l.textAlignment = .left
        return l
    }()
    
    private lazy var confirmBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle(SDK.R.string.u_confirm, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = SDK.Color.themeRemindColor
        btn.titleLabel?.font = SDK.Font.arial(14)
        btn.layer.cornerRadius = 2
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(confirmBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    private lazy var cancelBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle(SDK.R.string.u_cancel, for: .normal)
        btn.setTitleColor(SDK.Color.themePlaceHolder, for: .normal)
        btn.titleLabel?.font = SDK.Font.arial(14)
        btn.addTarget(self, action: #selector(cancelBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = SDK.Color.themeRemindBGColor
        addChildView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutChildView()
    }
    
    deinit {
         print("\(self) 释放了")
    }
}

extension AppIterationRemind {
    @objc private func confirmBtnClicked() {
        removeFromSuperview()
        if confirmCallback != nil {
            confirmCallback!()
        }
    }
    
    @objc private func cancelBtnClicked() {
        removeFromSuperview()
        if cancelCallback != nil {
            cancelCallback! ()
        }
    }
}

extension AppIterationRemind {
    private func addChildView() {
        addSubview(iconImageView)
        addSubview(newLable)
        addSubview(scrollview)
        scrollview.addSubview(contentLable)
        addSubview(confirmBtn)
        addSubview(cancelBtn)
    }
}

extension AppIterationRemind {
    private func layoutChildView() {
        iconImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20 * K_Ratio)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 80 * K_Ratio, height: 80 * K_Ratio))
        }
        newLable.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconImageView.snp.bottom).offset(10 * K_Ratio)
        }
        scrollview.snp.makeConstraints { (make) in
            make.top.equalTo(newLable.snp.bottom).offset(10 * K_Ratio)
            make.left.equalToSuperview().offset(44 * K_Ratio)
            make.right.equalToSuperview().offset(-44 * K_Ratio)
            make.height.equalTo(80 * K_Ratio)
        }
        contentLable.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(44 * K_Ratio)
            make.right.equalToSuperview().offset(-44 * K_Ratio)
            make.top.bottom.equalToSuperview()
        }
        confirmBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(scrollview.snp.bottom).offset(10 * K_Ratio)
            make.left.right.equalTo(contentLable)
        }
        cancelBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(confirmBtn.snp.bottom).offset(10 * K_Ratio)
        }
    }
}
 
