//
//  ServiceCenterView.swift
//  KingNetSDK
//
//  Created by admin on 2020/11/26.
//  Copyright © 2020 niujf. All rights reserved.
//
import UIKit

class ServiceCenterView: BaseView {
    var feedBtnCallback: (() -> (Void))?
    var submitCallback: (([String: Any]) -> (Void))?
    var type: Int?
    
    lazy var pickView: PickView = {
        let p = PickView()
        p.isHidden = true
        return p
    }()
    
    private lazy var scrollview: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.contentSize = CGSize(width: SDK.severSize.width - 8 * K_Ratio, height: SDK.severSize.height + 160 * K_Ratio)
        scrollview.showsHorizontalScrollIndicator = false
        return scrollview
    }()
    
    private lazy var feedLable: UILabel = {
        let lable = UILabel()
        lable.text = SDK.R.string.service_sumit
        lable.textColor = SDK.Color.theme
        lable.font = SDK.Font.arial(16)
        lable.textAlignment = .left
        return lable
    }()
    
    private lazy var myFeedLable: UILabel = {
        let lable = UILabel()
        lable.text = SDK.R.string.service_checkMyFeed
        lable.textColor = SDK.Color.themeBlue
        lable.font = SDK.Font.arial(13)
        lable.textAlignment = .right
        return lable
    }()
    
    private lazy var myFeedBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(SDK.R.image.service_feedback_arrow, for: .normal)
        btn.addTarget(self, action: #selector(myFeedBtnClicked), for: .touchUpInside)
        btn.setEnlargeEdge(top: 20, bottom: 20, left: 100, right: 20)
        return btn
    }()
    
    private lazy var typeLable: UILabel = {
        let lable = UILabel()
        lable.attributedText = attributeS(SDK.R.string.service_type)
        lable.font = SDK.Font.arial(13)
        lable.textAlignment = .left
        return lable
    }()
    
    private lazy var selLable: UILabel = {
        let lable = UILabel()
        lable.font = SDK.Font.arial(12)
        lable.textColor = SDK.Color.theme
        lable.layer.borderWidth = 1
        lable.layer.borderColor = UIColor.white.cgColor
        lable.layer.cornerRadius = 2
        lable.layer.masksToBounds = true
        lable.backgroundColor = UIColor.white
        lable.text = "   \(SDK.R.string.service_aboutAccount)"
        lable.textAlignment = .left
        lable.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(showPickView))
        lable.addGestureRecognizer(tapGes)
        return lable
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let im = UIImageView()
        im.image = SDK.R.image.service_arrowDown
        return im
    }()
    
    private lazy var titleLable: UILabel = {
        let lable = UILabel()
        lable.attributedText = attributeS(SDK.R.string.service_qTitle)
        lable.font = SDK.Font.arial(13)
        lable.textAlignment = .left
        return lable
    }()
    
    private var titleTextField: N_TextField = {
        let t = N_TextField()
        t.placeHolderText = SDK.R.string.service_qTitleDes
        t.textColor = SDK.Color.theme
        t.limitLength = 30
        return t
    }()
    
    private lazy var contentLable: UILabel = {
        let lable = UILabel()
        lable.attributedText = attributeS(SDK.R.string.service_qContent)
        lable.font = SDK.Font.arial(13)
        lable.textAlignment = .left
        return lable
    }()
    
    private lazy var textView: N_TextView = {[weak self] in
        let t = N_TextView()
        t.delegate = self
        t.placeHolderLable.text = SDK.R.string.service_accountInfo
        t.placeHolderLable.textColor = SDK.Color.themePlaceHolder
        t.textColor = SDK.Color.theme
        t.font = SDK.Font.arial(12)
        t.placeHolderLable.font = SDK.Font.arial(12)
        return t
    }()
    
    private lazy var contactLable: UILabel = {
        let lable = UILabel()
        lable.text = SDK.R.string.service_contact
        lable.textColor = SDK.Color.themePlaceHolder
        lable.font = SDK.Font.arial(13)
        lable.textAlignment = .left
        return lable
    }()
    
    private lazy var contactTextField: N_TextField = {
        let t = N_TextField()
        t.placeHolderText = SDK.R.string.service_contactType
        t.autocorrectionType = UITextAutocorrectionType.no
        t.spellCheckingType = UITextSpellCheckingType.no
        t.limitLength = 50
        return t
    }()
    
    private lazy var sumitBtn: UIButton = {
        let bt = UIButton.init(type: .custom)
        bt.setTitle(SDK.R.string.u_sumit, for: .normal)
        bt.setTitleColor(UIColor.white, for: .normal)
        bt.titleLabel?.font = SDK.Font.arial(14)
        bt.setBackgroundImage(SDK.R.image.u_btnBack, for: .normal)
        bt.setBackgroundImage(SDK.R.image.u_btnBack_high, for: .selected)
        bt.addTarget(self, action: #selector(sumitBtnClicked), for: .touchUpInside)
        return bt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        base_backBtnIsHidden = true
        base_title = SDK.R.string.service_title
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

extension ServiceCenterView {
    func clearInputData() {
        titleTextField.text = ""
        textView.text = ""
        contactTextField.text = ""
    }
}

extension ServiceCenterView {
    @objc private func myFeedBtnClicked() {
        if feedBtnCallback != nil {
            feedBtnCallback!()
        }
    }
    
    @objc private func showPickView() {
        arrowImageView.image = SDK.R.image.service_arrowUp
        ///显示pickView
        UIView.animate(withDuration: 0.25) {
            self.pickView.isHidden = false
        }
    }
    
    @objc private func sumitBtnClicked() {
        if submitCallback != nil {
            submitCallback!(["title": titleTextField.text ?? "",
                             "content": textView.text ?? "",
                             "contact": contactTextField.text ?? "",
                             "type": JSON(self.type ?? "0").stringValue])
        }
    }
}

extension ServiceCenterView {
    fileprivate func addChildView() {
        addSubview(scrollview)
        scrollview.addSubview(feedLable)
        scrollview.addSubview(myFeedBtn)
        scrollview.addSubview(myFeedLable)
        scrollview.addSubview(typeLable)
        scrollview.addSubview(selLable)
        selLable.addSubview(arrowImageView)
        scrollview.addSubview(titleLable)
        scrollview.addSubview(titleTextField)
        scrollview.addSubview(contentLable)
        scrollview.addSubview(textView)
        scrollview.addSubview(contactLable)
        scrollview.addSubview(contactTextField)
        scrollview.addSubview(sumitBtn)
        
        let window = UIApplication.shared.keyWindow
        let rootView = window!.rootViewController!.view
        rootView!.addSubview(pickView)
    }
    
    fileprivate func attributeS(_ s: String) ->NSMutableAttributedString {
        let str: String = s + " ＊"
        let attS: NSMutableAttributedString = NSMutableAttributedString(string: str)
        let range = NSString(string: attS.string).range(of: s)
        attS.addAttributes([.foregroundColor:SDK.Color.themePlaceHolder],range: range)
        let c = NSString(string: attS.string).range(of: "＊")
        attS.addAttributes([.foregroundColor: UIColor.red],range: c)
        return attS
    }
}

extension ServiceCenterView {
    fileprivate func addCallback() {
        pickView.doneCallback = { [unowned self]
            ServiceTypeModel in
            if let nameStr = ServiceTypeModel?.name {
                self.selLable.text = "   " + nameStr
                self.type = ServiceTypeModel?.type
            }
            UIView.animate(withDuration: 0.25) {
                self.pickView.isHidden = true
            }
        }
        
        titleTextField.beginEditingCallback = { [unowned self] in
            self.pickView.isHidden = true
        }
    }
}

extension ServiceCenterView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        pickView.isHidden = true
        textView.layer.borderColor = SDK.Color.themeBlue.cgColor
        scrollview.setContentOffset(CGPoint(x: 0, y: 80), animated: false)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        guard let textRange = textView.markedTextRange else { return }
        guard let rangeText = textView.text(in: textRange) else { return }
        if rangeText.count > 300 || text.count > 300 {
            textView.text = (text as NSString).substring(with: (text as NSString).rangeOfComposedCharacterSequences(for: NSRange(location: 0, length: 300)))
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.layer.borderColor = UIColor.white.cgColor
        //scrollview.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }
}
 
extension ServiceCenterView {
    fileprivate func layoutChildView() {
        scrollview.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(4 * K_Ratio)
            make.right.equalToSuperview().offset(-4 * K_Ratio)
            make.top.equalToSuperview().offset(45 * K_Ratio)
            make.bottom.equalToSuperview().offset(-10 * K_Ratio)
        }
        feedLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(40 * K_Ratio)
            make.top.equalToSuperview().offset(20 * K_Ratio)
        }
        myFeedBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-40 * K_Ratio)
            make.centerY.equalTo(feedLable)
            make.size.equalTo(CGSize(width: 18 * K_Ratio, height: 18 * K_Ratio))
        }
        myFeedLable.snp.makeConstraints { (make) in
            make.centerY.equalTo(feedLable)
            make.right.equalTo(myFeedBtn.snp.left).offset(0)
        }
        typeLable.snp.makeConstraints { (make) in
            make.left.equalTo(feedLable)
            make.top.equalTo(feedLable.snp.bottom).offset(20 * K_Ratio)
        }
        selLable.snp.makeConstraints { (make) in
            make.top.equalTo(typeLable.snp.bottom).offset(4 * K_Ratio)
            make.left.equalTo(typeLable)
            make.height.equalTo(40 * K_Ratio)
            make.right.equalTo(self).offset(-40 * K_Ratio)
        }
        arrowImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10 * K_Ratio)
        }
        titleLable.snp.makeConstraints { (make) in
            make.left.equalTo(typeLable)
            make.top.equalTo(selLable.snp.bottom).offset(10 * K_Ratio)
        }
        titleTextField.snp.makeConstraints { (make) in
            make.left.right.equalTo(selLable)
            make.top.equalTo(titleLable.snp.bottom).offset(4 * K_Ratio)
            make.height.equalTo(40 * K_Ratio)
        }
        contentLable.snp.makeConstraints { (make) in
            make.left.equalTo(typeLable)
            make.top.equalTo(titleTextField.snp.bottom).offset(10 * K_Ratio)
        }
        textView.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleTextField)
            make.top.equalTo(contentLable.snp.bottom).offset(4 * K_Ratio)
            make.height.equalTo(80 * K_Ratio)
        }
        contactLable.snp.makeConstraints { (make) in
            make.left.equalTo(contentLable)
            make.top.equalTo(textView.snp.bottom).offset(10 * K_Ratio)
        }
        contactTextField.snp.makeConstraints { (make) in
            make.left.right.equalTo(textView)
            make.top.equalTo(contactLable.snp.bottom).offset(4 * K_Ratio)
            make.height.equalTo(40 * K_Ratio)
        }
        sumitBtn.snp.makeConstraints { (make) in
            make.left.right.equalTo(contactTextField)
            make.top.equalTo(contactTextField.snp.bottom).offset(10 * K_Ratio)
            make.height.equalTo(40 * K_Ratio)
        }
        pickView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(194)
        }
    }
}
