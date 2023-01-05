//
//  DeliveryListTableViewCell.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/10/28.
//

import Foundation

class DeliveryListTableViewCell: UITableViewCell {
    static let cellId = "DeliveryListCellId2"
    var orderDetailBtnTapped:(() -> Void)?
    var deliveryTrackingTapped: (() -> Void)?
    var exchangeBtnTapped: (() -> Void)?
    let common = CommonS()
    let margin = 17.0
    let screenBounds = UIScreen.main.bounds
    let pointSize = CGSize(width: 4, height: 4)
    lazy var lineView = UIView().then{
        $0.backgroundColor = common.lightGray()
    }
    lazy var situationBtn = UIButton().then{
        $0.backgroundColor = common.pointColor()
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("배송준비", for: .normal)
        $0.titleLabel?.font = common.setFont(font: "bold", size: 13)
    }
    //상품 정보 뷰
    let productInfoView = UIView().then{
        $0.backgroundColor = .clear
    }
    let imgView = UIImageView().then{
        $0.backgroundColor = .clear
    }
    lazy var orderDetailBtn = UIButton().then{
        $0.setTitle("주문 상세 >", for: .normal)
        $0.setTitleColor(common.pointColor(), for: .normal)
        $0.titleLabel?.font = common.setFont(font: "semibold", size: 15)
        $0.accessibilityLabel = "hi"
    }
    lazy var companyNameLbl = UILabel().then{
        $0.font = common.setFont(font: "bold", size: 10)
        $0.textColor = common.setColor(hex: "b1b1b1")
    }
    lazy var productNameLbl = UILabel().then{
        $0.font = common.setFont(font: "semibold", size: 15)
        $0.textColor = common.setColor(hex: "6f6f6f")
    }
    let starImgView = UIImageView().then{
        $0.image = UIImage(named: "star_btn")
        $0.isHidden = true
    }
    lazy var ratingLbl = UILabel().then{
        $0.font = common.setFont(font: "semibold", size: 12)
        $0.isHidden = true
    }
    lazy var priceLbl = UILabel().then{
        $0.font = common.setFont(font: "bold", size: 17)
        $0.textColor = common.setColor(hex: "#6f6f6f")
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
        $0.backgroundColor = common.setColor(hex: "#f5f5f5")
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
        $0.backgroundColor = common.setColor(hex: "#f5f5f5")
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
        $0.backgroundColor = common.setColor(hex: "#f5f5f5")
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
        self.orderDetailBtn.addTarget(self, action: #selector(touchOrderDetailBtn), for: .touchUpInside)
        self.exchangeBtn.addTarget(self, action: #selector(touchExchangeBtn), for: .touchUpInside)
        self.deliveryTrackingBtn.addTarget(self, action: #selector(touchDeliveryTrackingBtn), for: .touchUpInside)
        contentView.isUserInteractionEnabled = true
        addSubviewFunc()
        setLayout()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addSubviewFunc(){
        [lineView,situationBtn,productInfoView,progressBarView,deliveryTrackingBtn,exchangeBtn,orderDetailBtn].forEach{
            self.addSubview($0)
        }
        [imgView,companyNameLbl,productNameLbl,starImgView,ratingLbl,priceLbl].forEach{
            productInfoView.addSubview($0)
        }
        [readyLbl,readyPoint,startBar,startLbl,shippingBar,startPoint,arrivalBar,shippingLbl,shippingPoint,arrivalLbl,arrivalPoint].forEach{
            progressBarView.addSubview($0)
        }
        
      
    }
    func setLayout(){
        lineView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.bottom.equalTo(super.snp.top).offset(2)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
        situationBtn.snp.makeConstraints{
            $0.top.equalTo(lineView.snp.bottom).offset(12)
            $0.left.equalToSuperview().offset(margin)
            $0.bottom.equalTo(lineView.snp.bottom).offset(12 + screenBounds.width/21.0)
            $0.right.equalTo(super.snp.left).offset(margin).offset(margin + screenBounds.width/7.0)
        }
        productInfoView.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.top.equalTo(situationBtn.snp.bottom).offset(12)
            $0.bottom.equalTo(situationBtn.snp.bottom).offset(12 + screenBounds.width*2.0/9.0)
        }
        imgView.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview().offset(margin)
            $0.right.equalTo(super.snp.left).offset(margin + screenBounds.width/6.0)
        }
        companyNameLbl.snp.makeConstraints{
            $0.left.equalTo(imgView.snp.right).offset(screenBounds.width/24.0)
            $0.top.equalToSuperview()
        }
        let betweenY = (screenBounds.width*2.0/9.0 - (productNameLbl.font.pointSize + companyNameLbl.font.pointSize + 12 + priceLbl.font.pointSize))/4
        productNameLbl.snp.makeConstraints{
            $0.left.equalTo(companyNameLbl)
            $0.top.equalTo(companyNameLbl.snp.bottom).offset(betweenY)
        }
        starImgView.snp.makeConstraints{
            $0.left.equalTo(companyNameLbl)
            $0.top.equalTo(productNameLbl.snp.bottom).offset(betweenY)
            $0.size.equalTo(CGSize(width: 12, height: 12))
        }
        ratingLbl.snp.makeConstraints{
            $0.centerY.equalTo(starImgView)
            $0.left.equalTo(starImgView.snp.right).offset(5)
        }
        priceLbl.snp.makeConstraints{
            $0.left.equalTo(companyNameLbl)
            $0.bottom.equalToSuperview()
        }
        orderDetailBtn.snp.makeConstraints{
            $0.right.equalToSuperview().offset(-margin2)
            $0.centerY.equalTo(situationBtn)
        }
        progressBarView.snp.makeConstraints{
            $0.top.equalTo(productInfoView.snp.bottom).offset(36.0)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(productInfoView.snp.bottom).offset(36.0 + 30.0)
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
    @objc func touchOrderDetailBtn(){
        print("탭")
        orderDetailBtnTapped?()
    }
    @objc func touchExchangeBtn(){
        print("탭")
        exchangeBtnTapped?()
    }
    @objc func touchDeliveryTrackingBtn(){
        print("탭")
        deliveryTrackingTapped?()
    }
}
