//
//  CouponCollectionCell.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/11/10.
//

import Foundation
class CouponCollectionCell: UICollectionViewCell {
    static let cellId = "CouponTableCellId"
    lazy var firstLbl = UILabel().then{
        $0.text = "테스트"
        $0.font = common2.setFont(font: "bold", size: 18)
    }
    lazy var secondLbl = UILabel().then{
        $0.text = "테스트"
        $0.font = common2.setFont(font: "bold", size: 15)
        $0.textColor = common2.lightGray()
    }
    lazy var thirdLbl = UILabel().then{
        $0.text = "테스트"
        $0.font = common2.setFont(font: "bold", size: 13)
        $0.textColor = common2.lightGray()
    }
    lazy var fourthLbl = UILabel().then{
        $0.text = "테스트"
        $0.font = common2.setFont(font: "bold", size: 13)
        $0.textColor = common2.lightGray()
    }
    lazy var getBtn = UIButton().then {
        $0.backgroundColor = common2.pointColor()
    }
    lazy var getImgView = UIImageView().then {
        $0.image = UIImage(named: "up_btn")
    }
    lazy var getLbl = UILabel().then {
        $0.text = "받기"
        $0.font = common2.setFont(font: "bold", size: 18)
        $0.textColor = .white
    }
 
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        addSubviewFunc()
        setLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("initFail")
    }
    func addSubviewFunc(){
        [firstLbl,secondLbl,thirdLbl,fourthLbl,getBtn].forEach{
            self.addSubview($0)
        }
        [getImgView,getLbl].forEach {
            getBtn.addSubview($0)
        }
    }
    func setLayout(){
        let lblWidth = CGFloat(screenBounds2.width - margin2 * 7)
        firstLbl.snp.makeConstraints {
            $0.top.equalToSuperview().offset(margin2 * 3 / 2)
            $0.left.equalToSuperview().offset(margin2)
            $0.width.equalTo(lblWidth)
        }
        secondLbl.snp.makeConstraints {
            $0.top.equalTo(firstLbl.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(margin2)
            $0.width.equalTo(lblWidth)
        }
        thirdLbl.snp.makeConstraints {
            $0.top.equalTo(secondLbl.snp.bottom).offset(15)
            $0.left.equalToSuperview().offset(margin2)
            $0.width.equalTo(lblWidth)
        }
        fourthLbl.snp.makeConstraints {
            $0.top.equalTo(thirdLbl.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(margin2)
            $0.width.equalTo(lblWidth)
        }
        getBtn.snp.makeConstraints {
            $0.top.right.bottom.equalToSuperview()
            $0.left.equalTo(firstLbl.snp.right)
        }
        getImgView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(super.snp.centerY).offset(-2.5)
        }
        getLbl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(super.snp.centerY).offset(2.5)
        }
    }
}
