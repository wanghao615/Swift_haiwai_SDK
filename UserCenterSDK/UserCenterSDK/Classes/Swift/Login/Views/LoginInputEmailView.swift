//
//  LoginInputEmailView.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/29.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class LoginInputEmailView: BaseView {
    var nextBtnCallback: ((String) -> ())?
    
    private lazy var emailTextField: N_TextField = {
        let t = N_TextField(.zero, SDK.R.image.bindingEmail_email, nil)
        t.placeHolderText = SDK.R.string.login_emailAccount
        t.textColor = SDK.Color.theme
        t.limitLength = 50
        t.autocorrectionType = .no
        t.spellCheckingType = .no
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
        base_title = SDK.R.string.login_retrievePass
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

extension LoginInputEmailView {
    @objc private func nextBtnClicked() {
        if nextBtnCallback != nil {
            nextBtnCallback! (emailTextField.text ?? "")
        }
    }
}

extension LoginInputEmailView {
    private func addChildView() {
        addSubview(emailTextField)
        addSubview(nextBtn)
    }
}

extension LoginInputEmailView {
    private func layoutChildView() {
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100 * K_Ratio)
            make.left.equalToSuperview().offset(44 * K_Ratio)
            make.right.equalToSuperview().offset(-44 * K_Ratio)
            make.height.equalTo(40 * K_Ratio)
        }
        nextBtn.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(10 * K_Ratio)
            make.left.right.equalTo(emailTextField)
            make.height.equalTo(34 * K_Ratio)
        }
    }
}
