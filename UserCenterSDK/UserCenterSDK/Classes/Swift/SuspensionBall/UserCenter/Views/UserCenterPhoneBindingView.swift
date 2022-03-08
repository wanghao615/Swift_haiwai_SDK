//
//  UserCenterPhoneBindingView.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/24.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

fileprivate let KPhoneZoneCellID = "KPhoneZoneCellID"

class UserCenterPhoneBindingView: BaseView {
    
    var tableViewIsHidden: Bool? {
        didSet {
            tableView.isHidden = tableViewIsHidden ?? true
        }
    }
    
    var submitCallback: ((String, String, String) -> ())?
    var smsBtnCallback: ((UIButton, String, String) -> ())?
    
    private lazy var zoneArr: [JSON] = {
        let ls: String = SDK.sysLanguage
        var zoneC: String = ""
        if ls.contains("zh") {
            zoneC = "PhoneAreaCodeZH"
        }else {
            zoneC = "PhoneAreaCodeEN"
        }
        let jsonPath: String = Bundle.main.path(forResource:zoneC, ofType:"json") ?? ""
        do {
            let jsonData: Data = try Data.init(contentsOf: URL.init(fileURLWithPath: jsonPath))
            let jsonDict: [String: JSON] = JSON(jsonData).dictionaryValue
            let arr = jsonDict["data"]?.arrayValue
            return arr ?? []
        } catch {
            return []
        }
    }()
    
    private lazy var titleLable: UILabel = {
        let l = UILabel()
        l.textColor = SDK.Color.theme
        l.font = SDK.Font.arial(12)
        l.numberOfLines = 0
        l.text = SDK.R.string.usercenter_phoneBindingDes
        return l
    }()
    
    private lazy var contentView: UIView = {
        let v = UIView()
        v.layer.borderWidth = 1
        v.layer.borderColor = SDK.Color.themeUserCenterBorder.cgColor
        v.backgroundColor = .white
        v.layer.cornerRadius = 2
        v.layer.masksToBounds = true
        return v
    }()
    
    private lazy var mobileImageView: UIImageView = {
        let im = UIImageView()
        im.image = SDK.R.image.usercenter_phone
        return im
    }()
    
    private lazy var zongLable: UILabel = {
        let l = UILabel()
        l.textColor = SDK.Color.theme
        l.font = SDK.Font.arial(12)
        l.numberOfLines = 0
        l.text = "+86"
        return l
    }()
    
    private lazy var listBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setBackgroundImage(SDK.R.image.usercenter_phoneArrow, for: .normal)
        btn.setBackgroundImage(SDK.R.image.usercenter_phoneArrow_up, for: .selected)
        btn.addTarget(self, action: #selector(listBtnClicked(btn:)), for: .touchUpInside)
        btn.setEnlargeEdge(10)
        return btn
    }()
    
    private lazy var phoneTextField: UITextField = {[weak self] in
        let t = UITextField()
        let attS: NSMutableAttributedString = NSMutableAttributedString(string: SDK.R.string.usercenter_phoneBinding, attributes: [.foregroundColor: SDK.Color.themePlaceHolder,.font: SDK.Font.arial(12) as Any])
        t.attributedPlaceholder = attS
        t.textColor = SDK.Color.theme
        t.font = SDK.Font.arial(12)
        t.delegate = self
        return t
    }()
    
    private lazy var codeTextField: N_TextField = {
        let t = N_TextField(.zero, SDK.R.image.usercenter_passNum, SDK.R.string.usercenter_sendCode)
        t.placeHolderText = SDK.R.string.u_smsCode
        t.textColor = SDK.Color.theme
        t.limitLength = 6
        t.rightTitle = SDK.R.string.usercenter_sendCode
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
    
    private lazy var tableView: UITableView = {[weak self] in
        let t = UITableView()
        t.backgroundColor = .white
        t.separatorStyle = .none
        t.dataSource = self
        t.delegate = self
        t.rowHeight = 34 * K_Ratio
        t.tableFooterView = UIView()
        t.isHidden = true
        ///注册cell
        t.register(UITableViewCell.self, forCellReuseIdentifier: KPhoneZoneCellID)
        return t
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addChildView()
        addCallback()
        base_title = SDK.R.string.usercenter_phoneBinding
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutChildView()
    }
}

extension UserCenterPhoneBindingView {
    @objc private func listBtnClicked(btn: UIButton) {
        btn.isSelected = !btn.isSelected
        tableView.isHidden = !tableView.isHidden
    }
    
    @objc private func sumitBtnClicked() {
        if submitCallback != nil {
            submitCallback! (zongLable.text ?? "", phoneTextField.text ?? "", codeTextField.text ?? "")
        }
    }
}

extension UserCenterPhoneBindingView {
    private func addChildView() {
        addSubview(titleLable)
        addSubview(contentView)
        contentView.addSubview(mobileImageView)
        contentView.addSubview(zongLable)
        contentView.addSubview(listBtn)
        contentView.addSubview(phoneTextField)
        addSubview(codeTextField)
        addSubview(sumitBtn)
        addSubview(tableView)
    }
}

extension UserCenterPhoneBindingView {
    private func addCallback() {
        codeTextField.rightBtnCallback = {
            [unowned self] (btn: UIButton) in
            if self.smsBtnCallback != nil {
                self.smsBtnCallback! (btn, self.zongLable.text ?? "", self.phoneTextField.text ?? "")
            }
        }
    }
}

extension UserCenterPhoneBindingView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return zoneArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KPhoneZoneCellID, for: indexPath)
        cell.backgroundColor = .white
        cell.textLabel?.textColor = SDK.Color.theme
        cell.textLabel?.font = SDK.Font.arial(14)
        cell.selectionStyle = .none
        if zoneArr.count > 0 {
            cell.textLabel?.text = zoneArr[indexPath.row].stringValue
        }
        return cell
    }
}

extension UserCenterPhoneBindingView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if zoneArr.count > 0 {
            let selText = zoneArr[indexPath.row].stringValue
            if selText.count > 0 && selText.contains("+") {
                let arr = selText.components(separatedBy: "+")
                zongLable.text = "+\(arr[1])"
                tableView.isHidden = true
            }
        }
    }
}

extension UserCenterPhoneBindingView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == phoneTextField {
            contentView.layer.borderColor = SDK.Color.themeBlue.cgColor
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == phoneTextField {
            contentView.layer.borderColor = SDK.Color.themeTextfieldBorder.cgColor
        }
    }
}

extension UserCenterPhoneBindingView {
    private func layoutChildView() {
        titleLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(44 * K_Ratio)
            make.right.equalToSuperview().offset(-44 * K_Ratio)
            make.top.equalToSuperview().offset(61 * K_Ratio)
        }
        contentView.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLable)
            make.top.equalTo(titleLable.snp.bottom).offset(10 * K_Ratio)
            make.height.equalTo(40 * K_Ratio)
        }
        mobileImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10 * K_Ratio)
            make.centerY.equalToSuperview()
        }
        zongLable.snp.makeConstraints { (make) in
            make.left.equalTo(mobileImageView.snp.right).offset(10 * K_Ratio)
            make.centerY.equalToSuperview()
            make.width.equalTo(25)
        }
        listBtn.snp.makeConstraints { (make) in
            make.left.equalTo(zongLable.snp.right).offset(9 * K_Ratio)
            make.centerY.equalToSuperview()
        }
        phoneTextField.snp.makeConstraints { (make) in
            make.left.equalTo(listBtn.snp.right).offset(9 * K_Ratio)
            make.top.right.bottom.equalToSuperview()
        }
        codeTextField.snp.makeConstraints { (make) in
            make.top.equalTo(phoneTextField.snp.bottom).offset(10 * K_Ratio)
            make.left.right.equalTo(contentView)
            make.height.equalTo(40 * K_Ratio)
        }
        sumitBtn.snp.makeConstraints { (make) in
            make.top.equalTo(codeTextField.snp.bottom).offset(10 * K_Ratio)
            make.left.right.equalTo(contentView)
            make.height.equalTo(34 * K_Ratio)
        }
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(contentView)
            make.top.equalTo(contentView.snp.bottom)
            make.height.equalTo(150 * K_Ratio)
        }
    }
}
