//
//  GameViewController.swift
//  UserCenter_SwiftTest
//
//  Created by admin on 2021/2/7.
//  Copyright © 2021 os. All rights reserved.
//

import UIKit
import UserCenterSDK

fileprivate let screenWidth: CGFloat = UIScreen.main.bounds.size.width
fileprivate let screenHeight: CGFloat = UIScreen.main.bounds.size.height

class GameViewController: UIViewController {
    private lazy var loginBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("登录", for: .normal)
        btn.backgroundColor = .lightGray
        btn.addTarget(self, action: #selector(loginBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    private lazy var iapBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("内购", for: .normal)
        btn.backgroundColor = .lightGray
        btn.addTarget(self, action: #selector(iapBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    private lazy var eventBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("事件", for: .normal)
        btn.backgroundColor = .lightGray
        btn.addTarget(self, action: #selector(eventBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildView()
        view.backgroundColor = .green
        UserCenterSDK.share.loginSuccessCallback = {//登录成功
            (userName, userId, access_token) in
            print("userName: \(userName)")
            print("userId: \(userId)")
            print("access_token: \(access_token)")
        }
        
        UserCenterSDK.share.logoutSuccessCallback = {
            print("退出账号成功")
        }
    }
}

extension GameViewController {
    @objc private func loginBtnClicked() {
        UserCenterSDK.share.accountAutoLogin()
    }
    
    @objc private func iapBtnClicked() {
        self.present(IAPViewController(), animated: false, completion: nil)
    }
    
    @objc private func eventBtnClicked() {
        self.present(EventViewController(), animated: false, completion: nil)
    }
}

extension GameViewController {
    private func addChildView() {
        view.addSubview(loginBtn)
        loginBtn.frame = CGRect(x: screenWidth - 300, y: 100, width: 50, height: 30)
        
        view.addSubview(iapBtn)
        iapBtn.frame = CGRect(x: screenWidth - 300, y: 180, width: 50, height: 30)
        
        view.addSubview(eventBtn)
        eventBtn.frame = CGRect(x: screenWidth - 300, y: 260, width: 50, height: 30)
    }
}
