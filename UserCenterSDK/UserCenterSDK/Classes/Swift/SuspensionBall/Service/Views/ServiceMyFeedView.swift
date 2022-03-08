//
//  ServiceMyFeedView.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/3.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit
import class OCModule.NRefreshAutoNormalFooter

fileprivate let KMyFeedCellID = "KMyFeedCellID"

class ServiceMyFeedView: BaseView {
    var listModels: [MyFeedListModel]? {
        didSet {
            guard let listModels = listModels else { return }
            if listModels.count > 0 {
                tableView.reloadData()
            }
        }
    }
    
    var moreListModels: [MyFeedListModel]? {
        didSet {
            guard let moreListModels = moreListModels else { return }
            if moreListModels.count > 0 {
                debugPrint("加载到更多的数据了")
                tableView.mj_footer.endRefreshing()
                listModels?.append(contentsOf: moreListModels)
                tableView.reloadData()
            }else {
                tableView.mj_footer.endRefreshingWithNoMoreData()
            }
        }
    }
    
    var loadMoreDataCallback: (() -> ())?
    var selectRowCallback: ((MyFeedListModel) -> ())?
    
    private lazy var topView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black
        v.alpha = 0.05
        return v
    }()
    
    private lazy var titleLable: UILabel = {
        let l = UILabel()
        l.text = SDK.R.string.service_myFeedTitle
        l.textColor = SDK.Color.theme
        l.font = SDK.Font.arial(13)
        l.textAlignment = .left
        return l
    }()
    
    private lazy var statusLable: UILabel = {
        let l = UILabel()
        l.text = SDK.R.string.service_myFeedStatus
        l.textColor = SDK.Color.theme
        l.font = SDK.Font.arial(13)
        l.textAlignment = .left
        return l
    }()
    
    private lazy var tableView: UITableView = {[weak self] in
        let t = UITableView()
        t.backgroundColor = UIColor.clear
        t.separatorColor = SDK.Color.themePlaceHolder
        t.dataSource = self
        t.delegate = self
        t.rowHeight = 53 * K_Ratio
        t.tableFooterView = UIView()
        ///注册cell
        t.register(myFeedCell.self, forCellReuseIdentifier: KMyFeedCellID)
        return t
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        base_title = SDK.R.string.service_checkMyFeed
        addChildView()
        freshListData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutChildView()
    }
}

extension ServiceMyFeedView {
    private func addChildView() {
        addSubview(topView)
        addSubview(titleLable)
        addSubview(statusLable)
        addSubview(tableView)
    }
}

extension ServiceMyFeedView {
    private func freshListData() {
        guard let listModels = listModels else { return }
        if listModels.count < 10 { return }
        tableView.mj_footer = NRefreshAutoNormalFooter {[unowned self] in
            if self.loadMoreDataCallback != nil {
                self.loadMoreDataCallback!()
            }
        }
    }
}
 
extension ServiceMyFeedView {
    private func layoutChildView() {
        topView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(4 * K_Ratio)
            make.right.equalToSuperview().offset(-4 * K_Ratio)
            make.height.equalTo(34 * K_Ratio)
            make.top.equalToSuperview().offset(45 * K_Ratio)
        }
        titleLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(24 * K_Ratio)
            make.centerY.equalTo(topView)
        }
        statusLable.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-24 * K_Ratio)
            make.centerY.equalTo(topView)
        }
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(topView)
            make.top.equalTo(topView.snp.bottom)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}

extension ServiceMyFeedView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KMyFeedCellID, for: indexPath) as! myFeedCell
        guard let listModels = listModels else { return cell}
        if listModels.count > 0 {
            cell.item = listModels[indexPath.row]
        }
        return cell
    }
}

extension ServiceMyFeedView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let listModels = listModels else { return }
        if listModels.count > 0 {
            if selectRowCallback != nil {
                selectRowCallback!(listModels[indexPath.row])
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
}


// MARK: - myFeedCell

class myFeedCell: UITableViewCell {
    var item: MyFeedListModel? {
        didSet {
            titleLable.text = item?.title
            timeLable.text = item?.created_at.n.date
            switch item?.status {
            case 0://待处理
                stateLable.text = SDK.R.string.service_myFeedProcessed
                stateLable.textColor = SDK.Color.theme
            case 1://已完成
                stateLable.text = SDK.R.string.service_myFeedProcessedSuccess
                stateLable.textColor = SDK.Color.themeBlue
            case 2://处理中
                stateLable.text = SDK.R.string.service_myFeedProcessing
                stateLable.textColor = SDK.Color.themeBlue
            default:
                stateLable.text = SDK.R.string.service_myFeedReplied
                stateLable.textColor = SDK.Color.themeBlue
            }
        }
    }
    
    private lazy var titleLable: UILabel = {
        let l = UILabel()
        l.text = "test"
        l.textColor = SDK.Color.theme
        l.font = SDK.Font.arial(13)
        l.textAlignment = .left
        return l
    }()
    
    private lazy var timeLable: UILabel = {
        let l = UILabel()
        l.text = "test"
        l.textColor = SDK.Color.themePlaceHolder
        l.font = SDK.Font.arial(11)
        l.textAlignment = .left
        return l
    }()
    
    private lazy var stateLable: UILabel = {
        let l = UILabel()
        l.text = "test"
        l.textColor = SDK.Color.theme
        l.font = SDK.Font.arial(14)
        l.textAlignment = .right
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        selectionStyle = .none
        addChildView()
        layoutChildView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension myFeedCell {
    private func addChildView() {
        contentView.addSubview(titleLable)
        contentView.addSubview(timeLable)
        contentView.addSubview(stateLable)
    }
}

extension myFeedCell {
    private func layoutChildView() {
        stateLable.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-14 * K_Ratio)
        }
        titleLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(24 * K_Ratio)
            make.right.equalTo(stateLable.snp.left).offset(-23 * K_Ratio)
            make.top.equalToSuperview().offset(10 * K_Ratio)
        }
        timeLable.snp.makeConstraints { (make) in
            make.left.equalTo(titleLable)
            make.top.equalTo(titleLable.snp.bottom).offset(5 * K_Ratio)
        }
    }
}
