//
//  WriteReviewView.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/12/04.
//

import Foundation

class WriteReviewView: UIView {
    let topView = SimpleTopView().then {
        $0.tit.text = "리뷰쓰기"
    }
    lazy var registerBtn = UIButton().then {
        $0.setTitle("등록", for: .normal)
        $0.setTitleColor(common2.pointColor(), for: .normal)
        $0.titleLabel?.font = common2.setFont(font: "bold", size: 15)
    }
    let scrlView = UIScrollView()
    let productImgView = UIImageView().then {
        $0.backgroundColor = .red
    }
    lazy var productNameLbl = UILabel().then {
        $0.text = "갈락토미 엔자임 필링젤"
        $0.font = common2.setFont(font: "bold", size: 15)
    }
    lazy var firstLineView = UIView().then {
        $0.backgroundColor = common2.lightGray()
    }
    lazy var selectRateTit = UILabel().then {
        $0.text = "평점을 선택해주세요"
        $0.font = common2.setFont(font: "bold", size: 13)
    }
    lazy var ratingView = HCSStarRatingView().then {
        $0.backgroundColor = UIColor.clear
        $0.maximumValue = 5
        $0.minimumValue = 0
        $0.value = 4
        $0.tintColor = common2.setColor(hex: "#ffbc00")
        $0.starBorderColor = UIColor.clear
        $0.emptyStarColor = UIColor.lightGray
        $0.allowsHalfStars = false
    }
    
    lazy var secondLineView = UIView().then {
        $0.backgroundColor = common2.lightGray()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubviewFunc()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init-fail")
    }
    func addSubviewFunc() {
        [topView,scrlView].forEach {
            self.addSubview($0)
        }
        topView.addSubview(registerBtn)
        [productNameLbl,firstLineView,selectRateTit,ratingView,secondLineView].forEach {
            scrlView.addSubview($0)
        }
    }
    func setLayout() {
        topView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(screenBounds2.width/4)
        }
        registerBtn.snp.makeConstraints {
            $0.right.equalToSuperview().inset(margin2)
            $0.centerY.equalTo(topView.tit.snp.centerY)
        }
        scrlView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
        
    }
    
}
