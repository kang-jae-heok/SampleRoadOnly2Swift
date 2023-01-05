//
//  ReviewListView.swift
//  SampleLoad
//
//  Created by notegg on 2022/11/23.
//

import UIKit
import SnapKit

class ReviewListView: UIView {
    
    let reviewListTableView: UITableView = {
        let tableview = UITableView()
        tableview.bounces = false
        return tableview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ReviewListView {
    // MARK: - setLayout()
    
    private func setLayout() {
        let uiProperties = [reviewListTableView]

        uiProperties.forEach {
            addSubview($0)
        }
        reviewListTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

