//
//  AlertSelView.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/9.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class AlertSelView: UIView {
    var confirmCallback: (() -> ())?
    var cancelCallback: (() -> ())?
    
    var topTitle: String? {
        didSet {
            topTitleLable.text = topTitle
        }
    }
    
    var title: String? {
        didSet {
            titleLable.text = title
        }
    }
    
    private lazy var backImageView: UIImageView = {
        let backImageView = UIImageView()
        backImageView.image = SDK.R.image.usercenter_AlertUback
        backImageView.isUserInteractionEnabled = true
        return backImageView
    }()
    
    private lazy var topTitleLable: UILabel = {
        let titleLable = UILabel()
        titleLable.textColor = SDK.Color.theme
        titleLable.font = SDK.Font.arial(16)
        return titleLable
    }()
    
    private lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = SDK.Color.theme
        lineView.alpha = 0.2
        return lineView
    }()
    
    private lazy var titleLable: UILabel = {
        let titleLable = UILabel()
        titleLable.textColor = SDK.Color.theme
        titleLable.font = SDK.Font.arial(14)
        return titleLable
    }()
    
    private lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton.init(type: .custom)
        cancelBtn.setBackgroundImage(SDK.R.image.usercenter_cancel, for: .normal)
        cancelBtn.setBackgroundImage(SDK.R.image.usercenter_cancel_high, for: .highlighted)
        cancelBtn.setTitle(SDK.R.string.u_cancel, for: .normal)
        cancelBtn.titleLabel?.font = SDK.Font.arial(13)
        cancelBtn.setTitleColor(SDK.Color.themeBlue, for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelBtnClicked), for: .touchUpInside)
        return cancelBtn
    }()
    
    private lazy var confirmBtn: UIButton = {
        let confirmBtn = UIButton.init(type: .custom)
        confirmBtn.setTitle(SDK.R.string.u_confirm, for: .normal)
        confirmBtn.setBackgroundImage(SDK.R.image.usercenter_btnBack, for: .normal)
        confirmBtn.setBackgroundImage(SDK.R.image.usercenter_btnBack_high, for: .highlighted)
        confirmBtn.titleLabel?.font = SDK.Font.arial(13)
        confirmBtn.setTitleColor(UIColor.white, for: .normal)
        confirmBtn.addTarget(self, action: #selector(confirmBtnClicked), for: .touchUpInside)
        return confirmBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addChildView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layoutChildView()
    }
    
}

extension AlertSelView {
    @objc private func cancelBtnClicked() {
        removeFromSuperview()
        if cancelCallback != nil { cancelCallback! () }
    }
    
    @objc private func confirmBtnClicked() {
        removeFromSuperview()
        if confirmCallback != nil { confirmCallback! () }
    }
}

extension AlertSelView {
    private func addChildView() {
        addSubview(backImageView)
        backImageView.addSubview(topTitleLable)
        backImageView.addSubview(lineView)
        backImageView.addSubview(titleLable)
        backImageView.addSubview(cancelBtn)
        backImageView.addSubview(confirmBtn)
    }
}

extension AlertSelView {
    private func layoutChildView() {
        backImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        topTitleLable.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(3 * K_Ratio)
            make.height.equalTo(44 * K_Ratio)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(4 * K_Ratio)
            make.right.equalToSuperview().offset(-4 * K_Ratio)
            make.top.equalTo(topTitleLable.snp.bottom)
            make.height.equalTo(1)
        }
        titleLable.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(lineView.snp.bottom).offset(40 * K_Ratio)
        }
        let margin: CGFloat = (SDK.alertSelSize.width - 100 * K_Ratio * 2 - 20 * K_Ratio - 8 * K_Ratio) / 2
        cancelBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(margin)
            make.top.equalTo(titleLable.snp.bottom).offset(42 * K_Ratio)
            make.size.equalTo(CGSize(width: 100 * K_Ratio, height: 34 * K_Ratio))
        }
        confirmBtn.snp.makeConstraints { (make) in
            make.left.equalTo(cancelBtn.snp.right).offset(20 * K_Ratio)
            make.centerY.equalTo(cancelBtn)
            make.size.equalTo(CGSize(width: 100 * K_Ratio, height: 34 * K_Ratio))
        }
    }
}
