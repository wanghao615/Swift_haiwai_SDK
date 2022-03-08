//
//  UserCenterModifyPassByView.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/21.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class UserCenterModifyPassByPassView: UIView {
    
    var nextBtnCallback: ((String) -> ())?
    
    private lazy var textField: N_TextField = {
        let t = N_TextField(.zero, SDK.R.image.u_pass, SDK.R.image.usercenter_passEye, SDK.R.image.usercenter_passEye_high)
        t.placeHolderText = SDK.R.string.usercenter_modifyPassByPass
        t.textColor = SDK.Color.theme
        t.limitLength = 20
        t.isSecureTextEntry = true;
        return t
    }()
    
    private lazy var nextBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle(SDK.R.string.u_next, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = SDK.Font.arial(13)
        btn.setBackgroundImage(SDK.R.image.u_btnBack, for: .normal)
        btn.setBackgroundImage(SDK.R.image.u_btnBack_high, for: .highlighted)
        btn.addTarget(self, action: #selector(nextBtnClicked), for: .touchUpInside)
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

extension UserCenterModifyPassByPassView {
    @objc private func nextBtnClicked() {
        if nextBtnCallback != nil { nextBtnCallback! (textField.text ?? "") }
    }
}

extension UserCenterModifyPassByPassView {
    private func addChildView() {
        addSubview(textField)
        addSubview(nextBtn)
    }
}

extension UserCenterModifyPassByPassView {
    private func layoutChildView() {
        textField.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(44 * K_Ratio)
            make.right.equalToSuperview().offset(-44 * K_Ratio)
            make.height.equalTo(40 * K_Ratio)
        }
        nextBtn.snp.makeConstraints { (make) in
            make.left.right.equalTo(textField)
            make.top.equalTo(textField.snp.bottom).offset(10 * K_Ratio)
            make.height.equalTo(34 * K_Ratio)
        }
    }
}

// MARK: - UserCenterModifyPassByEmailView

class UserCenterModifyPassByEmailView: UIView {
    
    var nextBtnCallback: ((String) -> ())?
     
    var email: String? {
        didSet {
            guard let email = email else { return }
            let attS: NSMutableAttributedString = attributeS(SDK.R.string.u_account, email)
            emailLable.attributedText = attS
        }
    }
    
    private lazy var emailLable: UILabel = {
        let l = UILabel()
        l.font = SDK.Font.arial(12)
        return l
    }()
    
    lazy var textField: N_TextField = {
        let t = N_TextField(.zero, SDK.R.image.usercenter_passNum, SDK.R.string.usercenter_sendCode)
        t.placeHolderText = SDK.R.string.u_smsCode
        t.textColor = SDK.Color.theme
        t.limitLength = 6
        t.rightTitle = SDK.R.string.usercenter_sendCode
        return t
    }()
    
    private lazy var nextBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle(SDK.R.string.u_next, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = SDK.Font.arial(13)
        btn.setBackgroundImage(SDK.R.image.u_btnBack, for: .normal)
        btn.setBackgroundImage(SDK.R.image.u_btnBack_high, for: .highlighted)
        btn.addTarget(self, action: #selector(nextBtnClicked), for: .touchUpInside)
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

extension UserCenterModifyPassByEmailView {
    @objc private func nextBtnClicked() {
        if nextBtnCallback != nil { nextBtnCallback! (textField.text ?? "") }
    }
}

extension UserCenterModifyPassByEmailView {
    private func addChildView() {
        addSubview(emailLable)
        addSubview(textField)
        addSubview(nextBtn)
    }
}

extension UserCenterModifyPassByEmailView {
    private func layoutChildView() {
        emailLable.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(44 * K_Ratio)
        }
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(emailLable)
            make.right.equalToSuperview().offset(-44 * K_Ratio)
            make.top.equalTo(emailLable.snp.bottom).offset(8 * K_Ratio)
            make.height.equalTo(40 * K_Ratio)
        }
        nextBtn.snp.makeConstraints { (make) in
            make.left.right.equalTo(textField)
            make.top.equalTo(textField.snp.bottom).offset(10 * K_Ratio)
            make.height.equalTo(34 * K_Ratio)
        }
    }
}

fileprivate func attributeS(_ local: String, _ s: String) ->NSMutableAttributedString {
    let str: String = local + ":  " + s
    let attS: NSMutableAttributedString = NSMutableAttributedString(string: str)
    let range = NSString(string: attS.string).range(of: local + ":")
    attS.addAttributes([.foregroundColor:SDK.Color.themePlaceHolder],range: range)
    let c = NSString(string: attS.string).range(of: "s")
    attS.addAttributes([.foregroundColor: SDK.Color.theme],range: c)
    return attS
}

// MARK: - UserCenterModifyPassByPhoneView

class UserCenterModifyPassByPhoneView: UIView {
    
    var phone: String? {
        didSet {
            guard let phone = phone else { return }
            let attS: NSMutableAttributedString = attributeS(SDK.R.string.u_phone, phone)
            phoneLable.attributedText = attS
        }
    }
    
    var email: String? {
        didSet {
            byEmailView.email = email
        }
    }
   
    private lazy var phoneLable: UILabel = {
        let l = UILabel()
        l.font = SDK.Font.arial(12)
        return l
    }()
    
    lazy var byEmailView: UserCenterModifyPassByEmailView = {
        let byEmailView = UserCenterModifyPassByEmailView()
        return byEmailView
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

extension UserCenterModifyPassByPhoneView {
    private func addChildView() {
        addSubview(phoneLable)
        addSubview(byEmailView)
    }
}

extension UserCenterModifyPassByPhoneView {
    private func layoutChildView() {
        phoneLable.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(44 * K_Ratio)
        }
        byEmailView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(phoneLable.snp.bottom).offset(8 * K_Ratio)
        }
    }
}
