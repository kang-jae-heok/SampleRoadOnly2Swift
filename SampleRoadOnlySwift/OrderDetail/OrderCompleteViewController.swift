//
//  orderCompleteViewController.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/11/08.
//

import Foundation
import UIKit
import zaiclient

class OrderCompleteViewController: UIViewController {
    let common = CommonS()
    let orderCompleteView = OrderCompleteView()
    var initDic = [String:Any]()
    var orderDetailDic = [String:Any]()

    @objc init(initDic: [String:Any]) {
        super.init(nibName: nil, bundle: nil)
        self.initDic = initDic
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        view = orderCompleteView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("결제정보")
        print(common.dicToJsonString(dic: initDic))
        setText()
        getToken()
        addAi()
        setTarget()
        
        
    }
    func addAi(){
        guard let orderDic = initDic["order"] as? [String:Any],
              let items = orderDic["items"] as? [[String:Any]]
        else {return}
        do {
            let zaiClient = try ZaiClient(zaiClientID: self.clientId, zaiSecret: self.clientSecret)
            for i in 0...items.count - 1 {
                guard let id = items[i]["_id"] as? String,
                      let price = items[i]["price"] as? [String:Any],
                      let sale = price["sale"] as? Int
                else {return}
                let productDetailViewEvent = try PurchaseEvent(userId: customerId2, itemId: id, price: sale)
              zaiClient.addEventLog(productDetailViewEvent) {
                (res, err) in if let error = err {
                    print(error)
                }
                  print(res)
                  print("성공")
              }

            }
        } catch let error {
            print("에러")
          print(error.localizedDescription)
        }
    }
    func setText(){
        orderCompleteView.titLbl.text = "주문완료"
        orderCompleteView.subTit.text = "결제가 완료되었습니다"
    }
    func setTarget(){
        orderCompleteView.backBtn.addTarget(self, action: #selector(touchHomeBtn), for: .touchUpInside)
    }
    func setInfo2(){
        guard let orderDic = initDic["order"] as? [String:Any],
              let totalDic = orderDic["total"] as? [String:Any],
              let customerDic = orderDic["customer"] as? [String:Any],
              let nameDic = customerDic["name"] as? [String:Any],
              let addressDic = orderDic["address"] as? [String:Any],
              let shippingDic = addressDic["shipping"] as? [String:Any],
              let totalShippingDic = totalDic["shipping"] as? [String:Any],
              let feeDic = totalShippingDic["fee"] as? [String:Any],
              let deliveryPrice = feeDic["original"] as? Int,
              let buyerNameDic = shippingDic["name"] as? [String:Any],
              let totalItemsDic = totalDic["items"] as? [String:Any],
              let totalItemsPriceDic = totalItemsDic["price"] as? [String:Any],
              let amount = totalDic["amount"] as? Int,
              let totalItemsPrice = totalItemsPriceDic["original"] as? Int,
              let buyerName = buyerNameDic["full"] as? String,
              let mobile = shippingDic["mobile"] as? String,
              let address1 = shippingDic["address1"] as? String,
              let address2 = shippingDic["address2"] as? String,
              let postCode = shippingDic["postcode"] as? String,
              let request = orderDic["request"] as? String,
              let discounted = totalDic["discounted"] as? Int
        else {return}
        if let payMethod = initDic["payMethod"] as? String {
            if payMethod == "card" {
                if orderDetailDic["emb_pg_provider"] is NSNull {
                    guard let cardName = orderDetailDic["card_name"] as? String else {return}
                    orderCompleteView.paymentMethod.text = "\(cardName)"
                }else {
                    guard let pay =  orderDetailDic["emb_pg_provider"] as? String else {return}
                    orderCompleteView.paymentMethod.text = "\(pay)"
                }
            }else if payMethod == "trans" {
                orderCompleteView.paymentMethod.text = "실시간 계좌이체"
            }else if payMethod == "vbank" {
                print(initDic)
                guard let vbankName = orderDetailDic["vbank_name"] as? String else {return}
                guard let vbankNum = orderDetailDic["vbank_num"] as? String else {return}
                orderCompleteView.paymentMethod.text = "가상계좌\n\(vbankName) \(vbankNum)"
            }
            orderCompleteView.recipient.text = buyerName
            orderCompleteView.telNum.text = mobile
            orderCompleteView.addressNum.text = postCode
            orderCompleteView.address.text = address1 + " " + address2
            orderCompleteView.deliveryRequest.text = request
            orderCompleteView.addressNum.text = postCode
            orderCompleteView.orderTotalPrice.text = common.numberFormatter(number: amount) + "원"
            orderCompleteView.orderTotalPrice.asColor(targetStringList: ["원"], color: .black)
            orderCompleteView.productPrice.text = common.numberFormatter(number: totalItemsPrice) + "원"
            orderCompleteView.deliveryPrice.text = common.numberFormatter(number: deliveryPrice) + "원"
            orderCompleteView.couponDiscount.text = "-\(common.numberFormatter(number: discounted))원"
        }
        orderCompleteView.subInfoView.isHidden = true
        orderCompleteView.shippingInformationView.snp.remakeConstraints {
            $0.top.left.right.equalToSuperview()
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
            self.getInfo(token: token)
        }
    }
    func getInfo(token:String) {
        guard let merchantUid = initDic["merchant_uid"] as? String else {return}
        common2.iamportSendRequest(url: "https://api.iamport.kr/payments/find/\(merchantUid)", method: "get", params: [:], sender: token) { resultJson in
            guard let resultDic = resultJson as? [String:Any] else {return}
            if resultDic["response"] != nil {
                guard let responseDic = resultDic["response"] as? [String:Any] else {return}
                self.orderDetailDic = responseDic
                print(responseDic)
                self.setInfo2()
            }
        }
    }
    @objc func touchHomeBtn(){
        //주문중에서 나갔을때
        func checkOrder(){
            if UserDefaults.contains("merchant_uid") {
                var params = [String:Any]()
                let orderId = UserDefaults.standard.string(forKey: "merchant_uid") ?? ""
                guard let byString = UserDefaults.standard.string(forKey: "pay_callback") else {return}
                var by = String()
                if byString == "failed-customer" {
                    by = "customer"
                }else {
                    by = "store"
                }
                params.updateValue(by, forKey: "by")
                params.updateValue("", forKey: "reason")
                UserDefaults.standard.removeObject(forKey: "pay_callback")
                common.sendRequest(url: "https://api.clayful.io/v1/orders/\(orderId)/cancellation", method: "post", params: params, sender: "") { resultJson in
                    print(resultJson)
                    UserDefaults.standard.removeObject(forKey: "merchant_uid")
                    UserDefaults.standard.removeObject(forKey: "coupon")
                }
            }
        }
        Common.goMain()
    }

}
extension OrderCompleteViewController {
//    guard let orderDic = infoDic["order"] as? [String:Any],
//          let totalDic = orderDic["total"] as? [String:Any],
//          let customerDic = orderDic["customer"] as? [String:Any],
//          let nameDic = customerDic["name"] as? [String:Any],
//          let addressDic = orderDic["address"] as? [String:Any],
//          let shippingDic = addressDic["shipping"] as? [String:Any],
//          let buyerNameDic = shippingDic["name"] as? [String:Any],
//          let productName = infoDic["name"] as? String,
//          let merchantUid = infoDic["merchant_uid"] as? String,
//          let payMethod = infoDic["payMethod"] as? String,
//          let amount = totalDic["amount"] as? Int,
//          let email = customerDic["email"] as? String,
//          let buyerName = buyerNameDic["full"] as? String,
//          let mobile = shippingDic["mobile"] as? String,
//          let address1 = shippingDic["address1"] as? String,
//          let address2 = shippingDic["address2"] as? String,
//          let postCode = shippingDic["postcode"] as? String
//    else {return}
}
