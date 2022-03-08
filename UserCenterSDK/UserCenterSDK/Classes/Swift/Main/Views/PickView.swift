//
//  PickView.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/1.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class PickView: UIView {
    var dataArr: [ServiceTypeModel]? {
        didSet {
            pickView.reloadAllComponents()
        }
    }
    
    var selRow: Int?
    var doneCallback: ((ServiceTypeModel?) -> (Void))?
    
    private lazy var pickView: UIPickerView = { [weak self] in
        let pickView = UIPickerView()
        pickView.backgroundColor = SDK.Color.themePicker
        pickView.showsSelectionIndicator = true
        pickView.delegate = self
        pickView.dataSource = self
        return pickView
    }()
    
    private lazy var selView: UIView = {
        let selView = UIView()
        selView.backgroundColor = SDK.Color.themePickerSelView
        return selView
    }()
    
    private lazy var doneBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("Done", for: .normal)
        btn.titleLabel?.font = SDK.Font.helveticaBold(17)
        btn.addTarget(self, action: #selector(doneBtnClicked), for: .touchUpInside)
        btn.setTitleColor(SDK.Color.themeBlue, for: .normal)
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

extension PickView {
    @objc private func doneBtnClicked() {//回调参数
        if doneCallback != nil {
            doneCallback!(dataArr?[selRow ?? 0])
        }
    }
}

extension PickView {
    private func addChildView() {
        addSubview(pickView)
        addSubview(selView)
        selView.addSubview(doneBtn)
    }
}

extension PickView {
    private func layoutChildView() {
        pickView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(150)
        }
        selView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(pickView.snp.top)
            make.height.equalTo(44)
        }
        doneBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 50, height: 44))
        }
    }
}

extension PickView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //记录选择的那一行
        selRow = row
    }
}

extension PickView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArr?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataArr?[row].name
    }
}
