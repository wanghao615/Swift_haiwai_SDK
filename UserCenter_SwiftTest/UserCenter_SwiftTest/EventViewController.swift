//
//  EventViewController.swift
//  UserCenter_SwiftTest
//
//  Created by admin on 2021/2/22.
//  Copyright © 2021 os. All rights reserved.
//
fileprivate let EventCellID: String = "EventCellID"

import UIKit
import UserCenterSDK

class EventViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let t = UITableView()
        t.dataSource = self
        t.delegate = self
        t.tableFooterView = UIView()
        ///注册cell
        t.register(UITableViewCell.self, forCellReuseIdentifier: EventCellID)
        return t
    }()
    
    private lazy var backBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("返回", for: .normal)
        btn.backgroundColor = .lightGray
        btn.addTarget(self, action: #selector(backBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    private lazy var eventArr: [String] = {
           let arr: [String] = ["hotstart", "hotend", "stage1_04", "VIP5", "season_card_purchase", "big_month_card_purchase", "pay_1200", "闪退"]
           return arr
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildView()
    }
    
}

extension EventViewController {
    @objc private func backBtnClicked() {
        self.dismiss(animated: false, completion: nil)
    }
}

extension EventViewController {
    private func addChildView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        view.addSubview(backBtn)
        backBtn.frame = CGRect(x: 450, y: 250, width: 100, height: 50)
    }
}


extension EventViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventCellID, for: indexPath)
        cell.textLabel?.text = eventArr[indexPath.row]
        return cell
    }
}

extension EventViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if eventArr[indexPath.row] == "闪退" {
            let arr: [Int] = []
            print(arr[2])
        }else if eventArr[indexPath.row] == "VIP5" {
            UserCenterSDK.share.unite(event: eventArr[indexPath.row], roleName: "test", roleId: "1", serverId: "1", isOnce: true)
        }else {
            UserCenterSDK.share.unite(event: eventArr[indexPath.row], roleName: "test", roleId: "1", serverId: "1", isOnce: false)
        }
    }
}
