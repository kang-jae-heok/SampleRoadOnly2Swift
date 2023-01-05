//
//  LikeEventView.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/11/29.
//

import Foundation
class LikeEventView: UIView {
    let topView = SimpleTopView().then {
        $0.tit.text = "찜한 이벤트"
    }
    let likeEventTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubviewFunc()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init-fail")
    }
    func addSubviewFunc(){
        [topView,likeEventTableView].forEach {
            self.addSubview($0)
        }
    }
    func setLayout(){
        topView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(screenBounds2.width/4)
        }
        likeEventTableView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(20)
            $0.left.right.bottom.equalToSuperview().inset(margin2)
        }
    }
}
