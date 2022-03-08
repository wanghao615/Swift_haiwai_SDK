//
//  KN_TextField.swift
//  KingNetSDK
//
//  Created by admin on 2020/11/30.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class N_TextField: UITextField {
    var image: UIImage?
    var limitLength: Int?
    var rightImage: UIImage?
    var rightSelImage: UIImage?
    var rightBtnCallback: ((UIButton) -> ())?
    var rightTitle: String?
    var beginEditingCallback: (() -> ())?
    
    var placeHolderText: String? {
        didSet {
           if let placeHolder = placeHolderText {
            let attS: NSMutableAttributedString = NSMutableAttributedString(string: placeHolder, attributes: [.foregroundColor: SDK.Color.themePlaceHolder,.font: SDK.Font.arial(12) as Any])
                attributedPlaceholder = attS
            }
        }
    }
    
    private lazy var leftSpaceView: UIView = {
        let v = UIView()
        v.frame.size = CGSize(width: 10, height: 30)
        return v
    }()
    
    private lazy var rightBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("  ", for: .normal)
        btn.setTitleColor(SDK.Color.theme, for: .normal)
        btn.titleLabel?.font = SDK.Font.arial(12)
        btn.addTarget(self, action: #selector(rightBtnClicked(btn:)), for: .touchUpInside)
        btn.setEnlargeEdge(top: 10, bottom: 10, left: 20, right: 10)
        return btn
    }()

    convenience init(_ frame: CGRect, _ image: UIImage?, _ rightImage: UIImage?, _ rightSelImage: UIImage?) {
        self.init(frame: frame)
        if let leftImage = image {
            self.image = leftImage
            leftView()
        }
        if let rightImage = rightImage {
            self.rightImage = rightImage
            self.rightSelImage = rightSelImage
            rightView()
        }
    }
    
    convenience init(_ frame: CGRect, _ image: UIImage?, _ rightTitle: String?) {
        self.init(frame: frame)
        if let leftImage = image {
            self.image = leftImage
            leftView()
        }
        if let rightTitle = rightTitle {
            self.rightTitle = rightTitle
            rightView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        leftSpace()
        delegate = self
        backgroundColor = .white
        font = SDK.Font.arial(12)
        textColor = SDK.Color.theme
        layer.borderWidth = 1
        layer.borderColor = SDK.Color.themeTextfieldBorder.cgColor
        layer.cornerRadius = 2
        layer.masksToBounds = true
        addTarget(self, action: #selector(textFieldDidChange(textField:)), for: Event.editingChanged)
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension N_TextField {
    @objc private func textFieldDidChange(textField: UITextField) {
        guard let text = textField.text else { return }
        let selRange = textField.markedTextRange
        let position: UITextPosition? = textField.position(from: selRange?.start ?? UITextPosition(), offset: 0)
        if (position == nil || selRange == nil) {
            guard let limitLength = limitLength else { return }
            if text.count > limitLength {
                let rangeIndex = (text as NSString).rangeOfComposedCharacterSequence(at: limitLength)
                if rangeIndex.length == 1 {
                    textField.text = (text as NSString).substring(to: limitLength)
                }else {
                    let toRange: NSRange = (text as NSString).rangeOfComposedCharacterSequences(for: NSRange(location: 0, length: limitLength))
                    textField.text = (text as NSString).substring(with: toRange)
                }
            }
        }
    }
    
    @objc func rightBtnClicked(btn: UIButton) {
        if btn.currentImage != nil {
            isSecureTextEntry = !isSecureTextEntry
            btn.isSelected = !btn.isSelected
        }else {
            if rightBtnCallback != nil { rightBtnCallback! (btn) }
        }
    }
}

extension N_TextField {
    private func leftView() {
        let width = image?.size.width ?? 18 * K_Ratio
        let leftView = UIView()
        leftView.frame.size = CGSize(width: (width + 18 * K_Ratio), height: self.height)
        let im = UIImageView()
        leftView.addSubview(im)
        let y: CGFloat = (self.height - 18 * K_Ratio) / 2
        im.image = image
        im.frame = CGRect(x: 10 * K_Ratio, y: y, width: width, height: width);
        self.leftView = leftView
        leftViewMode = ViewMode.always
    }
    
    private func rightView() {
        if rightImage != nil {
            rightBtn.setImage(rightImage, for: .normal)
            rightBtn.setImage(rightSelImage, for: .selected)
            rightBtn.frame.size = CGSize(width: 28 * K_Ratio, height: 18 * K_Ratio)
        }
        if rightTitle != nil {
            rightBtn.setTitle(rightTitle, for: .normal)
            rightBtn.frame.size = CGSize(width: 70 * K_Ratio, height: 18 * K_Ratio)
        }
        rightView = rightBtn
        rightViewMode = ViewMode.always
    }
    
    private func leftSpace() {
        leftView = leftSpaceView
        leftViewMode = ViewMode.always
    }
}

extension N_TextField: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if beginEditingCallback != nil {
            beginEditingCallback!()
        }
        textField.layer.borderColor = SDK.Color.themeBlue.cgColor
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = SDK.Color.themeTextfieldBorder.cgColor
    }
}
