//
//  ServiceAdditionalQView.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/7.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class ServiceAdditionalQView: BaseView {
    var sumitCallback: ((String) -> ())?
    
    private lazy var titleLable: UILabel = {
        let l = UILabel()
        let text = SDK.R.string.service_replyContent
        let attS:NSMutableAttributedString = NSMutableAttributedString(string: text)
        let c = NSString(string: attS.string).range(of: "＊")
        attS.addAttributes([.foregroundColor: UIColor.red],range: c)
        l.attributedText = attS
        l.textColor = SDK.Color.theme
        l.font = SDK.Font.arial(13)
        l.textAlignment = .left
        return l
     }()
    
    private lazy var textView: N_TextView = { //[weak self] in
        let t = N_TextView()
        //t.delegate = self
        t.placeHolderLable.text = SDK.R.string.service_replyContentDetail
        t.placeHolderLable.textColor = SDK.Color.themePlaceHolder
        t.textColor = SDK.Color.theme
        t.font = SDK.Font.arial(12)
        t.placeHolderLable.font = SDK.Font.arial(12)
        return t
    }()
    
    private lazy var sumitBtn: UIButton = {
        let bt = UIButton.init(type: .custom)
        bt.setTitle(SDK.R.string.u_sumit, for: .normal)
        bt.titleLabel?.font = SDK.Font.arial(13)
        bt.backgroundColor = SDK.Color.themeBlue
        bt.layer.cornerRadius = 2
        bt.layer.masksToBounds = true
        bt.addTarget(self, action: #selector(sumitBtnClicked), for: .touchUpInside)
        return bt
    }()
    
      override init(frame: CGRect) {
          super.init(frame: frame)
          base_title = SDK.R.string.service_replyContent
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

extension ServiceAdditionalQView {
    @objc private func sumitBtnClicked() {
        if sumitCallback != nil {
            sumitCallback!(textView.text)
        }
    }
}

extension ServiceAdditionalQView {
    private func addChildView() {
        addSubview(titleLable)
        addSubview(textView)
        addSubview(sumitBtn)
    }
}

extension ServiceAdditionalQView  {
    fileprivate func layoutChildView() {
        titleLable.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(44 * K_Ratio)
            make.top.equalToSuperview().offset(56 * K_Ratio)
        }
        textView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLable)
            make.right.equalToSuperview().offset(-44 * K_Ratio)
            make.top.equalTo(titleLable.snp.bottom).offset(4 * K_Ratio)
            make.height.equalTo(162 * K_Ratio)
        }
        sumitBtn.snp.makeConstraints { (make) in
            make.left.right.equalTo(textView)
            make.top.equalTo(textView.snp.bottom).offset(11 * K_Ratio)
            make.height.equalTo(34 * K_Ratio)
        }
    }
}

