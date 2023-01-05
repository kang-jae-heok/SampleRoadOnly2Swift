//
//  AllReviewListView.swift
//  SampleLoad
//
//  Created by notegg on 2022/11/23.
//

import UIKit
import SnapKit

class AllReviewListView: UIView {
    let common = CommonS()
    
    // MARK: -topView
    lazy var topView: UIView = {
        let view = UIView()
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "제품 리뷰"
            label.font = common.setFont(font: "bold", size: 17)
            label.textAlignment = .center
            label.textColor = common.pointColor()
            return label
        }()
        [backButton, titleLabel, buyButton].forEach {
            view.addSubview($0)
        }
        backButton.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.leading.equalToSuperview().inset(26)
            $0.bottom.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(backButton.snp.centerY)
        }
        buyButton.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.centerY.equalTo(backButton)
            $0.trailing.equalToSuperview().inset(26)
        }
        return view
    }()
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back_btn"), for: .normal)
        button.contentHorizontalAlignment = .leading
        return button
    }()
    let buyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "buy_btn"), for: .normal)
        button.contentHorizontalAlignment = .trailing
        button.isHidden = true
        return button
    }()
    
    // MARK: -reviewListTableView
    lazy var reviewListTableView: UITableView = {
        let tableview = UITableView()
        tableview.bounces = false
        tableview.separatorStyle = .singleLine
        tableview.separatorColor = common.gray()
        tableview.separatorInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableview.showsVerticalScrollIndicator = false
        return tableview
    }()
    
    // MARK: -floatingButtons
    let upButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "up_btn"), for: .normal)
        button.backgroundColor = .white
        return button
    }()
    lazy var writeReviewButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "write_btn"), for: .normal)
        button.backgroundColor = common.pointColor()
        return button
    }()
//    $0.text = "선택된 제품이 없습니다"
//    $0.textColor = common2.setColor(hex: "#b1b1b1")
//    $0.font = common2.setFont(font: "bold", size: 16)
    lazy var noneReviewLabel: UILabel = {
        let label = UILabel()
        label.text = "리뷰가 없습니다"
        label.textColor = common2.setColor(hex: "#b1b1b1")
        label.font = common2.setFont(font: "bold", size: 16)
        return label
    }()
    lazy var noneReviewView: UIView = {
        let view = UIView()
        view.addSubview(noneReviewLabel)
        noneReviewLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        return view
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AllReviewListView {
    private func setLayout() {
        backgroundColor = .white
        let uiProperties = [topView, reviewListTableView,  noneReviewView, upButton, writeReviewButton]

        uiProperties.forEach {
            addSubview($0)
        }
        let bounds = UIScreen.main.bounds
        topView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(bounds.width / 4)
        }
        reviewListTableView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(26)
            $0.bottom.equalToSuperview()
        }
        upButton.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.trailing.equalToSuperview().inset(26)
            $0.bottom.equalTo(writeReviewButton.snp.top).inset(-20)
        }
        noneReviewView.snp.makeConstraints {
            $0.edges.equalTo(reviewListTableView)
        }
        upButton.clipsToBounds = true
        upButton.layer.cornerRadius = 20
        writeReviewButton.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.trailing.equalToSuperview().inset(26)
            $0.bottom.equalToSuperview().inset(40)
        }
        writeReviewButton.clipsToBounds = true
        writeReviewButton.layer.cornerRadius = 20
    }
}
