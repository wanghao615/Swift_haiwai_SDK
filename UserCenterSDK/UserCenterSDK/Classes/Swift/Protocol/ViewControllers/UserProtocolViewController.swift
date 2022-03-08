//
//  UserProtocolViewController.swift
//  KingNetSDK
//
//  Created by admin on 2021/1/6.
//  Copyright © 2021 niujf. All rights reserved.
//

import UIKit

class UserProtocolViewController: UIViewController {
    var confirmCallback: (() -> ())?

    private lazy var userProtocolView: UserProtocolView = {
        let userProtocolView = UserProtocolView()
        return userProtocolView
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        addChildView()
        addCallback()
    }

    deinit {
        print("\(self) 释放了")
    }
  
    
    
}

extension UserProtocolViewController {
    private func addChildView() {
        view.addSubview(userProtocolView)
        userProtocolView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(SDK.size)
        }
    }
}

extension UserProtocolViewController {
    private func addCallback() {
        userProtocolView.callback = { [unowned self] 
           (flag: Int) in
            switch flag {
            case 0://游戏协议
                let detailVC = UserPtotocolDetailViewController()
                detailVC.title = SDK.R.string.userProtocol_game
                detailVC.content = SDKTool.user_protocol
                self.navigationController?.pushViewController(detailVC, animated: false)
            case 1://用户协议
                let detailVC = UserPtotocolDetailViewController()
                detailVC.title = SDK.R.string.userProtocol_user
                detailVC.content = SDKTool.user_privacy_protocol
                self.navigationController?.pushViewController(detailVC, animated: false)
            case 2://取消
                SDKTool.IsProtocolAlert = false
                UserCenterSDK.share.signoutSdk()
            case 3://remind
                self.view.makeToast(SDK.R.string.userProtocol_remind)
            case 4://确定
                SDKTool.IsProtocolAlert = true
                if self.confirmCallback != nil { self.confirmCallback! () }
            default:
                break
            }
        }
    }
}


