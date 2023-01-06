//
//  DeliveryListProductTableViewCell.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/12/27.
//

import UIKit
import Foundation

class DeliveryListProductTableViewCell: UITableViewCell {
    static let cellId = "DeliveryListCellId"
    var orderDetailBtnTapped:(() -> Void)?
    var deliveryTrackingTapped: (() -> Void)?
    var exchangeBtnTapped: (() -> Void)?
    var infoDic = [String:Any]()
    let common = CommonS()
    let margin = 17.0
    let screenBounds = UIScreen.main.bounds
    let pointSize = CGSize(width: 4, height: 4)
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
    lazy var lineView = UIView().then{
        $0.backgroundColor = common.lightGray()
    }
    lazy var countLbl = UILabel().then{
        $0.textColor = common.pointColor()
        $0.font = common.setFont(font: "bold", size: 15)
        $0.text = "총 0개"
        $0.asColor(targetStringList: ["총","개"], color: common.setColor(hex: "#b1b1b1"))
    }
    lazy var orderDetailBtn = UIButton().then{
        $0.setTitle("주문 상세 >", for: .normal)
        $0.setTitleColor(common.pointColor(), for: .normal)
        $0.titleLabel?.font = common.setFont(font: "semibold", size: 15)
        $0.accessibilityLabel = "hi"
    }
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    

    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, dicArr: [String:Any]) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("시작")
        print(common.dicToJsonString(dic: dicArr))
        print("끝")
        contentView.isUserInteractionEnabled = true
        self.infoDic = dicArr
        setOrder()
        addSubviewFunc()
        setLayout()
     
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setOrder(){
        let decoder = JSONDecoder()
        do {
            var data = common.dicToJsonString(dic: infoDic).data(using: .utf8)
            print(common.dicToJsonString(dic: infoDic))
            if let data = data, let order = try? decoder.decode(Order.self, from: data) {
                setCell(order: order)
            }else {
                print("실패")
            }
        } catch {
            print(error)
        }
    }
    func setCell(order: Order) {
        for i in 0...order.items.count - 1 {
            lazy var topLineView = UIView().then{
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
            
            lazy var companyNameLbl = UILabel().then{
                $0.font = common.setFont(font: "bold", size: 10)
                $0.textColor = common.setColor(hex: "b1b1b1")
                $0.text = "강재혁"
            }
            lazy var productNameLbl = UILabel().then{
                $0.font = common.setFont(font: "semibold", size: 15)
                $0.textColor = common.setColor(hex: "6f6f6f")
                $0.text = "강재혁"
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
            lazy var itemView: UIView = {
                let view = UIView()
                return view
            }()
            [topLineView,situationBtn,productInfoView,progressBarView,deliveryTrackingBtn,exchangeBtn].forEach {
                itemView.addSubview($0)
            }
            [imgView,companyNameLbl,productNameLbl,starImgView,ratingLbl,priceLbl].forEach{
                productInfoView.addSubview($0)
            }
            [readyLbl,readyPoint,startBar,startLbl,shippingBar,startPoint,arrivalBar,shippingLbl,shippingPoint,arrivalLbl,arrivalPoint].forEach{
                progressBarView.addSubview($0)
            }
            topLineView.snp.makeConstraints {
                $0.top.left.right.equalToSuperview()
                $0.height.equalTo(2)
            }
            situationBtn.snp.makeConstraints{
                $0.top.equalTo(topLineView.snp.bottom).offset(12)
                $0.left.equalToSuperview().offset(margin)
                $0.height.equalTo(screenBounds.width/21.0)
                $0.width.equalTo(margin + screenBounds.width/7.0)
            }
            productInfoView.snp.makeConstraints{
                $0.left.right.equalToSuperview()
                $0.top.equalTo(situationBtn.snp.bottom).offset(12)
                $0.height.equalTo(screenBounds.width*2.0/9.0)
            }
            imgView.snp.makeConstraints{
                $0.top.bottom.equalToSuperview()
                $0.left.equalToSuperview().offset(margin)
                $0.width.equalTo(screenBounds.width/6.0)
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
            
            progressBarView.snp.makeConstraints{
                $0.top.equalTo(productInfoView.snp.bottom).offset(36.0)
                $0.left.right.equalToSuperview()
                $0.height.equalTo(30)
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
                $0.top.equalTo(progressBarView.snp.bottom).offset(margin)
                $0.right.equalToSuperview().offset(-margin)
                $0.size.equalTo(btnSize)
                $0.bottom.equalToSuperview().offset(-12)
            }
            deliveryTrackingBtn.snp.makeConstraints{
                $0.bottom.equalToSuperview().offset(-12)
                $0.top.equalTo(progressBarView.snp.bottom).offset(margin)
                $0.right.equalTo(exchangeBtn.snp.left).offset(-10)
                $0.size.equalTo(btnSize)
            }
            
            stackView.addArrangedSubview(itemView)
            
            // set
            guard let encodedthumbnailURL = order.items[i].product.thumbnail.url.description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
            print(order.items[i].product.thumbnail.url)
            common.setImageUrl(url: encodedthumbnailURL, imageView: imgView)
            companyNameLbl.text = order.items[i].brand.name
            productNameLbl.text = order.items[i].product.name
            priceLbl.text = "\(common.numberFormatter(number: order.items[i].total.price.sale.raw))원 | \(order.items[0].quantity.raw)개"
            countLbl.text = "총 \(order.items.count)개"
            orderNumberLabel.text = "주문번호 \(order.id)"
            dateLbl.text =  order.createdAt.raw.components(separatedBy: "T")[0]
            let fulfillmentsArr = order.fulfillments
            if fulfillmentsArr.count != 0 {
                let fulfillStatus = fulfillmentsArr[0].status
                if fulfillStatus == "pending" {
                    startBar.backgroundColor = common.pointColor()
                    situationBtn.setTitle("배송시작", for: .normal)
                }else if fulfillStatus == "shipped" {
                    startBar.backgroundColor = common.pointColor()
                    shippingBar.backgroundColor = common.pointColor()
                    situationBtn.setTitle("배송중", for: .normal)
                }else if fulfillStatus == "arrived" {
                    startBar.backgroundColor = common.pointColor()
                    shippingBar.backgroundColor = common.pointColor()
                    arrivalBar.backgroundColor = common.pointColor()
                    situationBtn.setTitle("도착예정", for: .normal)
                }else {
                    startBar.backgroundColor = common.pointColor()
                    shippingBar.backgroundColor = common.pointColor()
                    arrivalBar.backgroundColor = common.pointColor()
                    situationBtn.setTitle("배송완료", for: .normal)
                }
            }else {
                if order.status == "placed" {
                    situationBtn.setTitle("결제대기", for: .normal)
                    deliveryTrackingBtn.snp.remakeConstraints {
                        $0.edges.equalTo(exchangeBtn)
                    }
                    exchangeBtn.isHidden = true
                }else if order.status == "paid" {
                    
                }else if order.status == "cancelled" {
                    situationBtn.setTitle("주문취소", for: .normal)
                    exchangeBtn.isHidden = true
                    deliveryTrackingBtn.isHidden = true
                    deliveryTrackingBtn.snp.remakeConstraints {
                        $0.edges.equalTo(exchangeBtn)
                    }
                }else {
                    situationBtn.setTitle("결제오류", for: .normal)
                    deliveryTrackingBtn.snp.remakeConstraints {
                        $0.edges.equalTo(exchangeBtn)
                    }
                    exchangeBtn.isHidden = true
                }
            }
            self.orderDetailBtn.addTarget(self, action: #selector(touchOrderDetailBtn), for: .touchUpInside)
            exchangeBtn.addTarget(self, action: #selector(touchExchangeBtn), for: .touchUpInside)
            deliveryTrackingBtn.addTarget(self, action: #selector(touchDeliveryTrackingBtn), for: .touchUpInside)
            //버튼 액션 클로저
            deliveryTrackingTapped = { [self] in
                if fulfillmentsArr.count != 0 {
                    let uid =  fulfillmentsArr[0].tracking.uid
                    UIApplication.shared.open(URL(string: "http://nplus.doortodoor.co.kr/web/detail.jsp?slipno=\(uid)")!)
                }else {
                    self.parentViewController?.present(self.common2.alert(title: "", message: "배송 준비중입니다"), animated: true)
                }
            }
            exchangeBtn.tag = i
            print(exchangeBtn.tag)
            exchangeBtn.addTarget(self, action: #selector(touchExchangeBtn(sender:)), for: .touchUpInside)
            orderDetailBtnTapped = {
                let vc = OrderDetailViewController(orderId: order.id)
                self.parentViewController?.navigationController?.pushViewController(vc, animated: true)
            }
            if order.refunds.count != 0 {
                for i in 0...order.items.count - 1 {
                    for x in 0...order.refunds[i].items.count - 1 {
                        if order.refunds[0].items[x].item.id == order.items[i].id {
                            situationBtn.setTitle(returnStatus(status: order.refunds[i].status), for: .normal)
                            if order.refunds[0].status == "requested" {
                                situationBtn.backgroundColor = common.setColor(hex: "#ffbc00")
                            }else if order.refunds[0].status == "accepted" {
                                situationBtn.backgroundColor = common.setColor(hex: "#ffbc00")
                            }else if order.refunds[0].status == "cancelled" {
                                situationBtn.backgroundColor = common.setColor(hex: "#ffbc00")
                            }else if order.refunds[0].status == "refunded" {
                                situationBtn.backgroundColor = common.setColor(hex: "#36dc69")
                            }
                            deliveryTrackingBtn.snp.remakeConstraints {
                                $0.edges.equalTo(exchangeBtn)
                            }
                            exchangeBtn.isHidden = true
                        }
                    }
                }
            }
        }
    }
    func returnStatus(status:String) -> String {
        if status == "requested" {
            return "환불신청"
        }else if status == "accepted" {
            return "환불승인"
        }else if status == "cancelled" {
            return "환불취소"
        }else if status == "refunded" {
            return "환불완료"
        }else {
            return ""
        }
    }
    func addSubviewFunc(){
        [lineView,dateLbl,orderNumberLabel,countLbl,orderDetailBtn,stackView].forEach{
            self.addSubview($0)
        }
    }
    func setLayout(){
        dateLbl.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(margin)
        }
        orderNumberLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(margin)
            $0.right.equalToSuperview().offset(-margin)
        }
        lineView.snp.makeConstraints{
            $0.top.equalTo(dateLbl.snp.bottom).offset(10)
            $0.height.equalTo(2)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
        countLbl.snp.makeConstraints {
            $0.centerY.equalTo(orderDetailBtn)
            $0.left.equalToSuperview().offset(margin)
        }
        orderDetailBtn.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(10)
            $0.right.equalToSuperview().offset(-margin)
        }
        stackView.snp.makeConstraints {
            $0.top.equalTo(orderDetailBtn.snp.bottom).offset(10)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    @objc func touchOrderDetailBtn(){
        print("탭")
        orderDetailBtnTapped?()
    }
    @objc func touchExchangeBtn(sender: UIButton){
//        print("탭")
//        exchangeBtnTapped?()
        guard let itemDicArr = infoDic["items"] as? [[String:Any]],
              let orderId = infoDic["_id"] as? String
        else {return}
        var itemDic = itemDicArr[sender.tag]
        
        print(sender.tag)
        itemDic.updateValue(orderId, forKey: "order_id")
        let vc = ReturnProductViewController(infoDic: itemDic)
        self.parentViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func touchDeliveryTrackingBtn(){
        print("탭")
        deliveryTrackingTapped?()
    }

}
