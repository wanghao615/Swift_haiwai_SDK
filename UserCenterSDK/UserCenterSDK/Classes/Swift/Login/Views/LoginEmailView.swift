//
//  LoginEmailView.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/28.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class LoginEmailView: BaseView {
    var registerBtnCallback: (() -> ())?
    var loginBtnCallback: ((String, String) -> ())?
    var forgetBtnCallback: (() -> ())?
    
    private lazy var emailTextField: N_TextField = {
        let t = N_TextField(.zero, SDK.R.image.bindingEmail_email, nil)
        t.placeHolderText = SDK.R.string.login_emailAccount
        t.textColor = SDK.Color.theme
        t.limitLength = 50
        t.autocorrectionType = .no
        t.spellCheckingType = .no
        return t
    }()
    
    private lazy var passTextField: N_TextField = {
        let t = N_TextField(.zero, SDK.R.image.u_pass, SDK.R.image.usercenter_passEye, SDK.R.image.usercenter_passEye_high)
        t.placeHolderText = SDK.R.string.u_pass
        t.isSecureTextEntry = true;
        t.textColor = SDK.Color.theme
        t.limitLength = 20
        return t
    }()
    
    private lazy var loginBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle(SDK.R.string.login_l, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = SDK.Font.arial(13)
        btn.setBackgroundImage(SDK.R.image.u_btnBack, for: .normal)
        btn.setBackgroundImage(SDK.R.image.u_btnBack_high, for: .highlighted)
        btn.addTarget(self, action: #selector(loginBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    private lazy var registerBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle(SDK.R.string.login_register, for: .normal)
        btn.setTitleColor(SDK.Color.themeBlue, for: .normal)
        btn.titleLabel?.font = SDK.Font.arial(13)
        btn.addTarget(self, action: #selector(registerBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    private lazy var forgetPassBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle(SDK.R.string.login_retrievePass, for: .normal)
        btn.setTitleColor(SDK.Color.theme, for: .normal)
        btn.titleLabel?.font = SDK.Font.arial(13)
        btn.alpha = 0.5
        btn.addTarget(self, action: #selector(forgetPassBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        base_title = SDK.R.string.login_email
        base_exitBtnIsHidden = true
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

extension LoginEmailView {
    @objc private func loginBtnClicked() {
        if loginBtnCallback != nil {
            loginBtnCallback! (emailTextField.text ?? "", passTextField.text ?? "")
        }
    }
    
    @objc private func registerBtnClicked() {
        if registerBtnCallback != nil {
            registerBtnCallback! ()
        }
    }
    
    @objc private func forgetPassBtnClicked() {
        if forgetBtnCallback != nil {
            forgetBtnCallback! ()
        }
    }
}

extension LoginEmailView {
    private func addChildView() {
        addSubview(emailTextField)
        addSubview(passTextField)
        addSubview(loginBtn)
        addSubview(registerBtn)
        addSubview(forgetPassBtn)
    }
}

extension LoginEmailView {
    private func layoutChildView() {
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(62 * K_Ratio)
            make.left.equalToSuperview().offset(44 * K_Ratio)
            make.right.equalToSuperview().offset(-44 * K_Ratio)
            make.height.equalTo(40 * K_Ratio)
        }
        passTextField.snp.makeConstraints { (make) in
            make.left.right.equalTo(emailTextField)
            make.top.equalTo(emailTextField.snp.bottom).offset(10 * K_Ratio)
            make.height.equalTo(40 * K_Ratio)
        }
        loginBtn.snp.makeConstraints { (make) in
            make.left.right.equalTo(emailTextField)
            make.top.equalTo(passTextField.snp.bottom).offset(10 * K_Ratio)
            make.height.equalTo(34 * K_Ratio)
        }
        registerBtn.snp.makeConstraints { (make) in
            make.top.equalTo(loginBtn.snp.bottom).offset(10 * K_Ratio)
            make.left.equalTo(emailTextField)
        }
        forgetPassBtn.snp.makeConstraints { (make) in
            make.top.equalTo(registerBtn)
            make.right.equalTo(emailTextField)
        }
    }
}


