//
//  CouponListView.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/11/10.
//

import Foundation
import UIKit

class CouponListView: UIView {
    var myCouponInfoDicArr = [[String:Any]]()
    var getCouponInfoDicArr = [[String:Any]]()
    var checkCouponArr = [String]()
    let topView = SimpleTopView(frame: .zero).then{
        $0.tit.text = "쿠폰함"
    }
    lazy var countLbl = UILabel().then{
        $0.text = "총 \(myCouponInfoDicArr.count)개"
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
        $0.layer.borderWidth = 1
        $0.layer.borderColor = common2.pointColor().cgColor
        $0.addTarget(self, action: #selector(touchMyCouponBtn), for: .touchUpInside)
    }
    lazy var getCouponBtn = UIButton().then {
        $0.setTitle("쿠폰 받기", for: .normal)
        $0.setTitleColor(common2.pointColor(), for: .normal)
        $0.titleLabel?.font = common2.setFont(font: "bold", size: 15)
        $0.backgroundColor = UIColor.white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = common2.pointColor().cgColor
        $0.addTarget(self, action: #selector(touchGetCouponBtn), for: .touchUpInside)
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
        if myCouponInfoDicArr.count == 0 {
            $0.isHidden = false
        }else {
            $0.isHidden = true
        }
    }
    let nonMyeLbl = UILabel().then {
        $0.text = "흑... \n 현재 보유하신 쿠폰이 없습니다ㅜㅜ"
        $0.textColor = .black
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
        $0.addTarget(self, action: #selector(touchGetCouponBtn), for: .touchUpInside)
    }
    lazy var noneGetCouponView = UIView().then{
        $0.backgroundColor = .white
        $0.isHidden = true
    }
    let noneGetCouponLbl = UILabel().then {
        $0.text = "현재 받을 수 있는 쿠폰이 없습니다ㅜ.ㅜ \n 존버하다 보면 곧 올라올 거에요!"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        couponCollectionView.showsHorizontalScrollIndicator = false
        couponCollectionView.register(CouponCollectionCell.self, forCellWithReuseIdentifier: "cell")
        couponCollectionView.delegate = self
        couponCollectionView.dataSource = self
        couponCollectionView.reloadData()
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
            $0.height.equalTo(50)
        }
        myCouponBtn.snp.makeConstraints {
            $0.top.bottom.left.equalToSuperview()
            $0.right.equalTo(super.snp.centerX)
        }
        getCouponBtn.snp.makeConstraints {
            $0.top.bottom.right.equalToSuperview()
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
            $0.bottom.equalTo(noneGetCouponBtn.snp.top).offset(-5)
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
    @objc func touchMyCouponBtn() {
        if myCouponBtn.backgroundColor != common2.pointColor() {
            myCouponBtn.setTitleColor(.white, for: .normal)
            myCouponBtn.backgroundColor = common2.pointColor()
            getCouponBtn.setTitleColor(common2.pointColor(), for: .normal)
            getCouponBtn.backgroundColor = UIColor.white
            couponCollectionView.delegate = self
            couponCollectionView.dataSource = self
            couponCollectionView.reloadData()
            countLbl.text = "총 \(myCouponInfoDicArr.count)개"
            noneGetCouponView.isHidden = true
            if myCouponInfoDicArr.count == 0 {
                noneMyView.isHidden = false
            }else {
                noneMyView.isHidden = true
            }
        }
    }
    @objc func touchGetCouponBtn() {
        if getCouponBtn.backgroundColor != common2.pointColor() {
            getCouponBtn.setTitleColor(.white, for: .normal)
            getCouponBtn.backgroundColor = common2.pointColor()
            myCouponBtn.setTitleColor(common2.pointColor(), for: .normal)
            myCouponBtn.backgroundColor = UIColor.white
            couponCollectionView.delegate = self
            couponCollectionView.dataSource = self
            couponCollectionView.reloadData()
            countLbl.text = "총 \(getCouponInfoDicArr.count)개"
            noneMyView.isHidden = true
            if getCouponInfoDicArr.count == 0 {
                noneGetCouponView.isHidden = false
            }else {
                noneGetCouponView.isHidden = true
            }
        }
    }
}
extension CouponListView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenBounds2.width - margin2 * 2, height: 180)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if myCouponBtn.backgroundColor == common2.pointColor() {
            return myCouponInfoDicArr.count
        }else {
            return getCouponInfoDicArr.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if myCouponBtn.backgroundColor == common2.pointColor() {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CouponCollectionCell
        }else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CouponCollectionCell
        }
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 7
        cell.layer.borderColor = common2.lightGray().cgColor
        cell.clipsToBounds = true
     return cell
    
       
    }


}
