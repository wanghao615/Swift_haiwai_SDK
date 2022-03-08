//
//  LoginRetrievePassView.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/29.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class LoginRetrievePassView: BaseView {
    var email: String?
    var phone: String?
    
    lazy var emailView: RetrievePassByEmailView = {
        let emailView = RetrievePassByEmailView()
        emailView.email = email
        return emailView
    }()
    
    lazy var emailAndPhone: RetrievePassByEmailAndPhoneView = {
        let emailAndPhone = RetrievePassByEmailAndPhoneView()
        emailAndPhone.emailView.email = email
        emailAndPhone.phoneView.email = email
        emailAndPhone.phoneView.phone = phone
        return emailAndPhone
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        base_title = SDK.R.string.login_retrievePass
        base_exitBtnIsHidden = true
    }
    
    convenience init(frame: CGRect, email: String, phone: String?) {
        self.init(frame: frame)
        self.email = email
        self.phone = phone
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

extension LoginRetrievePassView {
    private func addChildView() {
        if let phone = phone, phone.count > 0 {
            addSubview(emailAndPhone)
        }else {
            addSubview(emailView)
        }
    }
}

extension LoginRetrievePassView {
    private func layoutChildView() {
        if let phone = phone, phone.count > 0 {
            emailAndPhone.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(45 * K_Ratio)
                make.left.right.bottom.equalToSuperview()
            }
        }else {
            emailView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(86 * K_Ratio)
                make.left.right.bottom.equalToSuperview()
            }
        }
    }
}
