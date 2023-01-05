//
//  orderCompleteView.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/11/08.
//

import Foundation

class OrderCompleteView: UIView {
    let common = CommonS()
    let screenBounds = UIScreen.main.bounds
    lazy var titLbl = UILabel().then{
        $0.font = common.setFont(font: "bold", size: 20)
        $0.textColor = common.pointColor()
        $0.textAlignment = .center
    }
    lazy var backBtn = UIButton().then {
        $0.setImage(UIImage(named: "back_btn"), for: .normal)
    }
    lazy var subTit = UILabel().then{
        $0.font = common.setFont(font: "semibold", size: 15)
        $0.textAlignment = .center
    }
    let scrlView  = UIScrollView().then{
        $0.backgroundColor = .clear
    }
    lazy var subInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = common.setColor(hex: "#f5f5f5")
        [dateLbl,orderNumberLabel].forEach {
            view.addSubview($0)
        }
        dateLbl.snp.makeConstraints {
            $0.left.equalToSuperview().offset(margin2)
            $0.centerY.equalToSuperview()
        }
        orderNumberLabel.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-margin2)
            $0.centerY.equalToSuperview()
        }
        return view
    }()
    lazy var dateLbl = UILabel().then {
        $0.font = common.setFont(font: "semibold", size: 15)
        $0.textColor = .black
        $0.text = "test"
    }
    lazy var orderNumberLabel = UILabel().then {
        $0.font = common.setFont(font: "semibold", size: 15)
        $0.textColor = .black
        $0.text = "test"
    }
 
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.backgroundColor = common.setColor(hex: "#f5f5f5")
        return stackView
    }()
    // 배송지 정보
    lazy var shippingInformationView = UIView().then{
        $0.backgroundColor = common.setColor(hex: "#f5f5f5")
    }
    lazy var shippingTit = UILabel().then{
        $0.text = "배송지정보"
        $0.textColor = common.setColor(hex: "6f6f6f")
        $0.font = common.setFont(font: "bold", size: 15)
    }
    lazy var shippingLineView = UIView().then{
        $0.backgroundColor = common.lightGray()
    }
    // 배송지 정보 - 수령인
    lazy var recipientLbl = UILabel().then{
        $0.text = "수령인"
        $0.textColor = common.setColor(hex: "6f6f6f")
        $0.font = common.setFont(font: "bold", size: 15)
    }
    lazy var recipient = UILabel().then{
        $0.font = common.setFont(font: "bold", size: 15)
        $0.textColor = common.setColor(hex: "6f6f6f")
    }
    // 배송지 정보 - 연락처
    lazy var telNumLbl = UILabel().then{
        $0.text = "연락처"
        $0.font = common.setFont(font: "bold", size: 15)
        $0.textColor = common.setColor(hex: "6f6f6f")
    }
    lazy var telNum = UILabel().then{
        $0.font = common.setFont(font: "semibold", size: 15)
        $0.textColor = common.setColor(hex: "6f6f6f")
    }
    // 배송지 정보 - 배송지
    lazy var addressLbl = UILabel().then{
        $0.text = "배송지"
        $0.font = common.setFont(font: "bold", size: 15)
        $0.textColor = common.setColor(hex: "6f6f6f")
    }
    lazy var addressNum = UILabel().then{
        $0.font = common.setFont(font: "bold", size: 15)
        $0.textColor = common.setColor(hex: "6f6f6f")
    }
    lazy var address = UILabel().then{
        $0.font = common.setFont(font: "bold", size: 15)
        $0.textColor = common.setColor(hex: "6f6f6f")
        $0.numberOfLines = 0
    }
    // 배송지 정보 - 배송요청사항
    lazy var deliveryRequestLbl = UILabel().then{
        $0.text = "배송요청"
        $0.font = common.setFont(font: "bold", size: 15)
        $0.textColor = common.setColor(hex: "6f6f6f")
    }
    lazy var deliveryRequest = UILabel().then{
        $0.font = common.setFont(font: "bold", size: 15)
        $0.textColor = common.setColor(hex: "6f6f6f")
    }
    // 결제정보
    lazy var paymentInformationView = UIView().then{
        $0.backgroundColor = common.setColor(hex: "#f5f5f5")
    }
    lazy var paymentInformationTit = UILabel().then{
        $0.text = "결제정보"
        $0.font = common.setFont(font: "bold", size: 15)
        $0.textColor = common.setColor(hex: "6f6f6f")
    }
    lazy var secondLineView = UIView().then {
        $0.backgroundColor = common.lightGray()
    }
    // 결제정보 - 결제수단
    lazy var paymentMethodLbl = UILabel().then{
        $0.text = "결제수단"
        $0.font = common.setFont(font: "bold", size: 15)
        $0.textColor = common.setColor(hex: "6f6f6f")
    }
    lazy var paymentMethod = UILabel().then{
        $0.font = common.setFont(font: "bold", size: 15)
        $0.numberOfLines = 0
        $0.textAlignment = .right
        $0.textColor = common.setColor(hex: "6f6f6f")
    }
    // 결제정보 - 총 주문 금액
    lazy var orderTotalPriceLbl = UILabel().then{
        $0.text = "총 주문 금액"
        $0.font = common.setFont(font: "bold", size: 15)
        $0.textColor = common.setColor(hex: "6f6f6f")
    }
    lazy var orderTotalPrice = UILabel().then{
        $0.font = common.setFont(font: "bold", size: 15)
        $0.textColor = common.pointColor()
        $0.textColor = common.pointColor()
    }
    // 결제정보 - 금액
    // 결제정보 - 금액 - 상품금액
    lazy var priceDetailView = UIView().then{
        $0.backgroundColor = common.lightGray()
    }
    lazy var productPriceLbl = UILabel().then{
        $0.text = "상품금액"
        $0.font = common.setFont(font: "bold", size: 15)
        $0.textColor = common.setColor(hex: "6f6f6f")
    }
    lazy var productPrice = UILabel().then{
        $0.font = common.setFont(font: "bold", size: 15)
        $0.textColor = common.setColor(hex: "6f6f6f")
    }
    // 결제정보 - 금액 - 배송비
    lazy var deliveryPriceLbl = UILabel().then{
        $0.text = "배송비"
        $0.font = common.setFont(font: "bold", size: 15)
        $0.textColor = common.setColor(hex: "6f6f6f")
    }
    lazy var deliveryPrice = UILabel().then{
        $0.font = common.setFont(font: "bold", size: 15)
        $0.textColor = common.setColor(hex: "6f6f6f")
    }
    // 결제정보 - 금액 - 쿠폰할인
    lazy var couponDiscountLbl = UILabel().then{
        $0.text = "쿠폰할인"
        $0.font = common.setFont(font: "bold", size: 15)
        $0.textColor = common.setColor(hex: "6f6f6f")
    }
    lazy var couponDiscount = UILabel().then{
        $0.font = common.setFont(font: "bold", size: 15)
        $0.textColor = common.setColor(hex: "6f6f6f")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubviewFunc()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init fail")
    }
    func addSubviewFunc(){
        [titLbl,subTit,scrlView,backBtn].forEach{
            self.addSubview($0)
        }
        [subInfoView,stackView,shippingInformationView,paymentInformationView].forEach{
            scrlView.addSubview($0)
        }
        [shippingTit,shippingLineView,recipientLbl,recipient,telNumLbl,telNum,addressLbl,addressNum,address,deliveryRequestLbl,deliveryRequest].forEach{
            shippingInformationView.addSubview($0)
        }
        [paymentInformationTit,paymentMethodLbl,paymentMethod,orderTotalPriceLbl,orderTotalPrice,secondLineView,priceDetailView].forEach{
            paymentInformationView.addSubview($0)
        }
        [productPriceLbl,productPrice,deliveryPriceLbl,deliveryPrice,couponDiscountLbl,couponDiscount].forEach{
            priceDetailView.addSubview($0)
        }
    }
    func setLayout(){
        titLbl.snp.makeConstraints {
            $0.top.equalToSuperview().offset(screenBounds.width/4 - titLbl.font.pointSize)
            $0.left.right.equalToSuperview()
        }
        backBtn.snp.makeConstraints {
            $0.left.equalToSuperview().offset(margin2)
            $0.centerY.equalTo(titLbl)
        }
        subTit.snp.makeConstraints {
            $0.top.equalTo(titLbl.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
        }
        scrlView.snp.makeConstraints {
            $0.top.equalTo(subTit.snp.bottom).offset(10)
            $0.left.right.bottom.equalToSuperview()
        }
        subInfoView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(50)
        }
        stackView.snp.makeConstraints {
            $0.top.equalTo(subInfoView.snp.bottom).offset(40 * screenRatio)
            $0.left.right.equalToSuperview()
        }
        shippingInformationView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(40 * screenRatio)
            $0.left.right.equalToSuperview()
        }
        shippingTit.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15 * screenRatio)
            $0.left.equalToSuperview().offset(margin2)
        }
        shippingLineView.snp.makeConstraints {
            $0.top.equalTo(shippingTit.snp.bottom).offset(15 * screenRatio)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(2)
        }
        recipientLbl.snp.makeConstraints {
            $0.top.equalTo(shippingLineView.snp.bottom).offset(50 * screenRatio)
            $0.left.equalTo(margin2)
        }
        recipient.snp.makeConstraints {
            $0.top.equalTo(recipientLbl)
            $0.left.equalTo(recipientLbl.snp.right).offset(50 * screenRatio)
        }
        telNumLbl.snp.makeConstraints {
            $0.top.equalTo(recipientLbl.snp.bottom).offset(20 * screenRatio)
            $0.left.equalTo(margin2)
        }
        telNum.snp.makeConstraints {
            $0.top.equalTo(telNumLbl)
            $0.left.equalTo(recipient)
        }
        addressLbl.snp.makeConstraints {
            $0.top.equalTo(telNumLbl.snp.bottom).offset(20 * screenRatio)
            $0.left.equalToSuperview().offset(margin2)
        }
        addressNum.snp.makeConstraints {
            $0.top.equalTo(addressLbl)
            $0.left.equalTo(recipient)
        }
        address.snp.makeConstraints {
            $0.top.equalTo(addressNum.snp.bottom).offset(5 * screenRatio)
            $0.left.equalTo(addressNum)
            $0.right.equalToSuperview().offset(-50 * screenRatio)
        }
        deliveryRequestLbl.snp.makeConstraints {
            $0.top.equalTo(address.snp.bottom).offset(20 * screenRatio)
            $0.left.equalToSuperview().offset(margin2)
            $0.bottom.equalToSuperview().offset(-20)
        }
        deliveryRequest.snp.makeConstraints {
            $0.top.equalTo(deliveryRequestLbl)
            $0.left.equalTo(recipient)
        }
        // 결제 정보
        paymentInformationView.snp.makeConstraints {
            $0.top.equalTo(shippingInformationView.snp.bottom).offset(40 * screenRatio)
            $0.left.right.equalToSuperview()
            $0.width.equalTo(screenBounds2.width)
            $0.bottom.equalToSuperview().offset(-50)
        }
        paymentInformationTit.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15 * screenRatio)
            $0.left.equalToSuperview().offset(margin2)
        }
        secondLineView.snp.makeConstraints {
            $0.top.equalTo(paymentInformationTit.snp.bottom).offset(20 * screenRatio)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(2)
        }
        paymentMethodLbl.snp.makeConstraints {
            $0.top.equalTo(secondLineView.snp.bottom).offset(20 * screenRatio)
            $0.left.equalToSuperview().offset(margin2)
        }
        paymentMethod.snp.makeConstraints {
            $0.top.equalTo(paymentMethodLbl)
            $0.right.equalToSuperview().offset(-margin2)
        }
        orderTotalPriceLbl.snp.makeConstraints {
            $0.top.equalTo(paymentMethod.snp.bottom).offset(20 * screenRatio)
            $0.left.equalToSuperview().offset(margin2)
        }
        orderTotalPrice.snp.makeConstraints {
            $0.top.equalTo(orderTotalPriceLbl)
            $0.right.equalToSuperview().offset(-margin2)
        }
        priceDetailView.snp.makeConstraints {
            $0.top.equalTo(orderTotalPriceLbl.snp.bottom).offset(10 * screenRatio)
            $0.left.right.bottom.equalToSuperview()
        }
        productPriceLbl.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20 * screenRatio)
            $0.left.equalToSuperview().offset(margin2)
        }
        productPrice.snp.makeConstraints {
            $0.top.equalTo(productPriceLbl)
            $0.right.equalToSuperview().offset(-margin2)
        }
        deliveryPriceLbl.snp.makeConstraints {
            $0.top.equalTo(productPriceLbl.snp.bottom).offset(20 * screenRatio)
            $0.left.equalToSuperview().offset(margin2)
        }
        deliveryPrice.snp.makeConstraints {
            $0.top.equalTo(deliveryPriceLbl)
            $0.right.equalToSuperview().offset(-margin2)
        }
        couponDiscountLbl.snp.makeConstraints {
            $0.top.equalTo(deliveryPriceLbl.snp.bottom).offset(20 * screenRatio)
            $0.left.equalToSuperview().offset(margin2)
            $0.height.equalTo(couponDiscount.font.pointSize)
            $0.bottom.equalToSuperview().offset(-10)
        }
        couponDiscount.snp.makeConstraints {
            $0.top.equalTo(deliveryPriceLbl.snp.bottom).offset(20 * screenRatio)
            $0.right.equalToSuperview().offset(-margin2)
            $0.height.equalTo(couponDiscount.font.pointSize)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
    
 
}
