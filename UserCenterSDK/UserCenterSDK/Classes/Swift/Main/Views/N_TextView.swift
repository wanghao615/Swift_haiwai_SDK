//
//  N_TextView.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/1.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class N_TextView: UITextView {
    var placeHolderLable: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        return l
    }()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setPlaceHolderLable()
        //delegate = self
        backgroundColor = UIColor.white
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = 2
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension N_TextView {
    private func setPlaceHolderLable() {
        addSubview(placeHolderLable)
        setValue(placeHolderLable, forKey: "_placeholderLabel")
    }
}

