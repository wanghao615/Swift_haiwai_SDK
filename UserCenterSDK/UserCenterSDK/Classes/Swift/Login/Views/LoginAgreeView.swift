//
//  LoginAgreeView.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/29.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class LoginAgreeView: BaseView {
    var user_protocol: String? {
        didSet {
            contentLable.text = user_protocol
        }
    }
    
    var user_privacy_protocol: String?
    
    private lazy var selView: N_SelView = {
        var titleArr: [String] = [SDK.R.string.login_regulations, SDK.R.string.login_gameRegulations]
        let selView = N_SelView.init(.zero, titleArr)
        return selView
    }()
    
    private lazy var scorllView: UIScrollView = {
        let s = UIScrollView()
        s.showsHorizontalScrollIndicator = false
        return s
    }()
    
    private lazy var contentLable: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.font = SDK.Font.arial(14)
        l.textColor = SDK.Color.theme
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        base_title = SDK.R.string.login_checkRegulations
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

extension LoginAgreeView {
    private func addChildView() {
        addSubview(selView)
        addSubview(scorllView)
        scorllView.addSubview(contentLable)
    }
}

extension LoginAgreeView {
    private func addCallback() {
        selView.selBtnCallback = {
        [unowned self] (type) in
           switch type {
           case 0:
                self.contentLable.text = self.user_protocol
           case 1:
                self.contentLable.text = self.user_privacy_protocol
           default:
               break
           }
       }
    }
}

extension LoginAgreeView {
    private func layoutChildView() {
        selView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(45 * K_Ratio)
            make.left.equalToSuperview().offset(4 * K_Ratio)
            make.right.equalToSuperview().offset(-4 * K_Ratio)
            make.height.equalTo(34 * K_Ratio)
        }
        scorllView.snp.makeConstraints { (make) in
            make.left.right.equalTo(selView)
            make.top.equalTo(selView.snp.bottom)
            make.bottom.equalToSuperview().offset(-6 * K_Ratio)
        }
        contentLable.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20 * K_Ratio)
            make.right.equalTo(self).offset(-20 * K_Ratio)
            make.top.equalToSuperview().offset(20 * K_Ratio)
            make.bottom.equalToSuperview()
        }
    }
}
