//
//  IAPViewController.swift
//  UserCenter_SwiftTest
//
//  Created by admin on 2021/2/20.
//  Copyright © 2021 os. All rights reserved.
//

fileprivate let TestCellID: String = "TestCellID"

import UIKit
import UserCenterSDK

class IAPViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let t = UITableView()
        t.dataSource = self
        t.delegate = self
        t.tableFooterView = UIView()
        ///注册cell
        t.register(UITableViewCell.self, forCellReuseIdentifier: TestCellID)
        return t
    }()
    
    private lazy var backBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("返回", for: .normal)
        btn.backgroundColor = .lightGray
        btn.addTarget(self, action: #selector(backBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    private lazy var iapArr: [String] = {
        let arr: [String] = ["gifta1200", "1200", "gifta2500", "gifta5900", "5900", "gifta12000", "12000", "gifta19000", "gifta25000", "25000", "gifta37000", "gifta65000", "65000"]
        var productArr: [String] = []
        for i in 0 ..< arr.count {
            var productId = "com.overseasgm.testnum." + arr[i]
            productArr.append(productId)
        }
        return productArr
    }()
    
    private lazy var priceDict: [String: String] = {
        var dict: [String: String] = [:]
        let priceArr = ["1200", "1200", "2500", "5900","5900", "12000", "12000","19000", "25000", "25000", "37000", "65000", "65000"]
        for i in 0 ..< priceArr.count {
            dict[iapArr[i]] = priceArr[i]
        }
        return dict
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildView()
    }
    
    @objc private func backBtnClicked() {
        self.dismiss(animated: false, completion: nil)
    }
}

extension IAPViewController {
    private func addChildView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        view.addSubview(backBtn)
        backBtn.frame = CGRect(x: 450, y: 250, width: 100, height: 50)
    }
}

extension IAPViewController {
    private func pay(productId: String, price: String) {
        let dict = ["orderId": String(format: "%ld", Int(Date().timeIntervalSince1970)),
                    "userId": "13229328200372159",
                    "userName": "허깨비벤드이",
                    "serverId": "1",
                    "serverName": "test",
                    "roleId": "1234",
                    "productId": productId,
                    "productName": "45 다이아 선물",
                    "price": price,
                    "app_extra1": "1|471012|E8DD5418-0265-4D4F-8195-072281A1ABA7|iPhone8,2",
                    "app_extra2": "0|CN_1.0.1_10010_201907191604_12.3.1_8_sc_ko",
                    "callback_url": "http://myip.ipip.net"]
        UserCenterSDK.share.IAPStatus(dict: dict) { (status) in
            if status == "0" {
                print("内购完成")
            }else {
                print("内购失败")
            }
        }
    }
}

extension IAPViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iapArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TestCellID, for: indexPath)
        cell.textLabel?.text = iapArr[indexPath.row]
        return cell
    }
}

extension IAPViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pay(productId: iapArr[indexPath.row], price: priceDict[iapArr[indexPath.row]]!)
    }
}
