//
//  UserCenterNewPassView.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/23.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class UserCenterNewPassView: BaseView {
    
    var sumitBtnCallback: ((String, String) -> ())?
    
    private lazy var titleLable: UILabel = {
        let l = UILabel()
        l.text = SDK.R.string.usercenter_certificationSuccess
        l.textColor = SDK.Color.theme
        l.font = SDK.Font.arial(12)
        l.textAlignment = .center
        return l
    }()
    
    private lazy var passTextField: N_TextField = {
        let t = N_TextField(.zero, SDK.R.image.u_pass, SDK.R.image.usercenter_passEye, SDK.R.image.usercenter_passEye_high)
        t.placeHolderText = SDK.R.string.u_passRule
        t.isSecureTextEntry = true;
        t.textColor = SDK.Color.theme
        t.limitLength = 20
        return t
    }()
    
    private lazy var againPassTextField: N_TextField = {
        let t = N_TextField(.zero, SDK.R.image.u_pass, SDK.R.image.usercenter_passEye, SDK.R.image.usercenter_passEye_high)
        t.placeHolderText = SDK.R.string.u_passRule
        t.isSecureTextEntry = true;
        t.textColor = SDK.Color.theme
        t.limitLength = 20
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
        base_title = SDK.R.string.usercenter_modifyPass
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutChildView()
    }
}

extension UserCenterNewPassView {
    @objc private func sumitBtnClicked() {
        if sumitBtnCallback != nil {
            sumitBtnCallback! (passTextField.text ?? "", againPassTextField.text ?? "")
        }
    }
}

extension UserCenterNewPassView {
    private func addChildView() {
        addSubview(titleLable)
        addSubview(passTextField)
        addSubview(againPassTextField)
        addSubview(sumitBtn)
    }
}

extension UserCenterNewPassView {
    private func layoutChildView() {
        titleLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(59 * K_Ratio)
            make.right.equalToSuperview().offset(-59 * K_Ratio)
            make.top.equalToSuperview().offset(61 * K_Ratio)
        }
        passTextField.snp.makeConstraints { (make) in
            make.top.equalTo(titleLable.snp.bottom).offset(10 * K_Ratio)
            make.left.equalToSuperview().offset(44 * K_Ratio)
            make.right.equalToSuperview().offset(-44 * K_Ratio)
            make.height.equalTo(40 * K_Ratio)
        }
        againPassTextField.snp.makeConstraints { (make) in
            make.left.right.equalTo(passTextField)
            make.top.equalTo(passTextField.snp.bottom).offset(10 * K_Ratio)
            make.height.equalTo(40 * K_Ratio)
        }
        sumitBtn.snp.makeConstraints { (make) in
            make.left.right.equalTo(passTextField)
            make.top.equalTo(againPassTextField.snp.bottom).offset(10 * K_Ratio)
            make.height.equalTo(34 * K_Ratio)
        }
    }
}
