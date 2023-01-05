//
//  ReviewListTableViewCell.swift
//  SampleLoad
//
//  Created by notegg on 2022/11/23.
//

import UIKit
import SnapKit

class ReviewListTableViewCell: UITableViewCell {
    static let identifier = "ReviewListTableViewCell"
    var reviewInfo: Review?
    var reviewImageButtonPressed: (() -> Void) = {}
    var thumbBtnPressed: (() -> Void) = {}
    let margin: CGFloat = 26
    let common = CommonS()
    lazy var bestLabel: UILabel = {
        let label = UILabel()
        label.text = "BEST"
        label.font = common.setFont(font: "bold", size: 18)
        label.textAlignment = .center
        label.backgroundColor = common.pointColor()
        label.textColor = .white
        return label
    }()
    lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.font = common.setFont(font: "bold", size: 23)
        label.text = "한줄평"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var evaluationStarView: HCSStarRatingView = {
        let starView = HCSStarRatingView()
        starView.minimumValue = 0
        starView.maximumValue = 5
        starView.starBorderColor = .clear
        starView.allowsHalfStars = true
        starView.isUserInteractionEnabled = false
        starView.spacing = 1
        starView.emptyStarColor = common.gray()
        starView.tintColor = common.setColor(hex: "#ffbc00")
        
        starView.value = 0
        return starView
    }()
    lazy var thumbButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "thumb_btn"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(thumbButtonTapped), for: .touchUpInside)
        return button
    }()
    lazy var thumbCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = common.setFont(font: "bold", size: 15)
        label.textColor = common.lightGray()
        label.textAlignment = .center
        return label
    }()
    lazy var nickLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = common.setFont(font: "bold", size: 15)
        label.textColor = .darkGray
        return label
    }()
    lazy var separator: UILabel = {
        let label = UILabel()
        label.text = "|"
        label.font = common.setFont(font: "regular", size: 15)
        label.textColor = .darkGray
        return label
    }()
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2022.11.23"
        label.font = common.setFont(font: "regular", size: 15)
        label.textColor = .darkGray
        return label
    }()
    let reviewImageButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    lazy var reviewerInfoView: UIView = {
        let view = UIView()
        let skinTypeDescLabel: UILabel = {
            let label = UILabel()
            label.text = "피부 타입"
            label.font = common.setFont(font: "regular", size: 15)
            label.textColor = .darkGray
            return label
        }()
        let skinWorryDescLabel: UILabel = {
            let label = UILabel()
            label.text = "피부 고민"
            label.font = common.setFont(font: "regular", size: 15)
            label.textColor = .darkGray
            return label
        }()
        [
            skinTypeDescLabel, skinTypeValueLabel,
            skinWorryDescLabel, skinWorryValueLabel
        ].forEach {
            view.addSubview($0)
        }
        let skinTypeDescLabelIntrinsicW = skinTypeDescLabel.intrinsicContentSize.width
        skinTypeDescLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(skinTypeDescLabelIntrinsicW)
        }
        skinTypeValueLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.leading.equalTo(skinTypeDescLabel.snp.trailing).inset(-10)
        }
        skinWorryDescLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(skinTypeDescLabel)
            $0.top.equalTo(skinTypeDescLabel.snp.bottom).offset(10)
        }
        skinWorryValueLabel.snp.makeConstraints {
            $0.top.equalTo(skinWorryDescLabel.snp.top)
            $0.leading.equalTo(skinWorryDescLabel.snp.trailing).inset(-10)
            $0.trailing.bottom.equalToSuperview()
        }
        
        return view
    }()
    let reviewImageView: UIView = {
        let view = UIView()
        
        return view
    }()
    lazy var skinTypeValueLabel: UILabel = {
        let label = UILabel()
        label.text = "피부 타입 값"
        label.font = common.setFont(font: "bold", size: 15)
        label.textColor = .black
        return label
    }()
    lazy var skinWorryValueLabel: UILabel = {
        let label = UILabel()
        label.text = "피부 고민 값"
        label.font = common.setFont(font: "bold", size: 15)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    lazy var reviewView: UIView = {
        let view = UIView()
        let positiveLogo: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "good_btn")
            return imageView
        }()
        let negativeLogo: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "sad_btn")
            return imageView
        }()
        
        [
            positiveLogo, positiveReviewLabel,
            negativeLogo, negativeReviewLabel
        ].forEach {
            view.addSubview($0)
        }
        positiveLogo.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.height.equalTo(20)
        }
        positiveReviewLabel.snp.makeConstraints {
            $0.leading.equalTo(positiveLogo.snp.trailing).inset(-margin)
            $0.top.trailing.equalToSuperview()
        }
        negativeLogo.snp.makeConstraints {
            $0.top.equalTo(positiveReviewLabel.snp.bottom).offset(margin / 2)
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(20)
        }
        negativeReviewLabel.snp.makeConstraints {
            $0.top.equalTo(negativeLogo.snp.top)
            $0.leading.trailing.equalTo(positiveReviewLabel)
            $0.bottom.equalToSuperview()
        }
        
        return view
    }()
    lazy var positiveReviewLabel: UILabel = {
        let label = UILabel()
        label.font = common.setFont(font: "regular", size: 15)
        label.text = "positiveReviewLabel"
        label.numberOfLines = 0
        return label
    }()
    lazy var negativeReviewLabel: UILabel = {
        let label = UILabel()
        label.font = common.setFont(font: "regular", size: 15)
        label.text = "negativeReviewLabel"
        label.numberOfLines = 0
        return label
    }()
    lazy var writeCommentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "readmore_btn"), for: .normal)
        button.setTitle("  댓글 달기", for: .normal)
        button.setTitleColor(common.lightGray(), for: .normal)
        button.isHidden = true
        return button
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProperties() {
        guard let reviewInfo = reviewInfo else {
            return
        }
        print(reviewInfo)
        
        let reviewString = reviewInfo.body.components(separatedBy: "\nsr_divide_here\n")
        let comment = reviewInfo.title
        var positiveReview = ""
        var negativeReview = ""
        var reviewerSkinType = ""
        var reviewerSkinWorry = ""
        if reviewString.count == 4 {
            positiveReview = reviewString[0]
            negativeReview = reviewString[1]
            reviewerSkinType = reviewString[2]
            reviewerSkinWorry = reviewString[3]
        }
        let thumbCount = reviewInfo.helped.up.formatted
        thumbCountLabel.text = thumbCount
        commentLabel.text = comment
        if reviewInfo.customer != nil {
            nickLabel.text = reviewInfo.customer?.alias
        }else {
            nickLabel.text = "삭제된 고객"
        }
         
        evaluationStarView.value = CGFloat(reviewInfo.rating.raw)
        let format = DateFormatter()
        format.dateFormat = "yyyy.MM.dd"
        if let date = format.date(from: reviewInfo.createdAt.raw) {
            let st = format.string(from: date)
            dateLabel.text = st
        }
        skinTypeValueLabel.text = reviewerSkinType.replacingOccurrences(of: "피부", with: "")
        skinWorryValueLabel.text = reviewerSkinWorry
        positiveReviewLabel.text = positiveReview
        negativeReviewLabel.text = negativeReview
        setReviewImageView()
    }
    func setReviewImageView() {
        
        guard let reviewInfo = reviewInfo else {
            return
        }
        guard reviewInfo.images.count != 0 else {
            return
        }
        let imageUrls = reviewInfo.images.map {
            $0.url
        }
        reviewImageView.subviews.forEach {
            $0.removeFromSuperview()
        }
        var currentX: CGFloat = 0
        let space: CGFloat = 8
        let bounds = UIScreen.main.bounds
        let superViewW = bounds.width - (margin * 2)
        let buttonW = (superViewW - (8 * 2)) / 3
        if imageUrls.count <= 3 {
            (0...imageUrls.count - 1).forEach {
                let button = UIButton()
                if let imageData = try? Data(contentsOf: URL(string: imageUrls[$0])!) {
                    button.setImage(UIImage(data: imageData), for: .normal)
                }
                reviewImageView.addSubview(button)
                button.snp.makeConstraints {
                    $0.height.equalToSuperview()
                    $0.width.equalTo(buttonW)
                    $0.leading.equalToSuperview().inset(currentX)
                }
                button.addTarget(self, action: #selector(reviewImageButtonTapped(_:)), for: .touchUpInside)
                currentX += buttonW + space
            }
        } else {
            (0...2).forEach {
                let button = UIButton()
                if let imageData = try? Data(contentsOf: URL(string: imageUrls[$0])!) {
                    button.setImage(UIImage(data: imageData), for: .normal)
                }
                reviewImageView.addSubview(button)
                button.snp.makeConstraints {
                    $0.height.equalToSuperview()
                    $0.width.equalTo(buttonW)
                    $0.leading.equalToSuperview().inset(currentX)
                }
                currentX += buttonW + space
                if $0 == 2 {
                    let opacityView = UIView()
                    let controller = UIControl()
                    let label: UILabel = {
                        let label = UILabel()
                        label.text = "+\(imageUrls.count - 3)"
                        label.textColor = .white
                        label.font = common.setFont(font: "bold", size: 30)
                        return label
                    }()
                    opacityView.addSubview(label)
                    opacityView.addSubview(controller)
                    label.snp.makeConstraints {
                        $0.center.equalToSuperview()
                    }
                    opacityView.backgroundColor = .black
                    opacityView.alpha = 0.5
                    button.addSubview(opacityView)
                    opacityView.snp.makeConstraints {
                        $0.edges.equalToSuperview()
                    }
                    controller.snp.makeConstraints {
                        $0.edges.equalToSuperview()
                    }
                    controller.addTarget(self, action: #selector(reviewImageButtonTapped(_:)), for: .touchUpInside)
                }
                button.addTarget(self, action: #selector(reviewImageButtonTapped(_:)), for: .touchUpInside)
            }
        }
        
        
        reviewerInfoView.snp.remakeConstraints {
            $0.top.equalTo(reviewImageView.snp.bottom).offset(margin)
            $0.leading.trailing.equalToSuperview()
        }
        reviewImageView.snp.makeConstraints {
            $0.top.equalTo(nickLabel.snp.bottom).offset(margin)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(buttonW)
        }
    }
    @objc func reviewImageButtonTapped(_ sender: UIButton) {
        reviewImageButtonPressed()
    }
    @objc func thumbButtonTapped() {
        thumbBtnPressed()
    }
}

extension ReviewListTableViewCell {
    // MARK: - setLayout()
    
    private func setLayout() {
        let uiProperties = [
            bestLabel,
            commentLabel, thumbButton, thumbCountLabel, evaluationStarView,
            nickLabel, separator, dateLabel,
            reviewImageView,
            reviewerInfoView,
            reviewView,
            writeCommentButton
        ]

        uiProperties.forEach {
            contentView.addSubview($0)
        }
        
        bestLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(margin)
            $0.leading.equalToSuperview()
            $0.width.equalTo(54)
            $0.height.equalTo(24)
        }
        commentLabel.snp.makeConstraints {
            $0.top.equalTo(bestLabel.snp.bottom).offset(margin)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(thumbButton.snp.leading)
        }
        evaluationStarView.snp.makeConstraints {
            $0.top.equalTo(commentLabel.snp.bottom).offset(margin/2)
            $0.leading.equalToSuperview()
            $0.height.equalTo(20)
            $0.width.equalTo(86)
        }
        thumbButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.width.equalTo(30)
            $0.height.equalTo(45)
            $0.centerY.equalTo(commentLabel)
        }
        thumbCountLabel.snp.makeConstraints {
            $0.top.equalTo(thumbButton.snp.bottom)
            $0.leading.trailing.equalTo(thumbButton)
        }
        nickLabel.snp.makeConstraints {
            $0.top.equalTo(evaluationStarView.snp.bottom).offset(margin/2)
            $0.leading.equalToSuperview()
        }
        separator.snp.makeConstraints {
            $0.centerY.equalTo(nickLabel)
            $0.leading.equalTo(nickLabel.snp.trailing).inset(-5)
        }
        dateLabel.snp.makeConstraints {
            $0.centerY.equalTo(nickLabel)
            $0.leading.equalTo(separator.snp.trailing).inset(-5)
        }
        reviewerInfoView.snp.makeConstraints {
            $0.top.equalTo(nickLabel.snp.bottom).offset(margin)
            $0.leading.trailing.equalToSuperview()
        }
        reviewView.snp.makeConstraints {
            $0.top.equalTo(reviewerInfoView.snp.bottom).offset(margin)
            $0.leading.trailing.equalToSuperview()
        }
        writeCommentButton.snp.makeConstraints {
            $0.top.equalTo(reviewView.snp.bottom).offset(margin)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().inset(8)
        }
    }
}



