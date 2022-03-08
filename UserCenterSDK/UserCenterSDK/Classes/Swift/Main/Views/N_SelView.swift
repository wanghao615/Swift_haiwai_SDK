//
//  N_SelView.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/18.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class N_SelView: UIView {
    var selBtnCallback: ((Int) -> ())?
    var titleArr: [String] = []
    var selBtn: UIButton?
    
    private lazy var backView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black
        v.alpha = 0.05
        return v
    }()
    
    private lazy var lineView: UIView = {
        let v = UIView()
        v.backgroundColor = SDK.Color.themeBlue
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(_ frame: CGRect, _ titleArr: [String]) {
        self.init(frame: frame)
        self.titleArr = titleArr
        addChildView()
        let btn: UIButton = viewWithTag(10) as! UIButton
        btnClicked(btn: btn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutChildView()
    }
}

extension N_SelView {
    @objc func btnClicked(btn: UIButton) {
        selBtn?.setTitleColor(SDK.Color.themePlaceHolder, for: .normal)
        selBtn = btn
        btn.setTitleColor(SDK.Color.themeBlue, for: .normal)
        lineView.x = btn.width * CGFloat((btn.tag - 10))
        if selBtnCallback != nil { selBtnCallback! (btn.tag - 10) }
    }
}

extension N_SelView {
    private func addChildView() {
        addSubview(backView)
        print(titleArr)
        for i in 0..<titleArr.count {
            let bt = UIButton.init(type: .custom)
            bt.tag = 10 + i
            bt.titleLabel?.font = SDK.Font.arial(13)
            bt.setTitle(titleArr[i], for: .normal)
            bt.setTitleColor(SDK.Color.themePlaceHolder, for: .normal)
            bt.addTarget(self, action: #selector(btnClicked(btn:)), for: .touchUpInside)
            addSubview(bt)
        }
        addSubview(lineView)
    }
}

extension N_SelView {
    private func layoutChildView() {
        backView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        let btnWidth: CGFloat = (SDK.size.width - 8 * K_Ratio) / CGFloat(titleArr.count)
        for i in 0..<titleArr.count {
            let bt = self.viewWithTag(10 + i)
            bt?.snp.makeConstraints({ (make) in
                make.top.equalToSuperview()
                make.bottom.equalToSuperview().offset(-1)
                make.width.equalTo(btnWidth)
                make.left.equalToSuperview().offset(btnWidth * CGFloat(i))
            })
        }
        lineView.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.height.equalTo(1)
            make.width.equalTo(btnWidth)
        }
    }
}
