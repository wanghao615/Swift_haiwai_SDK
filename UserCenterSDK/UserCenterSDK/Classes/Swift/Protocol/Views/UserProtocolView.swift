//
//  UserProtocolView.swift
//  KingNetSDK
//
//  Created by admin on 2021/1/6.
//  Copyright © 2021 niujf. All rights reserved.
//

import UIKit

class UserProtocolView: UIView {
    var callback: ((Int) -> ())?
    
    private lazy var bgImageView: UIImageView = {
        let im = UIImageView()
        im.image = SDK.R.image.main_back
        return im
    }()
    
    private lazy var logoImageView: UIImageView = {
        let im = UIImageView()
        im.image = SDK.R.image.u_logo
        return im
    }()
    
    private lazy var gameProtocolView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 2
        v.layer.masksToBounds = true
        v.backgroundColor = .white
        return v
    }()
    
    private lazy var userProtocolView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 2
        v.layer.masksToBounds = true
        v.backgroundColor = .white
        return v
    }()
    
    private lazy var gameProtocolLable: UILabel = {
        let l = UILabel()
        l.textAlignment = .left
        l.font = SDK.Font.arial(12)
        l.textColor = SDK.Color.theme
        l.text = SDK.R.string.userProtocol_agree
        return l
    }()
    
    private lazy var userProtocolLable: UILabel = {
        let l = UILabel()
        l.textAlignment = .left
        l.font = SDK.Font.arial(12)
        l.textColor = SDK.Color.theme
        l.text = SDK.R.string.userProtocol_agree
        return l
    }()
    
    private lazy var gameProtocolBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(SDK.Color.themeBlue, for: .normal)
        btn.setTitle(SDK.R.string.userProtocol_game, for: .normal)
        btn.addTarget(self, action: #selector(gameProtocolBtnClicked), for: .touchUpInside)
        btn.titleLabel?.font = SDK.Font.arial(12)
        return btn
    }()
    
    private lazy var userProtocolBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(SDK.Color.themeBlue, for: .normal)
        btn.setTitle(SDK.R.string.userProtocol_user, for: .normal)
        btn.addTarget(self, action: #selector(userProtocolBtnClicked), for: .touchUpInside)
        btn.titleLabel?.font = SDK.Font.arial(12)
        return btn
    }()
    
    private lazy var agreeBtnTop: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setBackgroundImage(SDK.R.image.userProtocol_agree, for: .normal)
        btn.setBackgroundImage(SDK.R.image.userProtocol_agree_high, for: .selected)
        btn.addTarget(self, action: #selector(agreeBtnClicked(btn:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var agreeBtnBottom: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setBackgroundImage(SDK.R.image.userProtocol_agree, for: .normal)
        btn.setBackgroundImage(SDK.R.image.userProtocol_agree_high, for: .selected)
        btn.addTarget(self, action: #selector(agreeBtnClicked(btn:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var cancelBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .white
        btn.layer.borderWidth = 1
        btn.layer.borderColor = SDK.Color.themeBlue.cgColor
        btn.titleLabel?.font = SDK.Font.arial(12)
        btn.setTitle(SDK.R.string.u_cancel, for: .normal)
        btn.setTitleColor(SDK.Color.themeBlue, for: .normal)
        btn.addTarget(self, action: #selector(cancelBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    private lazy var confirmlBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = SDK.Color.themeBlue
        btn.titleLabel?.font = SDK.Font.arial(12)
        btn.setTitle(SDK.R.string.u_confirm, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(confirmlBtnClicked), for: .touchUpInside)
        return btn
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

extension UserProtocolView {
    @objc private func gameProtocolBtnClicked() {
        if callback != nil { callback! (0) }
    }
    
    @objc private func userProtocolBtnClicked() {
        if callback != nil { callback! (1) }
    }
    
    @objc private func agreeBtnClicked(btn: UIButton) {
        btn.isSelected = !btn.isSelected
    }
    
    @objc private func cancelBtnClicked() {
        if callback != nil { callback! (2) }
    }
    
    @objc private func confirmlBtnClicked() {
        if agreeBtnTop.isSelected && agreeBtnBottom.isSelected {
            if callback != nil { callback! (4) }
        }else {
            if callback != nil { callback! (3) }
        }
    }
}

extension UserProtocolView {
    private func addChildView() {
        addSubview(bgImageView)
        addSubview(logoImageView)
        addSubview(gameProtocolView)
        addSubview(userProtocolView)
        gameProtocolView.addSubview(gameProtocolLable)
        userProtocolView.addSubview(userProtocolLable)
        gameProtocolView.addSubview(gameProtocolBtn)
        userProtocolView.addSubview(userProtocolBtn)
        gameProtocolView.addSubview(agreeBtnTop)
        userProtocolView.addSubview(agreeBtnBottom)
        addSubview(cancelBtn)
        addSubview(confirmlBtn)
    }
}

extension UserProtocolView {
    private func layoutChildView() {
        bgImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(25 * K_Ratio)
            make.size.equalTo(CGSize(width: 90 * K_Ratio, height: 36 * K_Ratio))
            make.centerX.equalToSuperview()
        }
        gameProtocolView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(44 * K_Ratio)
            make.right.equalToSuperview().offset(-44 * K_Ratio)
            make.top.equalTo(logoImageView.snp.bottom).offset(18 * K_Ratio)
            make.height.equalTo(40)
        }
        userProtocolView.snp.makeConstraints { (make) in
            make.left.right.equalTo(gameProtocolView)
            make.top.equalTo(gameProtocolView.snp.bottom).offset(7 * K_Ratio)
            make.height.equalTo(40)
        }
        gameProtocolLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(13 * K_Ratio)
            make.centerY.equalToSuperview()
        }
        gameProtocolBtn.snp.makeConstraints { (make) in
            make.left.equalTo(gameProtocolLable.snp.right)
            make.centerY.equalToSuperview()
        }
        agreeBtnTop.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-12 * K_Ratio)
            make.centerY.equalToSuperview()
        }
        userProtocolLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(13 * K_Ratio)
            make.centerY.equalToSuperview()
        }
        userProtocolBtn.snp.makeConstraints { (make) in
            make.left.equalTo(userProtocolLable.snp.right)
            make.centerY.equalToSuperview()
        }
        agreeBtnBottom.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-12 * K_Ratio)
            make.centerY.equalToSuperview()
        }
        cancelBtn.snp.makeConstraints { (make) in
            make.top.equalTo(userProtocolView.snp.bottom).offset(22 * K_Ratio)
            make.size.equalTo(CGSize(width: 100 * K_Ratio, height: 34 * K_Ratio))
            make.left.equalToSuperview().offset((self.width - 2 * 100 * K_Ratio - 20 * K_Ratio) / 2)
        }
        confirmlBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 100 * K_Ratio, height: 34 * K_Ratio))
            make.top.equalTo(cancelBtn)
            make.left.equalTo(cancelBtn.snp.right).offset(20 * K_Ratio)
        }
    }
}
