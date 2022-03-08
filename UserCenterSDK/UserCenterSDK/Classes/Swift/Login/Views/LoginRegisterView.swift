//
//  LoginRegisterView.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/28.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class LoginRegisterView: BaseView {
    var codeCallback: ((UIButton, String) -> ())?
    var agreeContentCallback: (() -> ())?
    var loginBtnCallback: ((String, String, String, Bool) -> ())?
    
    private lazy var emailTextField: N_TextField = {
        let t = N_TextField(.zero, SDK.R.image.bindingEmail_email, nil)
        t.placeHolderText = SDK.R.string.login_emailAccount
        t.textColor = SDK.Color.theme
        t.limitLength = 50
        t.autocorrectionType = .no
        t.spellCheckingType = .no
        return t
    }()
    
    lazy var codeTextField: N_TextField = {
        let t = N_TextField(.zero, SDK.R.image.usercenter_passNum, SDK.R.string.usercenter_sendCode)
        t.placeHolderText = SDK.R.string.u_smsCode
        t.textColor = SDK.Color.theme
        t.limitLength = 6
        t.rightTitle = SDK.R.string.usercenter_sendCode
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
    
    private lazy var agreeBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setBackgroundImage(SDK.R.image.login_agreeNo, for: .normal)
        btn.setBackgroundImage(SDK.R.image.login_agree, for: .selected)
        btn.addTarget(self, action: #selector(agreeBtnClicked(btn:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var agreeLable: UILabel = {
        let l = UILabel()
        l.textColor = SDK.Color.theme
        l.font = SDK.Font.arial(14)
        l.text = SDK.R.string.login_agree
        l.textAlignment = .left
        return l
    }()
    
    private lazy var agreeContentBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        let attS: NSMutableAttributedString = NSMutableAttributedString(string: SDK.R.string.login_checkAgree, attributes: [.foregroundColor: SDK.Color.themeBlue, .font: SDK.Font.arial(13) as Any, .underlineStyle: NSUnderlineStyle.single.rawValue])
        btn.setAttributedTitle(attS, for: .normal)
        btn.addTarget(self, action: #selector(agreeContentBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    private lazy var registerBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle(SDK.R.string.login_register, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = SDK.Font.arial(13)
        btn.setBackgroundImage(SDK.R.image.u_btnBack, for: .normal)
        btn.setBackgroundImage(SDK.R.image.u_btnBack_high, for: .highlighted)
        btn.addTarget(self, action: #selector(registerBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        base_title = SDK.R.string.login_register
        base_exitBtnIsHidden = true
        addChildView()
        addCallback()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutChildView()
    }
}

extension LoginRegisterView {
    @objc private func agreeBtnClicked(btn: UIButton) {
        btn.isSelected = !btn.isSelected
    }
    
    @objc private func agreeContentBtnClicked() {
        if agreeContentCallback != nil {
            agreeContentCallback! ()
        }
    }
    
    @objc private func registerBtnClicked() {
        if loginBtnCallback != nil {
            loginBtnCallback! (emailTextField.text ?? "", codeTextField.text ?? "", passTextField.text ?? "", agreeBtn.isSelected)
        }
    }
}

extension LoginRegisterView {
    private func addChildView() {
        addSubview(emailTextField)
        addSubview(codeTextField)
        addSubview(passTextField)
        addSubview(agreeBtn)
        addSubview(agreeLable)
        addSubview(agreeContentBtn)
        addSubview(registerBtn)
    }
}

extension LoginRegisterView {
    private func addCallback() {
        codeTextField.rightBtnCallback = {
            [unowned self] (btn: UIButton) in
            if self.codeCallback != nil {
                self.codeCallback! (btn, self.emailTextField.text ?? "")
            }
        }
    }
}

extension LoginRegisterView {
    private func layoutChildView() {
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(62 * K_Ratio)
            make.left.equalToSuperview().offset(44 * K_Ratio)
            make.right.equalToSuperview().offset(-44 * K_Ratio)
            make.height.equalTo(40 * K_Ratio)
        }
        codeTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(10 * K_Ratio)
            make.left.right.equalTo(emailTextField)
            make.height.equalTo(40 * K_Ratio)
        }
        passTextField.snp.makeConstraints { (make) in
            make.top.equalTo(codeTextField.snp.bottom).offset(10 * K_Ratio)
            make.left.right.equalTo(emailTextField)
            make.height.equalTo(40 * K_Ratio)
        }
        agreeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(passTextField.snp.bottom).offset(10 * K_Ratio)
            make.left.equalTo(emailTextField)
        }
        agreeLable.snp.makeConstraints { (make) in
            make.centerY.equalTo(agreeBtn)
            make.left.equalTo(agreeBtn.snp.right).offset(10 * K_Ratio)
        }
        agreeContentBtn.snp.makeConstraints { (make) in
            make.right.equalTo(emailTextField)
            make.centerY.equalTo(agreeBtn)
        }
        registerBtn.snp.makeConstraints { (make) in
            make.top.equalTo(agreeBtn.snp.bottom).offset(10 * K_Ratio)
            make.left.right.equalTo(emailTextField)
            make.height.equalTo(34 * K_Ratio)
        }
    }
}
