//
//  DeliveryListSampleTableViewCell.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/11/02.
//

import Foundation

import Foundation

class DeliveryListSampleTableViewCell: UITableViewCell {
    static let cellId = "DeliveryListCellId"
    let common = CommonS()
    let margin = 17.0
    let screenBounds = UIScreen.main.bounds
    let pointSize = CGSize(width: 8, height: 8)
    lazy var lineView = UIView().then{
        $0.backgroundColor = common.lightGray()
    }
    lazy var situationBtn = UIButton().then{
        $0.backgroundColor = common.pointColor()
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("배송준비", for: .normal)
        $0.titleLabel?.font = common.setFont(font: "bold", size: 13)
    }
    //상품 정보 뷰 - 첫번쨰
    let allInfoView = UIView()
    let firstSampleInfoView = UIView().then{
        $0.backgroundColor = .clear
    }
    let firstImgView = UIImageView().then{
        $0.backgroundColor = .clear
    }
    lazy var firstCompanyLbl = UILabel().then{
        $0.font = common.setFont(font: "bold", size: 10)
        $0.textColor = common.setColor(hex: "b1b1b1")
        $0.text = "Test"
    }
    lazy var firstProductNameLbl = UILabel().then{
        $0.font = common.setFont(font: "semibold", size: 15)
        $0.textColor = common.setColor(hex: "6f6f6f")
        $0.text = "Test"
    }
    //상품 정보 뷰 - 두번쨰
    let secondSampleInfoView = UIView().then{
        $0.backgroundColor = .clear
    }
    let secondImgView = UIImageView().then{
        $0.backgroundColor = .clear
    }
    lazy var secondCompanyLbl = UILabel().then{
        $0.font = common.setFont(font: "bold", size: 10)
        $0.textColor = common.setColor(hex: "b1b1b1")
        $0.text = "Test"
    }
    lazy var secondProductNameLbl = UILabel().then{
        $0.font = common.setFont(font: "semibold", size: 15)
        $0.textColor = common.setColor(hex: "6f6f6f")
        $0.text = "Test"
    }
    //상품 정보 뷰 - 세번쨰
    let thirdSampleInfoView = UIView().then{
        $0.backgroundColor = .clear
    }
    let thirdImgView = UIImageView().then{
        $0.backgroundColor = .clear
    }
    lazy var thirdCompanyLbl = UILabel().then{
        $0.font = common.setFont(font: "bold", size: 10)
        $0.textColor = common.setColor(hex: "b1b1b1")
        $0.text = "Test"
    }
    lazy var thirdProductNameLbl = UILabel().then{
        $0.font = common.setFont(font: "semibold", size: 15)
        $0.textColor = common.setColor(hex: "6f6f6f")
        $0.text = "Test"
    }
    // 프로그레스 바
    let progressBarView = UIView().then{
        $0.backgroundColor = .clear
    }
    // 프로그레스 바 - 1번째
    lazy var readyLbl = UILabel().then{
        $0.text = "배송준비"
        $0.font = common.setFont(font: "semibold", size: 10)
        $0.textColor = common.setColor(hex: "#6f6f6f")
    }
    lazy var readyPoint = UIView().then{
        $0.backgroundColor = .black
        $0.layer.cornerRadius = pointSize.height/2
        $0.clipsToBounds = true
    }
    lazy var startBar = UIView().then{
        $0.backgroundColor = common.lightGray()
        $0.layer.cornerRadius = pointSize.height/2
        $0.clipsToBounds = true
    }
    // 프로그레스 바 - 2번째
    lazy var startLbl = UILabel().then{
        $0.text = "배송시작"
        $0.font = common.setFont(font: "semibold", size: 10)
        $0.textColor = common.setColor(hex: "#6f6f6f")
    }
    lazy var startPoint = UIView().then{
        $0.backgroundColor = .black
        $0.layer.cornerRadius = pointSize.height/2
        $0.clipsToBounds = true
    }
    lazy var shippingBar = UIView().then{
        $0.backgroundColor = common.lightGray()
        $0.layer.cornerRadius = pointSize.height/2
        $0.clipsToBounds = true
    }
    // 프로그레스 바 - 3번째
    lazy var shippingLbl = UILabel().then{
        $0.text = "배송중"
        $0.font = common.setFont(font: "semibold", size: 10)
        $0.textColor = common.setColor(hex: "#6f6f6f")
    }
    lazy var shippingPoint = UIView().then{
        $0.backgroundColor = .black
        $0.layer.cornerRadius = pointSize.height/2
        $0.clipsToBounds = true
    }
    lazy var arrivalBar = UIView().then{
        $0.backgroundColor = common.lightGray()
        $0.layer.cornerRadius = pointSize.height/2
        $0.clipsToBounds = true
    }
    // 프로그레스 바 - 4번째
    lazy var arrivalLbl = UILabel().then{
        $0.text = "도착예정"
        $0.font = common.setFont(font: "semibold", size: 10)
        $0.textColor = common.setColor(hex: "#6f6f6f")
    }
    lazy var arrivalPoint = UIView().then{
        $0.backgroundColor = .black
        $0.layer.cornerRadius = pointSize.height/2
        $0.clipsToBounds = true
    }
    //상세보기 버튼
    lazy var orderDetailBtn = UIButton().then{
        $0.setTitle("주문 상세 >", for: .normal)
        $0.setTitleColor(common.pointColor(), for: .normal)
        $0.titleLabel?.font = common.setFont(font: "semibold", size: 15)
    }
    // 밑 두 버튼
    lazy var deliveryTrackingBtn = UIButton().then{
        $0.backgroundColor = common.pointColor()
        $0.setTitle("배송조회", for: .normal)
        $0.titleLabel?.font = common.setFont(font: "bold", size: 15)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 5
    }
    lazy var exchangeBtn = UIButton().then{
        $0.backgroundColor = common.pointColor()
        $0.setTitle("교환/반품", for: .normal)
        $0.titleLabel?.font = common.setFont(font: "bold", size: 15)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 5
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
        [lineView,situationBtn,allInfoView,progressBarView,deliveryTrackingBtn,exchangeBtn,orderDetailBtn].forEach{
            self.addSubview($0)
        }
        [firstSampleInfoView,secondSampleInfoView,thirdSampleInfoView].forEach{
            allInfoView.addSubview($0)
        }
        [firstImgView,firstCompanyLbl,firstProductNameLbl].forEach{
            firstSampleInfoView.addSubview($0)
        }
        [secondImgView,secondCompanyLbl,secondProductNameLbl].forEach{
            secondSampleInfoView.addSubview($0)
        }
        [thirdImgView,thirdCompanyLbl,thirdProductNameLbl].forEach{
            thirdSampleInfoView.addSubview($0)
        }
        [readyLbl,readyPoint,startBar,startLbl,shippingBar,startPoint,arrivalBar,shippingLbl,shippingPoint,arrivalLbl,arrivalPoint].forEach{
            progressBarView.addSubview($0)
        }
        
        
    }
    func setLayout(){
        lineView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.bottom.equalTo(super.snp.top).offset(2)
            $0.left.equalToSuperview().offset(margin)
            $0.right.equalToSuperview().offset(-margin)
        }
        situationBtn.snp.makeConstraints{
            $0.top.equalTo(lineView.snp.bottom).offset(12)
            $0.left.equalToSuperview().offset(margin)
            $0.bottom.equalTo(lineView.snp.bottom).offset(12 + screenBounds.width/21.0)
            $0.right.equalTo(super.snp.left).offset(margin).offset(margin + screenBounds.width/7.0)
        }
        orderDetailBtn.snp.makeConstraints{
            $0.bottom.equalTo(allInfoView)
            $0.right.equalToSuperview().offset(-margin)
        }
        
        allInfoView.snp.makeConstraints{
            $0.left.equalToSuperview().offset(margin)
            $0.right.equalTo(super.snp.left).offset(margin + ((screenBounds.width * 2.0) / 3.0))
            $0.top.equalTo(situationBtn.snp.bottom).offset(12)
            $0.bottom.equalTo(situationBtn.snp.bottom).offset(12 + screenBounds.height/8)
        }
        firstSampleInfoView.snp.makeConstraints{
            $0.left.top.bottom.equalToSuperview()
            $0.right.equalTo(allInfoView.snp.left).offset(screenBounds.width * 2 / 9)
        }
        secondSampleInfoView.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.left.equalTo(firstSampleInfoView.snp.right)
            $0.right.equalTo(firstSampleInfoView.snp.right).offset(screenBounds.width * 2 / 9)
        }
        
        thirdSampleInfoView.snp.makeConstraints{
            $0.top.bottom.right.equalToSuperview()
            $0.left.equalTo(secondSampleInfoView.snp.right)
        }
        [firstImgView,secondImgView,thirdImgView].forEach{
            $0.snp.makeConstraints{
                $0.top.equalToSuperview()
                $0.left.right.equalToSuperview().inset(margin)
                $0.bottom.equalTo(firstSampleInfoView.snp.top).offset(screenBounds.height * 1 / 12)
            }
        }
        
        [firstCompanyLbl,secondCompanyLbl,thirdCompanyLbl].forEach{
            $0.snp.makeConstraints{
                $0.top.equalTo(firstImgView.snp.bottom).offset(5)
                $0.centerX.equalToSuperview()
            }
        }
        [firstProductNameLbl,secondProductNameLbl,thirdProductNameLbl].forEach{
            $0.snp.makeConstraints{
                $0.top.equalTo(firstCompanyLbl.snp.bottom).offset(5)
                $0.centerX.equalToSuperview()
            }
        }
        progressBarView.snp.makeConstraints{
            $0.top.equalTo(allInfoView.snp.bottom).offset(36.0)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(allInfoView.snp.bottom).offset(36.0 + 30.0)
        }
        let barWidth = (screenBounds.width - margin * 2 + 35)/4
        readyLbl.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().offset(margin)
        }
        readyPoint.snp.makeConstraints {
            $0.centerX.equalTo(readyLbl.snp.centerX)
            $0.bottom.equalToSuperview()
            $0.size.equalTo(pointSize)
        }
        startBar.snp.makeConstraints {
            $0.top.bottom.equalTo(readyPoint)
            $0.left.equalTo(readyPoint.snp.right).offset(2)
            $0.size.equalTo(CGSize(width: barWidth, height: pointSize.height))
        }
        startPoint.snp.makeConstraints{
            $0.left.equalTo(startBar.snp.right).offset(2)
            $0.bottom.equalToSuperview()
            $0.size.equalTo(pointSize)
        }
        shippingBar.snp.makeConstraints {
            $0.top.bottom.equalTo(startPoint)
            $0.left.equalTo(startPoint.snp.right).offset(2)
            $0.size.equalTo(CGSize(width: barWidth, height: pointSize.height))
        }
        startLbl.snp.makeConstraints {
            $0.centerX.equalTo(startPoint)
            $0.top.equalToSuperview()
        }
        shippingPoint.snp.makeConstraints{
            $0.left.equalTo(shippingBar.snp.right).offset(2)
            $0.bottom.equalToSuperview()
            $0.size.equalTo(pointSize)
        }
        arrivalBar.snp.makeConstraints {
            $0.top.bottom.equalTo(shippingPoint)
            $0.left.equalTo(shippingPoint.snp.right).offset(2)
            $0.size.equalTo(CGSize(width: barWidth, height: pointSize.height))
        }
        shippingLbl.snp.makeConstraints{
            $0.centerX.equalTo(shippingPoint)
            $0.top.equalToSuperview()
        }
        arrivalPoint.snp.makeConstraints{
            $0.left.equalTo(arrivalBar.snp.right).offset(2)
            $0.bottom.equalToSuperview()
            $0.size.equalTo(pointSize)
        }
        arrivalLbl.snp.makeConstraints{
            $0.centerX.equalTo(arrivalPoint)
            $0.top.equalToSuperview()
        }
        let btnSize = CGSize(width: screenBounds.width/4, height: screenBounds.width/12)
        exchangeBtn.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-12)
            $0.right.equalToSuperview().offset(-margin)
            $0.size.equalTo(btnSize)
        }
        deliveryTrackingBtn.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-12)
            $0.right.equalTo(exchangeBtn.snp.left).offset(-10)
            $0.size.equalTo(btnSize)
            
        }
        
    }
}
