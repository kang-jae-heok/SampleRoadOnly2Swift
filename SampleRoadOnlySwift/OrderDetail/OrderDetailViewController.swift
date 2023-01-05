//
//  OrderDetailViewController.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/11/10.
//

import UIKit

class OrderDetailViewController: UIViewController {
    let orderDetailView = OrderCompleteView()
    let common = CommonS()
    var orderId = String()
    var orderDetailDic = [String:Any]()

    @objc init(orderId: String) {
        super.init(nibName: nil, bundle: nil)
        self.orderId = orderId
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func loadView() {
        super.loadView()
        view = orderDetailView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("결제정보")
        setText()
        getToken()
        setTarget()
    }
    func setText(){
        orderDetailView.titLbl.text = "주문상세"
    }
    func getOrderDic() {
        print(orderId)
        common.sendRequest(url: "https://api.clayful.io/v1/orders/\(orderId)", method: "get", params: [:], sender: "") { resultJson in
            guard let orderDic: [String:Any] = resultJson as? [String : Any] else { return }
            print(orderDic)
            self.setInfo(orderDic: orderDic)
        }
    }

    func getToken(){
        var params = [String:Any]()
        params.updateValue("7205042348128009", forKey: "imp_key")
        params.updateValue("e78e7afbf7be418d3b1f45912e35fb04b976885e6b32c3eab8bf38a0d383de3ba7bbb7ec0df99ba0", forKey: "imp_secret")
        common2.iamportSendRequest(url: "https://api.iamport.kr/users/getToken", method: "post", params: params, sender: "") { resultJson in
            print("########getToken")
            guard let resultDic = resultJson as? [String:Any] else {return}
            guard let responseDic = resultDic["response"] as? [String:Any] else {return}
            guard let token = responseDic["access_token"] as? String else {return}
            self.getPaymethod(token: token)
        }
    }
    func getPaymethod(token:String) {
        common2.iamportSendRequest(url: "https://api.iamport.kr/payments/find/\(orderId)", method: "get", params: [:], sender: token) { resultJson in
            guard let resultDic = resultJson as? [String:Any] else {return}
            
            if resultDic["response"] != nil {
                guard let responseDic = resultDic["response"] as? [String:Any] else {return}
                self.orderDetailDic = responseDic
                self.getOrderDic()
            }
           
        }
    }
    func setTarget(){
        orderDetailView.backBtn.addTarget(self, action: #selector(touchHomeBtn), for: .touchUpInside)
    }
    func setInfo(orderDic: [String:Any]){
        guard let addressDic: [String:Any] = orderDic["address"] as? [String:Any] else {return}
        guard let addressShippingDic: [String:Any] = addressDic["shipping"] as? [String:Any] else {return}
        guard let nameDic: [String:Any] = addressShippingDic["name"] as? [String:Any] else {return}
        guard let totalDic: [String:Any] = orderDic["total"] as? [String:Any] else {return}
        guard let priceDic: [String:Any] = totalDic["price"] as? [String:Any] else {return}
        guard let originalPriceDic: [String:Any] = priceDic["original"] as? [String:Any] else {return}
        guard let shippingDic: [String:Any] = totalDic["shipping"] as? [String:Any] else {return}
        guard let shippingFeeDic: [String:Any] = shippingDic["fee"] as? [String:Any] else {return}
        guard let shippingFeeOriginalDic: [String:Any] = shippingFeeDic["original"] as? [String:Any] else {return}
        guard let itemsDic: [String:Any] = totalDic["items"] as? [String:Any] else {return}
        guard let itemsPrice: [String:Any] = itemsDic["price"] as? [String:Any] else {return}
        guard let itemsPriceOriginalDic: [String:Any] = itemsPrice["original"] as? [String:Any] else {return}
        guard let sale = priceDic["sale"] as? [String:Any],
              let salePrice = sale["raw"] as? Int,
              let discounted = totalDic["discounted"] as? [String:Any],
              let discountPrice = discounted["raw"] as? Int
        else {return}
        
        
        
        

        
        guard let name: String = nameDic["full"] as? String else {return}
        guard let telNum: String = addressShippingDic["mobile"] as? String else {return}
        guard let postcode: String = addressShippingDic["postcode"] as? String else {return}
        guard let address1: String = addressShippingDic["address1"] as? String else {return}
        guard let address2: String = addressShippingDic["address2"] as? String else {return}
        var request2 = String()
        if let request: String = orderDic["request"] as? String {
            request2 = request
        }else {
            request2 = ""
        }
            
        guard let totalPrice: Int = originalPriceDic["raw"] as? Int else {return}
        guard let itmesPrice: Int = itemsPriceOriginalDic["raw"] as? Int else {return}
        guard let shippingPrice: Int = shippingFeeOriginalDic["raw"] as? Int else {return}
        print(priceDic)
        print(totalDic)
        print(originalPriceDic)
        print(totalPrice)
        orderDetailView.recipient.text = name
        orderDetailView.telNum.text = telNum
        orderDetailView.addressNum.text = postcode
        orderDetailView.address.text = address1 + address2
        orderDetailView.deliveryRequest.text = request2
        //추후에 작업해야됨
        
        guard let payMethod = orderDetailDic["pay_method"] as? String else {return}
        print("#####payMethod")
        print(payMethod)
        if orderDetailDic["emb_pg_provider"] is NSNull {
            if payMethod == "card" {
                print("####cardDic")
                print(common.dicToJsonString(dic: orderDetailDic) )
                if let cardName = orderDetailDic["card_name"] as? String{
                    orderDetailView.paymentMethod.text = "\(cardName)"
                } else {
                    orderDetailView.paymentMethod.text = ""
                    orderDetailView.paymentMethodLbl.text = ""
                }
            }else if payMethod == "trans" {
                orderDetailView.paymentMethod.text = "실시간 계좌이체"
            }else if payMethod == "vbank" {
                print(orderDic)
                guard let vbankName = orderDetailDic["vbank_name"] as? String else {return}
                guard let vbankNum = orderDetailDic["vbank_num"] as? String else {return}
                orderDetailView.paymentMethod.text = "가상계좌\n\(vbankName) \(vbankNum)"
            }
        }else {
            guard let pay =  orderDetailDic["emb_pg_provider"] as? String else {return}
            orderDetailView.paymentMethod.text = "\(pay)"
        }
       
        orderDetailView.orderTotalPrice.text = common.numberFormatter(number: salePrice) + "원"
        orderDetailView.productPrice.text = common.numberFormatter(number: itmesPrice) + "원"
        orderDetailView.deliveryPrice.text = common.numberFormatter(number: shippingPrice) + "원"
        orderDetailView.couponDiscount.text = "-\(common.numberFormatter(number: discountPrice))원"
        let decoder = JSONDecoder()
        do {
            var data = common.dicToJsonString(dic: orderDic).data(using: .utf8)
            print("여기")
            print(common.dicToJsonString(dic: orderDic))
            print("끝")
            if let data = data, let order = try? decoder.decode(Order.self, from: data) {
                print("성공")
                print(order)
                setProductInfo(order: order)
            }else {
                print("실패")
            }
        } catch {
            print(error)
        }
    }
    func setProductInfo(order: Order) {
        for i in 0...order.items.count - 1 {
            let productInfoView = UIView()
            let productImgView = UIImageView()
            let situationLbl = UILabel().then {
                $0.backgroundColor = common.pointColor()
                $0.text = "배송준비"
                $0.font = common.setFont(font: "bold", size: 13)
                $0.textAlignment = .center
                $0.textColor = .white
                $0.layer.cornerRadius = 8
                $0.clipsToBounds = true
            }
            lazy var companyNameLbl = UILabel().then{
                $0.font = common.setFont(font: "bold", size: 10)
                $0.textColor = common.setColor(hex: "b1b1b1")
                $0.text = order.items[i].brand.name
            }
            lazy var productNameLbl = UILabel().then{
                $0.font = common.setFont(font: "semibold", size: 15)
                $0.textColor = common.setColor(hex: "6f6f6f")
                $0.text = order.items[i].product.name
            }
            lazy var priceLbl = UILabel().then{
                $0.font = common.setFont(font: "bold", size: 17)
                $0.textColor = common.setColor(hex: "#6f6f6f")
                $0.text = "\(common.numberFormatter(number: order.items[i].total.price.sale.raw))원 | \(order.items[0].quantity.raw)개"
            }
            lazy var deleteOrderBtn = UIButton().then {
                $0.backgroundColor = .white
                $0.titleLabel?.font = common.setFont(font: "bold", size: 13)
                $0.setTitleColor(common.setColor(hex: "#6f6f6f"), for: .normal)
                $0.setTitle("주문취소", for: .normal)
                $0.isHidden = true
            }
            guard let encodedthumbnailURL = order.items[i].product.thumbnail.url.description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
            print(encodedthumbnailURL)
            common.setImageUrl(url: encodedthumbnailURL, imageView: productImgView)
            let fulfillmentsArr = order.fulfillments
            if fulfillmentsArr.count != 0 {
                let fulfillStatus = fulfillmentsArr[0].status
                if fulfillStatus == "pending" {
                    situationLbl.text = "배송시작"
                }else if fulfillStatus == "shipped" {
                    situationLbl.text = "배송시작"
                }else if fulfillStatus == "arrived" {
                    situationLbl.text = "도착예정"
                }else {
                    situationLbl.text = "배송완료"
                }
            }else {
                if order.status == "placed" {
                    situationLbl.text = "결제대기"
                    deleteOrderBtn.isHidden = false
                }else if order.status == "paid" {
                    
                }else if order.status == "cancelled" {
                    situationLbl.text = "주문취소"
                }else {
                    situationLbl.text = "결제오류"
                    deleteOrderBtn.isHidden = false
                }
            }
            if order.refunds.count != 0 {
                for i in 0...order.refunds.count - 1 {
                    for x in 0...order.refunds[i].items.count - 1 {
                        if order.refunds[i].items[x].item.id == order.id {
                            situationLbl.text = returnStatus(status: order.refunds[i].status)
                            if order.refunds[i].status == "requested" {
                                situationLbl.backgroundColor = common.setColor(hex: "#ffbc00")
                            }else if order.refunds[i].status == "accepted" {
                                situationLbl.backgroundColor = common.setColor(hex: "#ffbc00")
                            }else if order.refunds[i].status == "cancelled" {
                                situationLbl.backgroundColor = common.setColor(hex: "#ffbc00")
                            }else if order.refunds[i].status == "refunded" {
                                situationLbl.backgroundColor = common.setColor(hex: "#36dc69")
                            }
                        }
                    }
                }
            }
            situationLbl.backgroundColor = common.gray()
            [productImgView,situationLbl,companyNameLbl,productNameLbl,priceLbl,deleteOrderBtn].forEach {
                productInfoView.addSubview($0)
            }
            productImgView.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.left.equalToSuperview().offset(margin2)
                $0.bottom.equalTo(situationLbl.snp.top)
                $0.width.equalTo(screenBounds2.width/6.0)
            }
            situationLbl.snp.makeConstraints {
                $0.bottom.equalToSuperview().offset(-5)
                $0.left.equalTo(productImgView)
                $0.width.equalTo(margin2 + screenBounds2.width/7.0)
                $0.height.equalTo(18 * screenRatio)
            }
            companyNameLbl.snp.makeConstraints {
                $0.top.equalTo(productImgView).offset(5)
                $0.left.equalTo(productImgView.snp.right).offset(10)
            }
            productNameLbl.snp.makeConstraints {
                $0.top.equalTo(companyNameLbl.snp.bottom).offset(5)
                $0.left.equalTo(productImgView.snp.right).offset(10)
            }
            priceLbl.snp.makeConstraints {
                $0.bottom.equalTo(productImgView).offset(-5)
                $0.left.equalTo(productNameLbl)
            }
            if i == order.items.count - 1 {
                deleteOrderBtn.snp.makeConstraints {
                    $0.centerY.equalTo(priceLbl)
                    $0.right.equalToSuperview().offset(-margin2)
                    $0.size.equalTo(CGSize(width: 70 , height: 25 ))
                }
                deleteOrderBtn.addTarget(self, action: #selector(touchDeleteBtn(sender:)), for: .touchUpInside)
            }
           
            
            orderDetailView.stackView.addArrangedSubview(productInfoView)
            productInfoView.snp.makeConstraints {
                $0.height.equalTo(screenBounds2.width*2.0/9.0)
            }
        }
        orderDetailView.dateLbl.text =  order.createdAt.raw.components(separatedBy: "T")[0]
        orderDetailView.orderNumberLabel.text = "주문번호 " + order.id
        orderDetailView.priceDetailView.snp.remakeConstraints {
            $0.top.equalTo(orderDetailView.orderTotalPriceLbl.snp.bottom).offset(10 * screenRatio)
            $0.left.right.bottom.equalToSuperview()
        }
        orderDetailView.layoutIfNeeded()
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
    @objc func touchDeleteBtn(sender: UIButton){
        let alert = UIAlertController(title: "삭제", message: "정말로 주문을 삭제하시나요?", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "네", style: .default) { (action) in
            self.common.sendRequest(url: "https://api.clayful.io/v1/orders/\(self.orderId)", method: "delete", params: [:], sender: "") { _ in
                self.navigationController?.popViewController(animated: true)
            }
        }
        let noAction = UIAlertAction(title: "아니오", style: .default) {_ in }
        alert.addAction(okAction)
        alert.addAction(noAction)
        present(alert, animated: true, completion: nil)
    }
    @objc func touchHomeBtn(){
        self.navigationController?.popViewController(animated: true)
    }
}
