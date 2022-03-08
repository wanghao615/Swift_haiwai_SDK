//
//  BindingEmailView.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/24.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class BindingEmailView: BaseView {
    var smsBtnCallback: ((UIButton, String) -> ())?
    var sumitBtnCallback: ((String, String, String) -> ())?
    
    private lazy var titleLable: UILabel = {
        let t = UILabel()
        t.textColor = SDK.Color.theme
        t.font = SDK.Font.arial(13)
        t.numberOfLines = 0
        t.text = SDK.R.string.bindingEmail_remind
        return t
    }()
    
    private lazy var textField: N_TextField = {
        let t = N_TextField(.zero, SDK.R.image.bindingEmail_email, nil)
        t.placeHolderText = SDK.R.string.bindingEmail_InputEmail
        t.textColor = SDK.Color.theme
        t.limitLength = 50
        t.autocorrectionType = .no
        t.spellCheckingType = .no
        return t
    }()
    
    lazy var codeField: N_TextField = {
        let t = N_TextField(.zero, SDK.R.image.usercenter_passNum, SDK.R.string.usercenter_sendCode)
        t.placeHolderText = SDK.R.string.u_smsCode
        t.textColor = SDK.Color.theme
        t.limitLength = 6
        t.rightTitle = SDK.R.string.usercenter_sendCode
        return t
    }()
    
    private lazy var passField: N_TextField = {
        let t = N_TextField(.zero, SDK.R.image.u_pass, SDK.R.image.usercenter_passEye, SDK.R.image.usercenter_passEye_high)
        t.placeHolderText = SDK.R.string.u_passRule
        t.textColor = SDK.Color.theme
        t.limitLength = 20
        t.isSecureTextEntry = true;
        return t
    }()
    
    private lazy var sumitBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle(SDK.R.string.u_sumit, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = SDK.Font.arial(13)
        btn.setBackgroundImage(SDK.R.image.u_btnBack, for: .normal)
        btn.setBackgroundImage(SDK.R.image.u_btnBack_high, for: .highlighted)
        btn.addTarget(self, action: #selector(sumitBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addChildView()
        addCallback()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutChildView()
    }
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
    }
}

extension BindingEmailView {
    @objc private func sumitBtnClicked() {
        if sumitBtnCallback != nil {
            sumitBtnCallback! (textField.text ?? "", codeField.text ?? "", passField.text ?? "")
        }
    }
}

extension BindingEmailView {
    private func addChildView() {
        addSubview(titleLable)
        addSubview(textField)
        addSubview(codeField)
        addSubview(passField)
        addSubview(sumitBtn)
    }
}

extension BindingEmailView {
    private func addCallback() {
        codeField.rightBtnCallback = { [unowned self] 
            (btn: UIButton) in
            if self.smsBtnCallback != nil {
                self.smsBtnCallback! (btn, self.textField.text ?? "")
            }
        }
    }
}

extension BindingEmailView {
    private func layoutChildView() {
        titleLable.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50 * K_Ratio)
            make.left.equalToSuperview().offset(40 * K_Ratio)
            make.right.equalToSuperview().offset(-40 * K_Ratio)
        }
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(titleLable.snp.bottom).offset(10 * K_Ratio)
            make.left.right.equalTo(titleLable)
            make.height.equalTo(40 * K_Ratio)
        }
        codeField.snp.makeConstraints { (make) in
            make.top.equalTo(textField.snp.bottom).offset(10 * K_Ratio)
            make.left.right.equalTo(titleLable)
            make.height.equalTo(40 * K_Ratio)
        }
        passField.snp.makeConstraints { (make) in
            make.top.equalTo(codeField.snp.bottom).offset(10 * K_Ratio)
            make.left.right.equalTo(titleLable)
            make.height.equalTo(40 * K_Ratio)
        }
        sumitBtn.snp.makeConstraints { (make) in
            make.top.equalTo(passField.snp.bottom).offset(10 * K_Ratio)
            make.left.right.equalTo(titleLable)
            make.height.equalTo(34 * K_Ratio)
        }
    }
}
