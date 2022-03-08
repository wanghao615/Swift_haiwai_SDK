//
//  RetrievePassByView.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/29.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class RetrievePassByEmailView: UIView {
    var email: String? {
        didSet {
            guard let email = email else { return }
            let attS: NSMutableAttributedString = attributeS(SDK.R.string.u_account, email)
            emailLable.attributedText = attS
        }
    }
    
    var nextBtnCallback: ((String) -> ())?
    
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

extension RetrievePassByEmailView {
    @objc private func nextBtnClicked() {
        if nextBtnCallback != nil {
            nextBtnCallback! (textField.text ?? "")
        }
    }
}

extension RetrievePassByEmailView {
    private func addChildView() {
        addSubview(emailLable)
        addSubview(textField)
        addSubview(nextBtn)
    }
}

extension RetrievePassByEmailView {
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

// MARK: - RetrievePassByPhoneView

class RetrievePassByPhoneView: UIView {
    
    var nextBtnCallback: ((String) -> ())?
    
    var email: String? {
        didSet {
            guard let email = email else { return }
            let attS: NSMutableAttributedString = attributeS(SDK.R.string.u_account, email)
            emailLable.attributedText = attS
        }
    }
    
    var phone: String? {
        didSet {
            guard let phone = phone else { return }
            let attS: NSMutableAttributedString = attributeS(SDK.R.string.u_phone, phone)
            phoneLable.attributedText = attS
        }
    }
    
    private lazy var phoneLable: UILabel = {
        let l = UILabel()
        l.font = SDK.Font.arial(12)
        return l
    }()
    
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
    
    
    @objc private func nextBtnClicked() {
        if nextBtnCallback != nil {
            nextBtnCallback! (textField.text ?? "")
        }
    }
}

extension RetrievePassByPhoneView {
    private func addChildView() {
        addSubview(phoneLable)
        addSubview(emailLable)
        addSubview(textField)
        addSubview(nextBtn)
    }
}

extension RetrievePassByPhoneView {
    private func layoutChildView() {
        phoneLable.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(44 * K_Ratio)
        }
        emailLable.snp.makeConstraints { (make) in
            make.top.equalTo(phoneLable.snp.bottom).offset(8 * K_Ratio)
            make.left.equalTo(phoneLable)
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

// MARK: - RetrievePassByEmailAndPhoneView

class RetrievePassByEmailAndPhoneView: UIView {
    private lazy var selView: N_SelView = {
        var titleArr: [String] = [SDK.R.string.u_passByEmail, SDK.R.string.u_passByPhone]
        let selView = N_SelView.init(.zero, titleArr)
        return selView
    }()
    
    lazy var emailView: RetrievePassByEmailView = {
        let emailView = RetrievePassByEmailView()
        return emailView
    }()
    
    lazy var phoneView: RetrievePassByPhoneView = {
        let phoneView = RetrievePassByPhoneView()
        phoneView.isHidden = true
        return phoneView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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

extension RetrievePassByEmailAndPhoneView {
    private func addChildView() {
        addSubview(selView)
        addSubview(emailView)
        addSubview(phoneView)
    }
}

extension RetrievePassByEmailAndPhoneView {
    private func addCallback() {
        selView.selBtnCallback = {
         [unowned self] (type) in
            switch type {
            case 0:
                self.emailView.isHidden = false
                self.phoneView.isHidden = true
            case 1:
                self.emailView.isHidden = true
                self.phoneView.isHidden = false
            default:
                break
            }
        }
    }
}

extension RetrievePassByEmailAndPhoneView {
    private func layoutChildView() {
        selView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(4 * K_Ratio)
            make.right.equalToSuperview().offset(-4 * K_Ratio)
            make.height.equalTo(34 * K_Ratio)
        }
        emailView.snp.makeConstraints { (make) in
            make.top.equalTo(selView.snp.bottom).offset(25 * K_Ratio)
            make.left.right.bottom.equalToSuperview()
        }
        phoneView.snp.makeConstraints { (make) in
            make.top.equalTo(selView.snp.bottom).offset(12 * K_Ratio)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

