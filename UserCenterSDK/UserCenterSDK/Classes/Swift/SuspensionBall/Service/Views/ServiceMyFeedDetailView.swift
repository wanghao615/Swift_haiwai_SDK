//
//  ServiceMyFeedDetailView.swift
//  KingNetSDK
//
//  Created by admin on 2020/12/7.
//  Copyright © 2020 niujf. All rights reserved.
//

import UIKit


fileprivate let KMyFeedDetailCellID = "KMyFeedDetailCellID"

class ServiceMyFeedDetailView: BaseView {
    var detailModel: MyFeedListModel? {
        didSet {
            guard let detailModel = detailModel else { return }
            titleContentLable.text = detailModel.title
            contentDetailLable.text = detailModel.content
            if detailModel.can_reply == 1 {//可以回复
                tableView.tableFooterView = footerView
                footerView.frame.size = CGSize(width: tableView.frame.size.width, height: 70 * K_Ratio)
                sumitBtn.snp.makeConstraints { (make) in
                    make.top.equalToSuperview().offset(10 * K_Ratio)
                    make.centerX.equalToSuperview()
                    make.width.equalTo(100 * K_Ratio)
                    make.bottom.equalToSuperview().offset(-26 * K_Ratio)
                }
            }else {
                tableView.tableFooterView = UIView()
            }
        }
    }
    
    var replyListModels: [FeedReplyListModel]? {
        didSet {
            guard let replyListModels = replyListModels else { return }
            if replyListModels.count > 0 {
                tableView.reloadData()
            }
        }
    }
    
    var additionalQCallback: (() -> ())?
    
    private lazy var titleLable: UILabel = {
        let l = UILabel()
        l.text = SDK.R.string.service_qTitle
        l.textColor = SDK.Color.themePlaceHolder
        l.font = SDK.Font.arial(14)
        l.textAlignment = .left
        return l
    }()
    
    private lazy var titleContentLable: UILabel = {
        let l = UILabel()
        l.textColor = SDK.Color.theme
        l.font = SDK.Font.arial(14)
        l.textAlignment = .left
        return l
    }()
    
    private lazy var contentLable: UILabel = {
        let l = UILabel()
        l.text = SDK.R.string.service_qContent
        l.textColor = SDK.Color.themePlaceHolder
        l.font = SDK.Font.arial(14)
        l.textAlignment = .left
        return l
    }()
    
    private lazy var contentDetailLable: UILabel = {
        let l = UILabel()
        l.textColor = SDK.Color.theme
        l.font = SDK.Font.arial(14)
        l.textAlignment = .left
        l.numberOfLines = 1
        return l
    }()
    
    private lazy var detailBtn: UIButton = {
        let bt = UIButton.init(type: .custom)
        bt.setBackgroundImage(SDK.R.image.service_arrowDown, for: .normal)
        bt.setBackgroundImage(SDK.R.image.service_arrowUp, for: .selected)
        bt.addTarget(self, action: #selector(detailBtnClicked(btn:)), for: .touchUpInside)
        return bt
    }()
    
    private lazy var lineView: UIView = {
        let l = UIView()
        l.backgroundColor = SDK.Color.theme
        l.alpha = 0.2
        return l
    }()
    
    private lazy var tableView: UITableView = {[weak self] in
        let t = UITableView()
        t.backgroundColor = UIColor.clear
        t.separatorStyle = .none
        t.dataSource = self
        t.delegate = self
        ///注册cell
        t.register(ServiceDetailReplayCell.self, forCellReuseIdentifier: KMyFeedDetailCellID)
        return t
    }()
    
    private lazy var footerView: UIView = {
        let v = UIView()
        return v
    }()
    
    private lazy var sumitBtn: UIButton = {
        let bt = UIButton.init(type: .custom)
        bt.setTitle(SDK.R.string.service_replyQ, for: .normal)
        bt.titleLabel?.font = SDK.Font.arial(13)
        bt.backgroundColor = SDK.Color.themeBlue
        bt.layer.cornerRadius = 2
        bt.layer.masksToBounds = true
        bt.addTarget(self, action: #selector(sumitBtnClicked), for: .touchUpInside)
        return bt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        base_title = SDK.R.string.service_feedBackDetail
        addChildView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutChildView()
    }
}

extension ServiceMyFeedDetailView {
    @objc private func detailBtnClicked(btn: UIButton) {
        btn.isSelected = !btn.isSelected
        btn.isSelected ? (contentDetailLable.numberOfLines = 0) : (contentDetailLable.numberOfLines = 1)
    }
    
    @objc private func sumitBtnClicked() {
        if additionalQCallback != nil {
            additionalQCallback!()
        }
    }
}

extension ServiceMyFeedDetailView {
    fileprivate func addChildView() {
        addSubview(titleLable)
        addSubview(titleContentLable)
        addSubview(contentLable)
        addSubview(contentDetailLable)
        addSubview(detailBtn)
        addSubview(lineView)
        addSubview(tableView)
        footerView.addSubview(sumitBtn)
    }
}

extension ServiceMyFeedDetailView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return replyListModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KMyFeedDetailCellID, for: indexPath) as! ServiceDetailReplayCell
        guard let replyListModels = replyListModels else { return cell }
        if replyListModels.count > 0 {
            cell.replyModel = replyListModels[indexPath.row]
        }
        return cell
    }
}

extension ServiceMyFeedDetailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let replyListModels = replyListModels else { return 58 * K_Ratio }
        return ServiceDetailReplayCell.cellHeight(replyListModels[indexPath.row])
    }
}

extension ServiceMyFeedDetailView {
    fileprivate func layoutChildView() {
        titleLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(24 * K_Ratio)
            make.top.equalToSuperview().offset(56 * K_Ratio)
        }
        titleContentLable.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-27 * K_Ratio)
            make.centerY.equalTo(titleLable)
            make.left.equalToSuperview().offset(66 * K_Ratio)
        }
        contentLable.snp.makeConstraints { (make) in
            make.left.equalTo(titleLable)
            make.top.equalTo(titleLable.snp.bottom).offset(9 * K_Ratio)
        }
        contentDetailLable.snp.makeConstraints { (make) in
            make.left.equalTo(titleContentLable)
            make.top.equalTo(contentLable)
            make.right.equalToSuperview().offset(-42 * K_Ratio)
        }
        detailBtn.snp.makeConstraints { (make) in
            make.top.equalTo(titleContentLable.snp.bottom)
            make.right.equalToSuperview().offset(-15 * K_Ratio)
            make.size.equalTo(CGSize(width: 24 * K_Ratio, height: 24 * K_Ratio))
        }
        lineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(4 * K_Ratio)
            make.right.equalToSuperview().offset(-4 * K_Ratio)
            make.top.equalTo(contentDetailLable.snp.bottom).offset(10 * K_Ratio)
            make.height.equalTo(1)
        }
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(lineView)
            make.top.equalTo(lineView.snp.bottom)
            make.bottom.equalToSuperview().offset(-10 * K_Ratio)
        }
    }
}

// MARK: -detailReplayCell

class ServiceDetailReplayCell: UITableViewCell {
    var replyModel: FeedReplyListModel? {
        didSet {
            if replyModel?.type == 1 {//客服回复
                titleLable.text = SDK.R.string.service_reply
                contentLable.textColor = SDK.Color.themeBlue
            }else {
                titleLable.text = SDK.R.string.service_playerReply
                contentLable.textColor = SDK.Color.theme
            }
            contentLable.text = replyModel?.content
        }
    }
    
    private lazy var titleLable: UILabel = {
           let l = UILabel()
           l.textColor = SDK.Color.themePlaceHolder
           l.font = SDK.Font.arial(13)
           l.textAlignment = .left
           return l
       }()
    
    private lazy var contentLable: UILabel = {
        let l = UILabel()
        l.textColor = SDK.Color.theme
        l.font = SDK.Font.arial(14)
        l.textAlignment = .left
        l.numberOfLines = 0
        return l
    }()
    
    private lazy var lineView: UIView = {
        let l = UIView()
        l.backgroundColor = SDK.Color.theme
        l.alpha = 0.2
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
    
   static func cellHeight(_ model: FeedReplyListModel) -> CGFloat {
        let widthMax = SDK.severSize.width - 40 * K_Ratio - 8
        let maxSize: CGSize = CGSize(width: widthMax, height: CGFloat(MAXFLOAT))
        let attributes = [NSAttributedString.Key.font:SDK.Font.arial(14)]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        if model.content.count > 0 {
            let rect: CGRect = model.content.boundingRect(with: maxSize, options: option, attributes: attributes as [NSAttributedString.Key : Any], context: nil)
            return CGFloat(rect.height) + 39 * K_Ratio
        }else {
            return 58 * K_Ratio
        }
    }
}

extension ServiceDetailReplayCell {
    private func addChildView() {
        contentView.addSubview(titleLable)
        contentView.addSubview(contentLable)
        contentView.addSubview(lineView)
    }
}

extension ServiceDetailReplayCell {
    private func layoutChildView() {
        titleLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20 * K_Ratio)
            make.top.equalToSuperview().offset(10 * K_Ratio)
        }
        contentLable.snp.makeConstraints { (make) in
            make.left.equalTo(titleLable)
            make.top.equalTo(titleLable.snp.bottom).offset(4 * K_Ratio)
            make.right.equalToSuperview().offset(-20 * K_Ratio)
            make.bottom.equalToSuperview().offset(-10 * K_Ratio)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
