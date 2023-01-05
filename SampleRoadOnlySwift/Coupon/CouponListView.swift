//
//  CouponListView.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/11/10.
//

import Foundation
import UIKit

class CouponListView: UIView {
   
    let topView = SimpleTopView(frame: .zero).then{
        $0.tit.text = "쿠폰함"
    }
    lazy var countLbl = UILabel().then{
        $0.textColor = common2.pointColor()
        $0.font = common2.setFont(font: "bold", size: 15)
        $0.asColor(targetStringList: ["총","개"], color: common2.setColor(hex: "#b1b1b1"))
    }
    // 상단 버튼 뷰
    let topNaviView = UIView().then{
        $0.backgroundColor = .clear
    }
    lazy var myCouponBtn = UIButton().then{
        $0.setTitle("나의 쿠폰", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = common2.setFont(font: "bold", size: 15)
        $0.backgroundColor = common2.pointColor()
        $0.layer.borderWidth = 2
        $0.layer.borderColor = common2.pointColor().cgColor
    }
    lazy var getCouponBtn = UIButton().then {
        $0.setTitle("쿠폰 받기", for: .normal)
        $0.setTitleColor(common2.pointColor(), for: .normal)
        $0.titleLabel?.font = common2.setFont(font: "bold", size: 15)
        $0.backgroundColor = UIColor.white
        $0.layer.borderWidth = 2
        $0.layer.borderColor = common2.pointColor().cgColor
    }
    // 컬렉션 뷰
    let flowLayout = UICollectionViewFlowLayout().then{
        $0.scrollDirection = .vertical
    }
    lazy var couponCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout).then{
        $0.backgroundColor = .white
    }
    // 아무것도 없을때 뷰
    lazy var noneMyView = UIView().then{
        $0.backgroundColor = .white
        $0.isHidden = true
     
    }
    lazy var nonMyeLbl = UILabel().then {
        $0.text = "보유한 쿠폰이 없습니다"
        $0.textColor = common2.setColor(hex: "#b1b1b1")
        $0.font = common2.setFont(font: "bold", size: 16)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    lazy var noneGetCouponBtn = UIButton().then {
        $0.setTitle("쿠폰받으러 가기!", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = common2.setFont(font: "bold", size: 18)
        $0.backgroundColor = common2.pointColor()
        $0.layer.borderWidth = 1
        $0.layer.borderColor = common2.pointColor().cgColor
        $0.isHidden = true

    }
    lazy var noneGetCouponView = UIView().then{
        $0.backgroundColor = .white
        $0.isHidden = true
    }
    let noneGetCouponLbl = UILabel().then {
        $0.text = "받을 수 있는 쿠폰이 없습니다"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        couponCollectionView.showsHorizontalScrollIndicator = false
        couponCollectionView.register(CouponCollectionCell.self, forCellWithReuseIdentifier: "cell")
        addSubviewFunc()
        setLayout()
        
    }
    required init?(coder: NSCoder) {
        fatalError("initFail-CouponListView")
    }
    func addSubviewFunc(){
        [topView,countLbl,topNaviView,couponCollectionView,noneMyView,noneGetCouponView].forEach{
            self.addSubview($0)
        }
        [myCouponBtn,getCouponBtn].forEach{
            topNaviView.addSubview($0)
        }
        [nonMyeLbl,noneGetCouponLbl,noneGetCouponBtn].forEach{
            noneMyView.addSubview($0)
        }
        [noneGetCouponLbl].forEach{
            noneGetCouponView.addSubview($0)
        }
    }
    func setLayout(){
        topView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(screenBounds2.width/4)
        }
        topNaviView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(margin2)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(screenBounds2.height/20)
        }
        myCouponBtn.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview().offset(margin2)
            $0.right.equalTo(super.snp.centerX)
        }
        getCouponBtn.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.right.equalToSuperview().offset(-margin2)
            $0.left.equalTo(super.snp.centerX)
        }
        countLbl.snp.makeConstraints {
            $0.top.equalTo(getCouponBtn.snp.bottom).offset(margin2)
            $0.left.equalToSuperview().offset(margin2)
        }
        couponCollectionView.snp.makeConstraints {
            $0.top.equalTo(countLbl.snp.bottom).offset(margin2)
            $0.left.right.bottom.equalToSuperview()
        }
        noneMyView.snp.makeConstraints {
            $0.top.equalTo(countLbl.snp.bottom).offset(margin2)
            $0.left.right.bottom.equalToSuperview()
        }
        nonMyeLbl.snp.makeConstraints {
            $0.centerY.equalTo(super.snp.centerY)
            $0.centerX.equalToSuperview()
        }
        noneGetCouponLbl.snp.makeConstraints {
            $0.centerX.equalTo(super.snp.centerX)
            $0.centerY.equalTo(super.snp.centerY)
        }
        noneGetCouponView.snp.makeConstraints {
            $0.top.equalTo(countLbl.snp.bottom).offset(margin2)
            $0.left.right.bottom.equalToSuperview()
        }
        noneGetCouponBtn.snp.makeConstraints {
            $0.centerX.equalTo(super.snp.centerX)
            $0.centerY.equalTo(super.snp.centerY)
            $0.size.equalTo(CGSize(width: screenBounds2.width - margin2 * 4, height: 70))
        }
    }
  
}

