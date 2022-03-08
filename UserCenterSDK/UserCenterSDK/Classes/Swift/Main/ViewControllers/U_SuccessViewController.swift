//
//  UserCenterSuccessViewController.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/23.
//  Copyright © 2020 niujf. All rights reserved.
//

// TODO: 后期组件化优化，目前跟其他模块有耦合

import UIKit

enum successType: Int {
    case loginModule
    case usercenterModule, bindingEmailModule, accountUpgradeModule
}

class U_SuccessViewController: UIViewController {
    
    var topTitle: String? {
        didSet {
            successView.topTitle = topTitle
        }
    }
    
    var titleS: String? {
        didSet {
            successView.title = titleS
        }
    }
    
    var type: successType?

    private lazy var successView: U_SuccessView = {
        let successView = U_SuccessView()
        successView.topTitle = SDK.R.string.usercenter_modifyPass
        successView.title = SDK.R.string.usercenter_updatePassSuccess
        return successView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildView()
        addCallBack()
    }
}

extension U_SuccessViewController {
    private func addChildView() {
        view.addSubview(successView)
        successView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(SDK.alertSelSize)
        }
    }
}

extension U_SuccessViewController {
    private func addCallBack() {
        successView.successBtnCallback = { [unowned self] in
            if self.type == .loginModule {
               UserCenterSDK.share.signoutSdk()
            }else {
               UserCenterSDK.share.gotoGame()
            }
        }
    }
}
