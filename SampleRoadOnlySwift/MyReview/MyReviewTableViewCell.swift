//
//  MyReviewTableViewCell.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/12/01.
//

import UIKit

class MyReviewTableViewCell: UITableViewCell {
    static let cellId = "MyReviewTableViewCellId"
    
    lazy var topLineView = UIView().then {
        $0.backgroundColor = common2.lightGray()
    }
    lazy var tit = UILabel().then {
        $0.text = "테스트"
        $0.font = common2.setFont(font: "bold", size: 15)
    }
    lazy var bottomLineView = UIView().then {
        $0.backgroundColor = common2.lightGray()
    }
    var ratingView = HCSStarRatingView().then {
        $0.backgroundColor = UIColor.clear
        $0.maximumValue = 5
        $0.minimumValue = 0
        $0.value = 5
        $0.tintColor = Common.color(withHexString: "#ffbc00")
        $0.starBorderColor = UIColor.clear
        $0.emptyStarColor = UIColor.lightGray
        $0.allowsHalfStars = false
        $0.contentMode = .center
    }
    lazy var dateLbl = UILabel().then {
        $0.font = common2.setFont(font: "regular", size: 10)
    }
    let goodImgView = UIImageView().then {
        $0.image = UIImage(named: "good_btn")
        $0.contentMode = .center
    }
    lazy var goodContent = UILabel().then {
        $0.text = "리뷰 좋았던 점 예시입니다"
        $0.numberOfLines = 0
        $0.font = common2.setFont(font: "regular", size: 12)
        $0.textColor = common2.gray()
    }
    let badImgView = UIImageView().then {
        $0.image = UIImage(named: "bad_btn")
        $0.contentMode = .center
    }
    lazy var badContent = UILabel().then {
        $0.text = "리뷰 안좋았던 점 예시입니다"
        $0.font = common2.setFont(font: "regular", size: 12)
        $0.numberOfLines = 0
        $0.textColor = common2.gray()
    }
    let commentImgView = UIButton().then {
        $0.setImage(UIImage(named: "readmore_btn"), for: .normal)
        $0.contentMode = .center
    }
    lazy var commentTextBtn = UIButton().then {
        $0.setTitle("댓글 달기", for: .normal)
        $0.setTitleColor(common2.gray(), for: .normal)
        $0.titleLabel?.font = common2.setFont(font: "bold", size: 12)
        $0.isHidden = true
    }
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviewFunc()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addSubviewFunc(){
        [topLineView,tit,bottomLineView,ratingView,dateLbl,goodImgView,goodContent,badImgView,badContent,commentImgView,commentTextBtn].forEach {
            self.addSubview($0)
        }
    }
    func setLayout(){
        topLineView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(2)
        }
        tit.snp.makeConstraints {
            $0.left.equalToSuperview().inset(margin2)
            $0.top.equalTo(topLineView.snp.bottom).offset(margin2)
        }
        bottomLineView.snp.makeConstraints {
            $0.top.equalTo(tit.snp.bottom).offset(margin2)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(2)
        }
        ratingView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(margin2)
            $0.top.equalTo(bottomLineView.snp.bottom).offset(margin2)
            $0.size.equalTo(CGSize(width: 100, height: 20))
        }
        dateLbl.snp.makeConstraints {
            $0.left.equalTo(ratingView.snp.right).offset(5)
            $0.centerY.equalTo(ratingView)
        }
        goodImgView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(margin2)
            $0.top.equalTo(ratingView.snp.bottom).offset(margin2)
        }
        goodContent.snp.makeConstraints {
            $0.left.equalTo(goodImgView.snp.right).offset(5)
            $0.top.equalTo(goodImgView.snp.centerY).offset(-goodContent.font.pointSize/2)
            $0.width.equalTo(screenBounds2.width - 60)
        }
        badImgView.snp.makeConstraints {
            $0.top.equalTo(goodContent.snp.bottom).offset(margin2)
            $0.left.equalToSuperview().offset(margin2)
        }
        badContent.snp.makeConstraints {
            $0.left.equalTo(badImgView.snp.right).offset(5)
            $0.top.equalTo(badImgView.snp.centerY).offset(-badContent.font.pointSize/2)
            $0.width.equalTo(screenBounds2.width - 60)
           
        }
        commentImgView.snp.makeConstraints {
            $0.top.equalTo(badContent.snp.bottom).offset(margin2)
            $0.left.equalToSuperview().offset(margin2)
        }
        commentTextBtn.snp.makeConstraints {
            $0.left.equalTo(commentImgView.snp.right).offset(5)
            $0.centerY.equalTo(commentImgView)
            $0.bottom.equalToSuperview().inset(margin2)
        }
    }
}
