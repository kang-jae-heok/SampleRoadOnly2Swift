//
//  SettingView.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/11/17.
//

import Foundation
import Then
import UIKit
import SnapKit

class SettingView: UIView {
    
    let topView = SimpleTopView().then {
        $0.tit.text = "설정"
    }
    let settingTableView = UITableView()
    let settingModel = Setting()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviewFunc()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init error")
    }
    func addSubviewFunc() {
        [topView,settingTableView].forEach {
            self.addSubview($0)
        }
    }
    func setLayout() {
        backgroundColor = .white
        topView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(screenBounds2.width/4)
        }
        settingTableView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(50)
            $0.left.right.bottom.equalToSuperview()
        }
    }
}

