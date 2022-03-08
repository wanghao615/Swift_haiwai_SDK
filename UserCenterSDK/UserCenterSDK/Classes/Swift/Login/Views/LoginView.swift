//
//  LoginView.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/25.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class LoginView: UIView {
    private var dict: [String: String] = [:]
    var thirdBtnCallback: ((String) -> ())?
    var touristBtnCallback: (() -> ())?
    
    private var titleArr: [String] {
        return SDKTool.supportLoginTypeArr
    }
    
    private lazy var backImageView: UIImageView = {
        let im = UIImageView()
        im.image = SDK.R.image.usercenter_AlertUback
        im.isUserInteractionEnabled = true
        return im
    }()
    
//    private lazy var iconImageView: UIImageView = {
//        let im = UIImageView()
//        im.image = SDK.R.image.u_logo
//        im.isUserInteractionEnabled = true
//        return im
//    }()
    
    private lazy var bunNameLab: UILabel = {
        let nameLab = UILabel()
        nameLab.textColor = UIColor.black
        nameLab.font = SDK.Font.arial(16)
        nameLab.text = KAppName
        return nameLab
    }()
    
    private lazy var titleLable: UILabel = {
        let l = UILabel()
        l.textColor = SDK.Color.theme
        l.font = SDK.Font.arial(12)
        l.text = SDK.R.string.login_type
        return l
    }()
    
    private lazy var touristBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.layer.cornerRadius = 2
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(touristBtnClicked), for: .touchUpInside)
        if titleArr.count != 6 {
            btn.setBackgroundImage(SDK.R.image.login_guest, for: .normal)
        }else {
            btn.setTitle("Guest", for: .normal)
            btn.setTitleColor(SDK.Color.themePlaceHolder, for: .normal)
            btn.titleLabel?.font = SDK.Font.arial(12)
        }
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

extension LoginView {
    @objc private func touristBtnClicked() {
        if touristBtnCallback != nil {
            touristBtnCallback! ()
        }
    }
    
    @objc private func btnClicked(btn: UIView) {
        if thirdBtnCallback != nil {
            thirdBtnCallback! (dict["\(btn.tag)"] ?? "")
        }
    }
}

extension LoginView {
    private func addChildView() {
        addSubview(backImageView)
//        addSubview(iconImageView)
        addSubview(bunNameLab)
        addSubview(titleLable)
        for i in 0..<titleArr.count {
            if titleArr[i] == "apple" {
                if #available(iOS 13.0, *) {//苹果登录按钮
                    let appleBtn = AppleLoginManger.share.appleBtn(type: .signIn, stytle: .whiteOutline)
                    appleBtn.addTarget(self, action: #selector(btnClicked(btn:)), for: .touchUpInside)
                    appleBtn.cornerRadius = 2
                    addSubview(appleBtn)
                    appleBtn.tag = 10 + i
                    dict["\(appleBtn.tag)"] = titleArr[i]
                }
            }else {
                let btn = UIButton.init(type: .custom)
                btn.tag = 10 + i
                btn.layer.cornerRadius = 2
                btn.layer.masksToBounds = true
                dict["\(btn.tag)"] = titleArr[i]
                btn.addTarget(self, action: #selector(btnClicked(btn:)), for: .touchUpInside)
                switch titleArr[i] {
                case "account":
                    btn.setBackgroundImage(SDK.R.image.login_email, for: .normal)
                case "google":
                    btn.setBackgroundImage(SDK.R.image.login_google, for: .normal)
                case "facebook":
                    btn.setBackgroundImage(SDK.R.image.login_facebook, for: .normal)
                case "line":
                    btn.setBackgroundImage(SDK.R.image.login_line, for: .normal)
                case "naver":
                    btn.setBackgroundImage(SDK.R.image.login_naver, for: .normal)
                case "twitter":
                    btn.setBackgroundImage(SDK.R.image.login_twitter, for: .normal)
                default:
                    break
                }
                addSubview(btn)
            }
        }
        addSubview(touristBtn)
    }
}

extension LoginView {
    private func layoutChildView() {
        backImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
//        iconImageView.snp.makeConstraints { (make) in
//            make.top.equalToSuperview().offset(25 * K_Ratio)
//            make.centerX.equalToSuperview()
//        }
        bunNameLab.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(25 * K_Ratio)
            make.centerX.equalToSuperview()
        }
        titleLable.snp.makeConstraints { (make) in
            make.top.equalTo(bunNameLab.snp.bottom).offset(13 * K_Ratio)
            make.centerX.equalToSuperview()
        }
        let margin = 41 * K_Ratio
        let btnW = 150 * K_Ratio
        let btnH = 34 * K_Ratio
        let colMargin = 6 * K_Ratio
        let rowMargin = 8 * K_Ratio
        let marginY = (titleArr.count == 3) ? 34 * K_Ratio : 14 * K_Ratio
        if titleArr.count == 1 {
            let btn: UIView! = viewWithTag(10)
            btn.snp.makeConstraints({ (make) in
                make.top.equalTo(titleLable.snp.bottom).offset(29 * K_Ratio)
                make.size.equalTo(CGSize(width: btnW, height: btnH))
                make.centerX.equalToSuperview()
            })
            touristBtn.snp.makeConstraints { (make) in
                make.top.equalTo(btn.snp.bottom).offset(8 * K_Ratio)
                make.size.equalTo(CGSize(width: btnW, height: btnH))
                make.centerX.equalToSuperview()
            }
        }else if titleArr.count == 2 {
            for i in 0..<titleArr.count {
                let btn: UIView! = viewWithTag(10 + i)
                btn.snp.makeConstraints { (make) in
                    make.top.equalTo(titleLable.snp.bottom).offset(Float(CGFloat(13 + 42 * i) * K_Ratio))
                    make.size.equalTo(CGSize(width: btnW, height: btnH))
                    make.centerX.equalToSuperview()
                }
                touristBtn.snp.makeConstraints { (make) in
                    make.top.equalTo(titleLable.snp.bottom).offset(97 * K_Ratio)
                    make.size.equalTo(CGSize(width: btnW, height: btnH))
                    make.centerX.equalToSuperview()
                }
            }
        }else {
            for i in 0..<titleArr.count {
                let tag: Int = 10 + i
                let btn: UIView! = viewWithTag(tag)
                let row: Int = i / 2
                let col: Int = i % 2
                let btnX: CGFloat = margin + CGFloat(CGFloat(col) * CGFloat(btnW + colMargin))
                let btnY: CGFloat = CGFloat(row) * CGFloat(btnH + rowMargin)
                btn.snp.makeConstraints { (make) in
                    make.top.equalTo(titleLable.snp.bottom).offset(marginY * K_Ratio + btnY);
                    make.size.equalTo(CGSize(width: btnW, height: btnH));
                    make.left.equalTo(self).offset(btnX);
                }
                if titleArr.count == 3 {
                    touristBtn.snp.makeConstraints { (make) in
                        make.left.equalToSuperview().offset(margin + (btnW + colMargin))
                        make.top.equalTo(titleLable.snp.bottom).offset(marginY * K_Ratio + (1 * (btnH + rowMargin)))
                        make.size.equalTo(CGSize(width: btnW, height: btnH));
                    }
                }
                if titleArr.count == 4 {
                    touristBtn.snp.makeConstraints { (make) in
                        make.top.equalTo(titleLable.snp.bottom).offset(marginY * K_Ratio + (2 * (btnH + rowMargin)))
                        make.centerX.equalToSuperview()
                        make.size.equalTo(CGSize(width: btnW, height: btnH));
                    }
                }
                if titleArr.count == 5 {
                    touristBtn.snp.makeConstraints { (make) in
                        make.left.equalToSuperview().offset(margin + (btnW + colMargin))
                        make.top.equalTo(titleLable.snp.bottom).offset(marginY * K_Ratio + (2 * (btnH + rowMargin)))
                        make.size.equalTo(CGSize(width: btnW, height: btnH));
                    }
                }
                if titleArr.count == 6 {
                    touristBtn.snp.makeConstraints { (make) in
                        make.centerX.equalToSuperview()
                        make.bottom.equalToSuperview().offset(-5 * K_Ratio);
                    }
                }
            }
        }
    }
}
