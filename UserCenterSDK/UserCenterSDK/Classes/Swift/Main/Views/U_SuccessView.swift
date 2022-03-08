//
//  UserCenterSuccessView.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/23.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class U_SuccessView: UIView {
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
    
    var successBtnCallback: (() -> ())?
    
    private lazy var backImageView: UIImageView = {
        let backImageView = UIImageView()
        backImageView.isUserInteractionEnabled = true
        backImageView.image = SDK.R.image.usercenter_AlertUback
        return backImageView
    }()
    
    private lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = SDK.Color.theme
        lineView.alpha = 0.2
        return lineView
    }()
    
    private lazy var topTitleLable: UILabel = {
        let titleLable = UILabel()
        titleLable.textColor = SDK.Color.theme
        titleLable.font = SDK.Font.arial(18)
        return titleLable
    }()
    
    private lazy var iconImageView: UIImageView = {
        let backImageView = UIImageView()
        backImageView.image = SDK.R.image.usercenter_success
        return backImageView
    }()
    
    private lazy var titleLable: UILabel = {
        let titleLable = UILabel()
        titleLable.textColor = SDK.Color.theme
        titleLable.font = SDK.Font.arial(14)
        titleLable.numberOfLines = 0
        titleLable.textAlignment = .center
        return titleLable
    }()
    
    private lazy var successBtn: UIButton = {
        let backBtn = UIButton.init(type: .custom)
        backBtn.setTitle(SDK.R.string.usercenter_toGame, for: .normal)
        backBtn.titleLabel?.font = SDK.Font.arial(13)
        backBtn.setTitleColor(.white, for: .normal)
        backBtn.setBackgroundImage(SDK.R.image.u_btnBack, for: .normal)
        backBtn.setBackgroundImage(SDK.R.image.u_btnBack_high, for: .highlighted)
        backBtn.addTarget(self, action: #selector(successBtnClicked), for: .touchUpInside)
        return backBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addChildView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutChildView()
    }
}

extension U_SuccessView {
    @objc private func successBtnClicked() {
        if successBtnCallback != nil {
            successBtnCallback! ()
        }
    }
}

extension U_SuccessView {
    private func addChildView() {
        addSubview(backImageView)
        backImageView.addSubview(lineView)
        backImageView.addSubview(topTitleLable)
        backImageView.addSubview(iconImageView)
        backImageView.addSubview(titleLable)
        backImageView.addSubview(successBtn)
    }
}

extension U_SuccessView {
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
        iconImageView.snp.makeConstraints { (make) in
            make.top.equalTo(lineView.snp.bottom).offset(20 * K_Ratio)
            make.centerX.equalToSuperview()
        }
        titleLable.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView.snp.bottom).offset(4 * K_Ratio)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(44 * K_Ratio)
            make.right.equalToSuperview().offset(-44 * K_Ratio)
        }
        successBtn.snp.makeConstraints { (make) in
            make.top.equalTo(titleLable.snp.bottom).offset(12 * K_Ratio)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 100 * K_Ratio, height: 34 * K_Ratio))
        }
    }
}
