//
//  BaseView.swift
//  KingNetSDK
//
//  Created by admin on 2020/11/27.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit
import SnapKit

class BaseView: UIView {
    var base_backBtnCallback: (() -> (Void))?
    var base_exitBtnCallback: (() -> (Void))?
    
    var base_title: String? {
        didSet {
            titleLable.text = base_title
        }
    }
    
    var base_lineIsHidden: Bool = false {
        didSet {
            lineView.isHidden = base_lineIsHidden
        }
    }
    
    var base_backBtnIsHidden: Bool = false {
        didSet {
            backBtn.isHidden = base_backBtnIsHidden
        }
    }
    
    var base_exitBtnIsHidden: Bool = false {
        didSet {
            exitBtn.isHidden = base_exitBtnIsHidden
        }
    }
    
    private lazy var backImageView: UIImageView = {
        let backImageView = UIImageView()
        backImageView.image = SDK.R.image.main_back
        return backImageView
    }()
    
    private lazy var topView: UIView = {
        let topView = UIView()
        return topView
    }()
    
    private lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = SDK.Color.theme
        lineView.alpha = 0.2
        return lineView
    }()
    
    private lazy var titleLable: UILabel = {
        let titleLable = UILabel()
        titleLable.textColor = SDK.Color.theme
        titleLable.font = SDK.Font.arial(16)
        return titleLable
    }()
    
    private lazy var backBtn: UIButton = {
        let backBtn = UIButton.init(type: .custom)
        backBtn.setBackgroundImage(SDK.R.image.main_back_arrow, for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnClicked), for: .touchUpInside)
        backBtn.setEnlargeEdge(top: 10, bottom: 10, left: 10, right: 50)
        return backBtn
    }()
    
    private lazy var exitBtn: UIButton = {
        let exitBtn = UIButton.init(type: .custom)
        exitBtn.setBackgroundImage(SDK.R.image.main_back_close, for: .normal)
        exitBtn.addTarget(self, action: #selector(exitBtnClicked), for: .touchUpInside)
        exitBtn.setEnlargeEdge(top: 10, bottom: 10, left: 50, right: 10)
        return exitBtn
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

extension BaseView {
    @objc private func backBtnClicked() {
        if base_backBtnCallback != nil {
            base_backBtnCallback!()
        }
    }
    
    @objc private func exitBtnClicked() {
        if base_exitBtnCallback != nil {
            base_exitBtnCallback!()
        }
    }
}

extension BaseView {
    private func addChildView() {
        addSubview(backImageView)
        addSubview(topView)
        addSubview(lineView)
        topView.addSubview(titleLable)
        topView.addSubview(backBtn)
        topView.addSubview(exitBtn)
    }
    
    private func layoutChildView() {
        backImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        topView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(44 * K_Ratio)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(4)
            make.right.equalToSuperview().offset(-4)
            make.top.equalTo(topView.snp.bottom)
            make.height.equalTo(1)
        }
        titleLable.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(2)
        }
        backBtn.snp.makeConstraints { (make) in
            make.left.equalTo(topView.snp.left).offset(15 * K_Ratio)
            make.centerY.equalTo(topView).offset(2)
        }
        exitBtn.snp.makeConstraints { (make) in
            make.right.equalTo(topView.snp.right).offset(-15 * K_Ratio)
            make.centerY.equalTo(topView).offset(2)
        }
    }
}

