//
//  UserCenterModifyPassView.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/18.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class UserCenterModifyPassView: BaseView {
    
    var type: Int = 0
    var phoneN: String = ""
    var email: String = ""
    
    private lazy var selView: N_SelView = {
        var titleArr: [String] = [SDK.R.string.usercenter_modifyPassByPass, SDK.R.string.u_passByEmail]
        if type == 0 {
            titleArr.append(SDK.R.string.u_passByPhone)
        }
        let selView = N_SelView.init(.zero, titleArr)
        return selView
    }()
    
   lazy var byPassView: UserCenterModifyPassByPassView = {
        let byPassView = UserCenterModifyPassByPassView()
        return byPassView
    }()
    
    lazy var byEmailView: UserCenterModifyPassByEmailView = {
        let byEmailView = UserCenterModifyPassByEmailView()
        byEmailView.email = email
        byEmailView.isHidden = true
        return byEmailView
    }()
    
    lazy var byPhoneView: UserCenterModifyPassByPhoneView = {
        let byPhoneView = UserCenterModifyPassByPhoneView()
        byPhoneView.phone = phoneN
        byPhoneView.email = email
        byPhoneView.isHidden = true
        return byPhoneView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        base_title = SDK.R.string.usercenter_modifyPass
    }
    
    convenience init(frame: CGRect, type: Int, phoneN: String, email: String) {
        self.init(frame: frame)
        self.type = type
        self.phoneN = phoneN
        self.email = email
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

extension UserCenterModifyPassView {
    private func addChildView() {
        addSubview(selView)
        addSubview(byPassView)
        addSubview(byEmailView)
        addSubview(byPhoneView)
    }
}

extension UserCenterModifyPassView {
    private func addCallback() {
        selView.selBtnCallback = {
         [unowned self] (type) in
            switch type {
            case 0:
                self.byPassView.isHidden = false
                self.byEmailView.isHidden = true
                self.byPhoneView.isHidden = true
            case 1:
                self.byPassView.isHidden = true
                self.byEmailView.isHidden = false
                self.byPhoneView.isHidden = true
            case 2:
                self.byPassView.isHidden = true
                self.byEmailView.isHidden = true
                self.byPhoneView.isHidden = false
            default:
                break
            }
        }
    }
}

extension UserCenterModifyPassView {
    private func layoutChildView() {
        selView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(45 * K_Ratio)
            make.left.equalToSuperview().offset(4 * K_Ratio)
            make.right.equalToSuperview().offset(-4 * K_Ratio)
            make.height.equalTo(34 * K_Ratio)
        }
        byPassView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(selView.snp.bottom).offset(37 * K_Ratio)
        }
        byEmailView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(selView.snp.bottom).offset(25 * K_Ratio)
        }
        byPhoneView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(selView.snp.bottom).offset(12 * K_Ratio)
        }
    }
}
