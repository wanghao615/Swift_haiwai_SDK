//
//  ServiceCenterController.swift
//  KingNetSDK
//
//  Created by admin on 2020/11/26.
//  Copyright © 2020 niujf. All rights reserved.
//
import SnapKit

class ServiceCenterController: BaseViewController {
    private lazy var centerView: ServiceCenterView = {
        let centerView = ServiceCenterView()
        return centerView
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        addChildView()
        addCallBack()
        offsetMargin = 90
        loadRequest()
    }
    
    deinit {
        print("\(self) 释放了")
    }
}

extension ServiceCenterController {
    private func addChildView() {
        view.addSubview(centerView)
        centerView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(SDK.severSize)
        }
    }
}

extension ServiceCenterController {
    private func addCallBack() {
        centerView.base_exitBtnCallback = {
            UserCenterSDK.share.gotoGame()
        }
        
        centerView.submitCallback = { [unowned self]
            (dict) in
            let title = JSON(dict["title"] as Any).stringValue
            guard title.count > 0 else {
                self.view.makeToast(SDK.R.string.service_inputTitle)
                return
            }
            let content = JSON(dict["content"] as Any).stringValue
            guard content.count > 0  else {
                self.view.makeToast(SDK.R.string.service_inputContent)
                return
            }
            ///提交反馈
            ServiceViewModel.submitRequest(parameter: dict, finishCallBack: {
                self.view.makeToast(SDK.R.string.service_submitSuccess)
                GCDTool.delay(1) {
                    self.navigationController?.pushViewController(ServiceMyFeedController(), animated: false)
                    self.centerView.clearInputData()
                }
            }) { (failedString) in
                self.view.makeToast(failedString)
            }
        }
    
        ///跳转
        centerView.feedBtnCallback = { [unowned self] in
            self.navigationController?.pushViewController(ServiceMyFeedController(), animated: false)
        }
    }
}

extension ServiceCenterController {
    fileprivate func loadRequest() {
        ServiceViewModel.feedTypeRequest(finishCallBack: {
            (serviceTypeArr) in
            self.centerView.pickView.dataArr = serviceTypeArr
        }) {
            (failedString) in
            self.view.makeToast(failedString)
        }
    }
}
