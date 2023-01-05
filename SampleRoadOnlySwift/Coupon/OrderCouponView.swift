//
//  OrderCouponView.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/12/28.
//

import Foundation

class OrderCouponView: UIView {
    let topView = SimpleTopView().then {
        $0.tit.text = "적용 가능한 쿠폰"
    }
    let flowLayout = UICollectionViewFlowLayout().then{
        $0.scrollDirection = .vertical
    }
    lazy var couponCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout).then{
        $0.backgroundColor = .white
    }
    let noneView = NoneView().then {
        $0.tit.text = "적용 가능한 쿠폰이 없습니다."
        $0.isHidden = true
    }
    lazy var applyBtn = UIButton().then {
        $0.backgroundColor = common2.lightGray()
        $0.setTitle("0원 적용하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = common2.setFont(font: "bold", size: 18)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        couponCollectionView.showsHorizontalScrollIndicator = false
        couponCollectionView.register(OrderCouponCollectionCell.self, forCellWithReuseIdentifier: "cell")
        addSubviewFunc()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func addSubviewFunc() {
        [topView, couponCollectionView,applyBtn,noneView].forEach {
            self.addSubview($0)
        }
    }
    func setLayout() {
        topView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(screenBounds2.width / 4)
        }
        couponCollectionView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(50)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(applyBtn.snp.top)
        }
        applyBtn.snp.makeConstraints {
            $0.bottom.left.right.equalToSuperview()
            $0.height.equalTo(screenBounds2.width / 4)
        }
        noneView.snp.makeConstraints {
            $0.top.left.right.equalTo(couponCollectionView)
            $0.bottom.equalTo(applyBtn)
        }
    }
}
