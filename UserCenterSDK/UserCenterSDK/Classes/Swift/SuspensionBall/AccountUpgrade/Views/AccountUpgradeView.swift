//
//  AccountUpgradeView.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/30.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class AccountUpgradeView: BaseView {
    private var dict: [String: String] = [:]
    var thirdBtnCallback: ((String) -> ())?
    var accBtnCallback: (() -> ())?
    
    private var titleArr: [String] {
        return SDKTool.supportLoginTypeArr
    }
    
    private lazy var titleLable: UILabel = {
        let t = UILabel()
        t.textColor = SDK.Color.theme
        t.font = SDK.Font.arial(13)
        t.numberOfLines = 0
        t.textAlignment = .center
        t.text = SDK.R.string.accountUpgrade_binding
        return t
    }()
    
    private lazy var accBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.layer.cornerRadius = 2
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(accBtnClicked), for: .touchUpInside)
        if titleArr.count != 6 {
            btn.setBackgroundImage(SDK.R.image.accountUpgrade_accBg, for: .normal)
        }
        btn.setTitle(SDK.R.string.u_accountExit, for: .normal)
        btn.setTitleColor(SDK.Color.themePlaceHolder, for: .normal)
        btn.titleLabel?.font = SDK.Font.arial(12)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        base_title = SDK.R.string.accountUpgrade_a
        base_backBtnIsHidden = true
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

extension AccountUpgradeView {
    private func addChildView() {
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
        addSubview(accBtn)
    }
}

extension AccountUpgradeView {
    @objc private func accBtnClicked() {
        if accBtnCallback != nil {
            accBtnCallback! ()
        }
    }
    
    @objc private func btnClicked(btn: UIView) {
        if thirdBtnCallback != nil {
            thirdBtnCallback! (dict["\(btn.tag)"] ?? "")
        }
    }
}

extension AccountUpgradeView {
    private func layoutChildView() {
        titleLable.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(64 * K_Ratio)
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
            accBtn.snp.makeConstraints { (make) in
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
                accBtn.snp.makeConstraints { (make) in
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
                    accBtn.snp.makeConstraints { (make) in
                        make.left.equalToSuperview().offset(margin + (btnW + colMargin))
                        make.top.equalTo(titleLable.snp.bottom).offset(marginY * K_Ratio + (1 * (btnH + rowMargin)))
                        make.size.equalTo(CGSize(width: btnW, height: btnH));
                    }
                }
                if titleArr.count == 4 {
                    accBtn.snp.makeConstraints { (make) in
                        make.top.equalTo(titleLable.snp.bottom).offset(marginY * K_Ratio + (2 * (btnH + rowMargin)))
                        make.centerX.equalToSuperview()
                        make.size.equalTo(CGSize(width: btnW, height: btnH));
                    }
                }
                if titleArr.count == 5 {
                    accBtn.snp.makeConstraints { (make) in
                        make.left.equalToSuperview().offset(margin + (btnW + colMargin))
                        make.top.equalTo(titleLable.snp.bottom).offset(marginY * K_Ratio + (2 * (btnH + rowMargin)))
                        make.size.equalTo(CGSize(width: btnW, height: btnH));
                    }
                }
                if titleArr.count == 6 {
                    accBtn.snp.makeConstraints { (make) in
                        make.centerX.equalToSuperview()
                        make.bottom.equalToSuperview().offset(-5 * K_Ratio);
                    }
                }
            }
        }
    }
}
