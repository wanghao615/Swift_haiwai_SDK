//
//  BaseNavgationViewController.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/25.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit

class BaseNavgationViewController: UINavigationController {

    override public func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    override public func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension BaseNavgationViewController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        setNavigationBarHidden(true, animated: true)
    }
}

