//
//  UserProtocolDetailView.swift
//  KingNetSDK
//
//  Created by admin on 2021/1/6.
//  Copyright © 2021 niujf. All rights reserved.
//

import UIKit

class UserProtocolDetailView: BaseView {
    var title: String? {
        didSet {
            base_title = title
        }
    }
    
    var content: String? {
        didSet {
            contentLable.text = content
        }
    }
    
    private lazy var scrollView: UIScrollView = {
        let s = UIScrollView()
        s.showsHorizontalScrollIndicator = false
        return s
    }()
    
    private lazy var contentLable: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.textColor = SDK.Color.theme
        l.font = SDK.Font.arial(14)
        return l
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        base_backBtnIsHidden = true
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

extension UserProtocolDetailView {
    private func addChildView() {
        addSubview(scrollView)
        scrollView.addSubview(contentLable)
    }
}

extension UserProtocolDetailView {
    private func layoutChildView() {
        scrollView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(4 * K_Ratio)
            make.right.equalToSuperview().offset(-4 * K_Ratio)
            make.bottom.equalToSuperview().offset(-6 * K_Ratio)
            make.top.equalToSuperview().offset(46 * K_Ratio)
        }
        contentLable.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(20 * K_Ratio)
            make.right.equalToSuperview().offset(-20 * K_Ratio)
            make.bottom.equalToSuperview()
        }
    }
}
