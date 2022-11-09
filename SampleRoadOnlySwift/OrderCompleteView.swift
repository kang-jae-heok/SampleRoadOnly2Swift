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
        $0.text = "주문완료"
        $0.font = common.setFont(font: "bold", size: 20)
        $0.textAlignment = .center
    }
    lazy var subTit = UILabel().then{
        $0.text = "결제가 완료되었습니다"
        $0.font = common.setFont(font: "semibold", size: 15)
        $0.textAlignment = .center
    }
    let scrlView  = UIScrollView().then{
        $0.backgroundColor = .clear
    }
    // 배송지 정보
    lazy var shippingInformationView = UIView().then{
        $0.backgroundColor = common.gray()
    }
    lazy var shippingTit = UILabel().then{
        $0.text = "배송지정보"
        $0.font = common.setFont(font: "bold", size: 15)
    }
    lazy var shippingLineView = UIView().then{
        $0.backgroundColor = .darkGray
    }
    // 배송지 정보 - 수령인
    lazy var recipientLbl = UILabel().then{
        $0.text = "수령인"
        $0.font = common.setFont(font: "bold", size: 15)
    }
    lazy var recipient = UILabel().then{
        $0.font = common.setFont(font: "bold", size: 15)
    }
    // 배송지 정보 - 연락처
    lazy var telNumLbl = UILabel().then{
        $0.text = "연락처"
        $0.font = common.setFont(font: "bold", size: 15)
    }
    lazy var telNum = UILabel().then{
        $0.font = common.setFont(font: "semibold", size: 15)
    }
    // 배송지 정보 - 배송지
    lazy var addressLbl = UILabel().then{
        $0.text = "배송지"
        $0.font = common.setFont(font: "bold", size: 15)
    }
    lazy var addressNum = UILabel().then{
        $0.text = "1049"
        $0.font = common.setFont(font: "bold", size: 15)
    }
    lazy var address = UILabel().then{
        $0.text = "서울시 관악구 관악센터 123(관악창업센터) 502호"
        $0.font = common.setFont(font: "bold", size: 15)
        $0.numberOfLines = 0
    }
    // 배송지 정보 - 배송요청사항
    lazy var deliveryRequestLbl = UILabel().then{
        $0.text = "배송요청"
        $0.font = common.setFont(font: "bold", size: 15)
    }
    lazy var deliveryRequest = UILabel().then{
        $0.text = "문앞에 놔주세요"
        $0.font = common.setFont(font: "bold", size: 15)
    }
    // 결제정보
    lazy var paymentInformationView = UIView().then{
        $0.backgroundColor = .lightGray
    }
    lazy var paymentInformationTit = UILabel().then{
        $0.text = "결제정보"
        $0.font = common.setFont(font: "bold", size: 15)
    }
    // 결제정보 - 결제수단
    lazy var paymentMethodLbl = UILabel().then{
        $0.text = "결제수단"
        $0.font = common.setFont(font: "bold", size: 15)
    }
    lazy var paymentMethod = UILabel().then{
        $0.text = "네이버페이"
        $0.font = common.setFont(font: "bold", size: 15)
    }
    // 결제정보 - 총 주문 금액
    lazy var orderTotalPriceLbl = UILabel().then{
        $0.text = "총 주문 금액"
        $0.font = common.setFont(font: "bold", size: 15)
    }
    lazy var orderTotalPrice = UILabel().then{
        $0.text = "1,6000원"
        $0.font = common.setFont(font: "bold", size: 15)
        $0.textColor = common.pointColor()
    }
    // 결제정보 - 금액
    // 결제정보 - 금액 - 상품금액
    lazy var priceDetailView = UIView().then{
        $0.backgroundColor = common.pointColor()
    }
    lazy var productPriceLbl = UILabel().then{
        $0.text = "상품금액"
        $0.font = common.setFont(font: "bold", size: 13)
    }
    lazy var productPrice = UILabel().then{
        $0.text = "14,900원"
        $0.font = common.setFont(font: "bold", size: 13)
    }
    // 결제정보 - 금액 - 배송비
    lazy var deliveryPriceLbl = UILabel().then{
        $0.text = "배송비"
        $0.font = common.setFont(font: "bold", size: 13)
    }
    lazy var deliveryPrice = UILabel().then{
        $0.text = "2,500원"
        $0.font = common.setFont(font: "bold", size: 13)
    }
    // 결제정보 - 금액 - 쿠폰할인
    lazy var couponDiscountLbl = UILabel().then{
        $0.text = "쿠폰할인"
        $0.font = common.setFont(font: "bold", size: 13)
    }
    lazy var couponDiscount = UILabel().then{
        $0.text = "-10,000원"
        $0.font = common.setFont(font: "bold", size: 13)
    }
    // 결제정보 - 금액 - 포인트 사용
    lazy var pointLbl = UILabel().then{
        $0.text = "포인트 사용"
        $0.font = common.setFont(font: "bold", size: 13)
    }
    lazy var point = UILabel().then{
        $0.text = "-1,000원"
        $0.font = common.setFont(font: "bold", size: 13)
    }
    // 적립 포인트
    lazy var savedPointView = UIView().then{
        $0.backgroundColor = common.lightGray()
    }
    lazy var savedPointLbl = UILabel().then{
        $0.text = "적립 포인트"
        $0.font = common.setFont(font: "bold", size: 15)
    }
    lazy var savedPoint = UILabel().then{
        $0.text = "최대 1,000p"
        $0.font = common.setFont(font: "semibold", size: 15)
        $0.asFont(targetStringList: ["최대"], font: common.setFont(font: "bold", size: 15))
    }
    lazy var earnTextReviewLbl = UILabel().then{
        $0.text = "텍스트 리뷰 적립"
        $0.font = common.setFont(font: "bold", size: 13)
    }
    lazy var earnTextReview = UILabel().then{
        $0.text = "500p"
        $0.font = common.setFont(font: "semibold", size: 13)
    }
    lazy var earnPhotoReviewLbl = UILabel().then{
        $0.text = "텍스트 리뷰 적립"
        $0.font = common.setFont(font: "bold", size: 13)
    }
    lazy var earnPhotoReview = UILabel().then{
        $0.text = "텍스트 리뷰 적립"
        $0.font = common.setFont(font: "semibold", size: 13)
    }
    lazy var homeBtn = UIButton().then{
        $0.backgroundColor = common.pointColor()
        $0.setTitle("홈가기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = common.setFont(font: "bold", size: 20)
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
        [titLbl,subTit,scrlView,homeBtn].forEach{
            self.addSubview($0)
        }
        [shippingInformationView,paymentInformationView,savedPointLbl,savedPoint,savedPointView].forEach{
            scrlView.addSubview($0)
        }
        [shippingTit,shippingLineView,recipientLbl,recipient,telNumLbl,telNum,addressLbl,addressNum,address,deliveryRequestLbl,deliveryRequest].forEach{
            shippingInformationView.addSubview($0)
        }
        [paymentInformationTit,paymentMethodLbl,paymentMethod,orderTotalPriceLbl,orderTotalPrice,priceDetailView].forEach{
            paymentInformationView.addSubview($0)
        }
        [productPriceLbl,productPrice,deliveryPriceLbl,deliveryPrice,couponDiscountLbl,couponDiscount,pointLbl,point].forEach{
            priceDetailView.addSubview($0)
        }
        [earnTextReviewLbl,earnTextReview,earnPhotoReviewLbl,earnPhotoReview].forEach{
            savedPointView.addSubview($0)
        }
    }
    func setLayout(){
        titLbl.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.left.right.equalToSuperview()
        }
        subTit.snp.makeConstraints {
            $0.top.equalTo(titLbl.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
        }
        scrlView.snp.makeConstraints {
            $0.top.equalTo(subTit.snp.bottom).offset(50)
            $0.left.right.bottom.equalToSuperview()
        }
        shippingInformationView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        shippingTit.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10 * screenRatio)
            $0.left.equalToSuperview().offset(margin2)
        }
        shippingLineView.snp.makeConstraints {
            $0.top.equalTo(shippingTit.snp.bottom).offset(10 * screenRatio)
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
        }
        deliveryRequest.snp.makeConstraints {
            $0.top.equalTo(deliveryRequestLbl)
            $0.left.equalTo(recipient)
            $0.bottom.equalToSuperview().offset(-20)
        }
        // 결제 정보
        paymentInformationView.snp.makeConstraints {
            $0.top.equalTo(shippingInformationView.snp.bottom).offset(40 * screenRatio)
            $0.left.right.equalToSuperview()
        }
        paymentInformationTit.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10 * screenRatio)
            $0.left.equalToSuperview().offset(margin2)
        }
        paymentMethodLbl.snp.makeConstraints {
            $0.top.equalTo(paymentInformationTit.snp.bottom).offset(13 * screenRatio)
            $0.left.equalToSuperview().offset(margin2)
        }
        paymentMethod.snp.makeConstraints {
            $0.top.equalTo(paymentMethodLbl)
            $0.right.equalToSuperview().offset(-margin2)
        }
        orderTotalPriceLbl.snp.makeConstraints {
            $0.top.equalTo(paymentMethod.snp.bottom).offset(13 * screenRatio)
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
            $0.top.equalToSuperview().offset(10 * screenRatio)
            $0.left.equalToSuperview().offset(margin2)
        }
        productPrice.snp.makeConstraints {
            $0.top.equalTo(productPriceLbl)
            $0.right.equalToSuperview().offset(-margin2)
        }
        deliveryPriceLbl.snp.makeConstraints {
            $0.top.equalTo(productPriceLbl.snp.bottom).offset(10 * screenRatio)
            $0.left.equalToSuperview().offset(margin2 )
        }
        deliveryPrice.snp.makeConstraints {
            $0.top.equalTo(deliveryPriceLbl)
            $0.right.equalToSuperview().offset(-margin2)
        }
        couponDiscountLbl.snp.makeConstraints {
            $0.top.equalTo(deliveryPriceLbl.snp.bottom).offset(10 * screenRatio)
            $0.left.equalToSuperview().offset(margin2 )
        }
        couponDiscount.snp.makeConstraints {
            $0.top.equalTo(couponDiscountLbl)
            $0.right.equalToSuperview().offset(-margin2)
        }
        pointLbl.snp.makeConstraints {
            $0.top.equalTo(couponDiscountLbl.snp.bottom).offset(10 * screenRatio)
            $0.left.equalToSuperview().offset(margin2)
        }
        point.snp.makeConstraints {
            $0.top.equalTo(pointLbl)
            $0.right.equalToSuperview().offset(-margin2)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        savedPointLbl.snp.makeConstraints {
            $0.top.equalTo(paymentInformationView.snp.bottom).offset(50 * screenRatio)
            $0.left.equalToSuperview().offset(margin2)
        }
        savedPoint.snp.makeConstraints {
            $0.top.equalTo(savedPointLbl)
            $0.right.equalToSuperview().offset(-margin2)
        }
        savedPointView.snp.makeConstraints {
            $0.top.equalTo(savedPointLbl.snp.bottom).offset(20 * screenRatio)
            $0.left.right.equalToSuperview()
            $0.width.equalTo(screenBounds.width)
            $0.bottom.equalToSuperview().offset(-150 * screenRatio)
        }
        earnTextReviewLbl.snp.makeConstraints {
            $0.bottom.equalTo(savedPointView.snp.centerY).offset(-5 * screenRatio)
            $0.left.equalToSuperview().offset(margin2)
        }
        earnTextReview.snp.makeConstraints {
            $0.top.equalTo(earnTextReviewLbl)
            $0.right.equalToSuperview().offset(-margin2)
        }
        earnPhotoReviewLbl.snp.makeConstraints {
            $0.top.equalTo(savedPointView.snp.centerY).offset(5)
            $0.left.equalToSuperview().offset(margin2)
        }
        earnPhotoReview.snp.makeConstraints {
            $0.top.equalTo(earnPhotoReviewLbl)
            $0.right.equalToSuperview().offset(-margin2)
            $0.bottom.equalToSuperview().offset(-10)
        }
        homeBtn.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(100)
        }
    }
 
}
