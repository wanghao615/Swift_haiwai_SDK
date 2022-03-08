//
//  UserCenterView.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/8.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class UserCenterView: BaseView {
    var btnArr: [UIButton] = []
    var thirdBtnCallback: ((Int) -> ())?
    var btnTypeCallback: ((Int) -> ())?
    var paraCallback: ((String, String, String, String) -> ())?
    
    var accountStatusModel: UserCenterStatusModel<[UserCenterAccountStatusModel]>? {
        didSet {
            guard let statusModel = accountStatusModel?.fb_user_modules else { return }
            let nBtn: UIButton? = viewWithTag(10) as? UIButton
            let lBtn: UIButton? = viewWithTag(11) as? UIButton
            let tBtn: UIButton? = viewWithTag(12) as? UIButton
            let gBtn: UIButton? = viewWithTag(13) as? UIButton
            let fBtn: UIButton? = viewWithTag(14) as? UIButton
            var email: String = ""
            var phoneN: String = ""
            var zone: String = ""
            if statusModel.count > 0 {
                for model in statusModel {
                    if model.type == "bind_email" {//邮箱
                        if model.is_bind {//绑定了
                            emailBtn.setTitle(SDK.R.string.u_modifyPass, for: .normal)
                            emailContentLable.text = "  " + model.email
                            email = model.email
                        }else {
                            emailBtn.setTitle(SDK.R.string.usercenter_hasBinding, for: .normal)
                            emailContentLable.text = "  " + SDK.R.string.usercenter_noBinding
                        }
                    }
                    if model.type == "bind_mobile" {//手机
                        if model.is_bind {//绑定了
                            phoneBtn.isHidden = true
                            phoneContentLable.text = "  " + model.mobile
                            phoneN = model.mobile
                            zone = model.zone
                        }else {
                            phoneBtn.isHidden = false
                            phoneContentLable.text = "  " + SDK.R.string.usercenter_noBinding
                        }
                    }
                    if model.type == "bind_google" {
                        if model.is_bind {
                            gBtn?.isEnabled = false
                            gBtn?.setBackgroundImage(SDK.R.image.usercenter_google_high, for: .normal)
                        }else {
                            gBtn?.isEnabled = true
                            gBtn?.setBackgroundImage(SDK.R.image.usercenter_google, for: .normal)
                        }
                    }
                    if model.type == "bind_facebook" {
                        if model.is_bind {
                            fBtn?.isEnabled = false
                            fBtn?.setBackgroundImage(SDK.R.image.usercenter_facebook_high, for: .normal)
                        }else {
                            fBtn?.isEnabled = true
                            fBtn?.setBackgroundImage(SDK.R.image.usercenter_facebook, for: .normal)
                        }
                    }
                    if model.type == "bind_line" {
                        if model.is_bind {
                            lBtn?.isEnabled = false
                            lBtn?.setBackgroundImage(SDK.R.image.usercenter_line_high, for: .normal)
                        }else {
                            lBtn?.isEnabled = true
                            lBtn?.setBackgroundImage(SDK.R.image.usercenter_line, for: .normal)
                        }
                    }
                    if model.type == "bind_naver" {
                        if model.is_bind {
                            nBtn?.isEnabled = false
                            nBtn?.setBackgroundImage(SDK.R.image.usercenter_naver_high, for: .normal)
                        }else {
                            nBtn?.isEnabled = true
                            nBtn?.setBackgroundImage(SDK.R.image.usercenter_naver, for: .normal)
                        }
                    }
                    if model.type == "bind_twitter" {
                        if model.is_bind {
                            tBtn?.isEnabled = false
                            tBtn?.setBackgroundImage(SDK.R.image.usercenter_twitter_high, for: .normal)
                        }else {
                            tBtn?.isEnabled = true
                            tBtn?.setBackgroundImage(SDK.R.image.usercenter_twitter, for: .normal)
                        }
                    }
                }
            }
            if paraCallback != nil { paraCallback! (accountStatusModel?.auth_token ?? "", email, phoneN, zone) }
        }
    }
    
    private lazy var emailLable: UILabel = {
        let l = UILabel()
        l.text = SDK.R.string.u_bindingAccount + ":  "
        l.textColor = SDK.Color.theme
        l.alpha = 0.5
        l.font = SDK.Font.arial(12)
        return l
    }()
    
    private lazy var emailContentLable: UILabel = {
        let l = UILabel()
        l.text = "  " + SDK.R.string.usercenter_noBinding
        l.textColor = SDK.Color.theme
        l.font = SDK.Font.arial(12)
        l.backgroundColor = UIColor.white
        l.layer.borderWidth = 1
        l.layer.borderColor = SDK.Color.themeUserCenterBorder.cgColor
        l.layer.cornerRadius = 2
        l.layer.masksToBounds = true
        return l
    }()
    
    private lazy var emailBtn: UIButton = {
        let bt = UIButton.init(type: .custom)
        bt.setTitle(SDK.R.string.usercenter_hasBinding, for: .normal)
        bt.setTitleColor(UIColor.white, for: .normal)
        bt.titleLabel?.font = SDK.Font.arial(13)
        bt.setBackgroundImage(SDK.R.image.usercenter_btnBack, for: .normal)
        bt.setBackgroundImage(SDK.R.image.usercenter_btnBack_high, for: .highlighted)
        bt.addTarget(self, action: #selector(emailBtnClicked), for: .touchUpInside)
        return bt
    }()
    
    private lazy var phoneLable: UILabel = {
        let l = UILabel()
        l.text = SDK.R.string.usercenter_bindingPhone + ":  "
        l.textColor = SDK.Color.theme
        l.alpha = 0.5
        l.font = SDK.Font.arial(12)
        return l
    }()
    
    private lazy var phoneContentLable: UILabel = {
        let l = UILabel()
        l.text = "  " + SDK.R.string.usercenter_noBinding
        l.textColor = SDK.Color.theme
        l.font = SDK.Font.arial(12)
        l.backgroundColor = UIColor.white
        l.layer.borderWidth = 1
        l.layer.borderColor = SDK.Color.themeUserCenterBorder.cgColor
        l.layer.cornerRadius = 2
        l.layer.masksToBounds = true
        return l
    }()
    
    private lazy var phoneBtn: UIButton = {
        let bt = UIButton.init(type: .custom)
        bt.setTitle(SDK.R.string.usercenter_hasBinding, for: .normal)
        bt.setTitleColor(UIColor.white, for: .normal)
        bt.titleLabel?.font = SDK.Font.arial(13)
        bt.setBackgroundImage(SDK.R.image.usercenter_btnBack, for: .normal)
        bt.setBackgroundImage(SDK.R.image.usercenter_btnBack_high, for: .highlighted)
        bt.addTarget(self, action: #selector(phoneBtnClicked), for: .touchUpInside)
        return bt
    }()
    
    private lazy var thirdLable: UILabel = {
        let l = UILabel()
        l.text = SDK.R.string.usercenter_bindingThird + ":"
        l.textColor = SDK.Color.theme
        l.alpha = 0.5
        l.font = SDK.Font.arial(12)
        return l
    }()
    
    private lazy var accountBtn: UIButton = {
        let bt = UIButton.init(type: .custom)
        bt.setTitle(SDK.R.string.u_accountExit, for: .normal)
        bt.setTitleColor(UIColor.white, for: .normal)
        bt.titleLabel?.font = SDK.Font.arial(13)
        bt.setBackgroundImage(SDK.R.image.usercenter_exitBtnBack, for: .normal)
        bt.setBackgroundImage(SDK.R.image.usercenter_exitBtnBack_high, for: .highlighted)
        bt.addTarget(self, action: #selector(accountBtnClicked), for: .touchUpInside)
        return bt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        base_backBtnIsHidden = true
        base_title = SDK.R.string.usercenter_title
        addChildView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutChildView()
    }
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
    }
}

extension UserCenterView {
    @objc func emailBtnClicked() {
        if emailBtn.titleLabel?.text == SDK.R.string.u_modifyPass {//绑定了邮箱
            //判断有没有绑定手机号
            if phoneBtn.isHidden {//绑定了手机号
                if btnTypeCallback != nil { btnTypeCallback!(0) }
            }else {//没有绑定手机号
                if btnTypeCallback != nil { btnTypeCallback!(1) }
            }
        }else {//没有绑定邮箱
            if btnTypeCallback != nil { btnTypeCallback!(2) }
        }
    }
    
    @objc func phoneBtnClicked() {
        if btnTypeCallback != nil { btnTypeCallback!(3) }
    }
    
    @objc func accountBtnClicked() {
        if btnTypeCallback != nil { btnTypeCallback!(4) }
    }
    
    @objc func thirdBtnClicked(btn: UIButton) {
        if thirdBtnCallback != nil {
            thirdBtnCallback!(btn.tag)
        }
    }
}

extension UserCenterView {
    fileprivate func addChildView() {
        addSubview(emailLable)
        addSubview(emailContentLable)
        addSubview(emailBtn)
        addSubview(phoneLable)
        addSubview(phoneContentLable)
        addSubview(phoneBtn)
        addSubview(accountBtn)
        addSubview(thirdLable)
        //三方登录
        let titleArr = SDKTool.supportLoginTypeArr
        for e in titleArr.enumerated() {
            if e.element == "apple" || e.element == "account" {
            }else {
                let btn = UIButton.init(type: .custom)
                btn.addTarget(self, action: #selector(thirdBtnClicked(btn:)), for: .touchUpInside)
                if e.element == "naver" { btn.tag = 10 }
                if e.element == "line" { btn.tag = 11 }
                if e.element == "twitter" { btn.tag = 12 }
                if e.element == "google" { btn.tag = 13 }
                if e.element == "facebook" { btn.tag = 14 }
                btnArr.append(btn)
                addSubview(btn)
            }
        }
    }
}

extension UserCenterView {
    fileprivate func layoutChildView() {
        emailLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(34 * K_Ratio)
            make.top.equalToSuperview().offset(88 * K_Ratio)
            if SDK.sysLanguage == "zh-Hans" {
                make.width.equalTo(65 * K_Ratio)
            }else {
                make.width.equalTo(56 * K_Ratio)
            }
        }
        emailContentLable.snp.makeConstraints { (make) in
            make.left.equalTo(emailLable.snp.right).offset(4 * K_Ratio)
            make.centerY.equalTo(emailLable)
            make.right.equalToSuperview().offset(-34 * K_Ratio)
            make.height.equalTo(40 * K_Ratio)
        }
        emailBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(emailContentLable)
            make.size.equalTo(CGSize(width: 80 * K_Ratio, height: 34))
            make.right.equalTo(emailContentLable).offset(-3 * K_Ratio)
        }
        phoneLable.snp.makeConstraints { (make) in
            make.left.equalTo(emailLable)
            make.top.equalTo(emailLable.snp.bottom).offset(34 * K_Ratio)
            if SDK.sysLanguage == "zh-Hans" {
                make.width.equalTo(65 * K_Ratio)
            }else {
                make.width.equalTo(56 * K_Ratio)
            }
        }
        phoneContentLable.snp.makeConstraints { (make) in
            make.left.right.equalTo(emailContentLable)
            make.centerY.equalTo(phoneLable)
            make.height.equalTo(40 * K_Ratio)
        }
        phoneBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 80 * K_Ratio, height: 34))
            make.centerY.equalTo(phoneContentLable)
            make.right.equalTo(phoneContentLable).offset(-3 * K_Ratio)
        }
        accountBtn.snp.makeConstraints { (make) in
            make.right.equalTo(phoneContentLable)
            make.top.equalTo(phoneContentLable.snp.bottom).offset(9 * K_Ratio)
            make.size.equalTo(CGSize(width: 100 * K_Ratio, height: 34 * K_Ratio))
        }
        thirdLable.snp.makeConstraints { (make) in
            make.left.equalTo(phoneLable)
            make.centerY.equalTo(accountBtn)
            if SDK.sysLanguage == "zh-Hans" {
                make.width.equalTo(65 * K_Ratio)
            }else {
                make.width.equalTo(56 * K_Ratio)
            }
        }
        for i in 0 ..< btnArr.count {
            let btn = btnArr[i]
            btn.snp.makeConstraints { (make) in
                make.top.equalTo(phoneContentLable.snp.bottom).offset(9 * K_Ratio)
                make.size.equalTo(CGSize(width: 34 * K_Ratio, height: 34 * K_Ratio))
                make.left.equalTo(phoneContentLable).offset(CGFloat(i) * 39 * K_Ratio)
            }
        }
    }
}
