//
//  ReturnProductViewController.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/11/22.
//

import UIKit

class ReturnProductViewController: UIViewController {
    let returnProductView = ReturnProductView()
    var itemsInfoDic = [String:Any]()
    var orderDetailDic = [String:Any]()
    public init(infoDic: [String:Any]) {
        super.init(nibName: nil, bundle: nil)
        self.itemsInfoDic = infoDic
    }
    required init?(coder: NSCoder) {
        fatalError("init-fail")
    }
    
    override func loadView() {
        super.loadView()
        view = returnProductView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("#######items")
        print(common2.dicToJsonString(dic: itemsInfoDic))
        setTarget()
        getToken()
    }
    func setTarget() {
        returnProductView.yesBtn.addTarget(self, action: #selector(touchYesBtn), for: .touchUpInside)
        returnProductView.topView.backBtn.addTarget(self, action: #selector(touchBackBtn), for: .touchUpInside)
        returnProductView.homeBtn.addTarget(self, action: #selector(touchBackBtn), for: .touchUpInside)
    }
    func setData(){
        guard let productInfo = itemsInfoDic["product"] as? [String:Any] else {return}
        // 셀 이미지
        guard let thumbnailInfo = productInfo["thumbnail"] as? [String:Any] else {return}
        guard let thumbnailURL = thumbnailInfo["url"] as? String else {return}
        guard let encodedthumbnailURL = thumbnailURL.description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        //셀 회사 이름
        guard let companyInfo = itemsInfoDic["brand"] as? [String:Any] else {return}
        guard let companyName = companyInfo["name"] as? String else {return}
        // 셀 상품 이름
        guard let productInfoDic = itemsInfoDic["product"]  as? [String:Any] else {return}
        guard let productName = productInfoDic["name"] as? String else {return}
        //셀 상품 가격
        guard let totalInfoDic = itemsInfoDic["total"] as? [String:Any],
              let discountedDic = totalInfoDic["discounted"] as? [String:Any],
              let rawDiscounted = discountedDic["raw"] as? Int
        else {return}
        guard let priceInfoDic = totalInfoDic["price"] as? [String:Any] else {return}
        guard let salePriceDic = priceInfoDic["sale"] as? [String:Any] else {return}
        guard let rawPrice = salePriceDic["raw"] as? Int else {return}
        //셀 상품 개수
        guard let quantityDic = itemsInfoDic["quantity"] as? [String:Any] else {return}
        guard let rawQuantity = quantityDic["raw"] as? Int else {return}
        // 셀 오더 아이디
        guard let orderId = itemsInfoDic["order_id"] as? String else {return}
        //환불 수단
        guard let payMethod = orderDetailDic["pay_method"] as? String else {return}
        print("#####payMethod")
        print(payMethod)
        if payMethod == "card" {
            print("여기")
            print(orderDetailDic)
            if orderDetailDic["emb_pg_provider"] is NSNull {
                guard let cardName = orderDetailDic["card_name"] as? String else {return}
                returnProductView.returnMethod.text = "\(cardName)"
            }else {
                guard let pay =  orderDetailDic["emb_pg_provider"] as? String else {return}
                returnProductView.returnMethod.text = "\(pay)"
            }
        }else if payMethod == "trans" {
            returnProductView.returnMethod.text = "실시간 계좌이체"
        }else if payMethod == "vbank" {
            guard let vbankName = orderDetailDic["vbank_name"] as? String else {return}
            guard let vbankNum = orderDetailDic["vbank_num"] as? String else {return}
            returnProductView.returnMethod.text = "가상계좌\n\(vbankName) \(vbankNum)"
        }
        
        returnProductView.deliveryNumLbl.text = "주문번호 " + orderId
        common2.setImageUrl(url: encodedthumbnailURL, imageView: returnProductView.productImgView)
        returnProductView.companyNameLbl.text = companyName
        returnProductView.productNameLbl.text = productName
        returnProductView.priceLbl.text = String(common2.numberFormatter(number: rawPrice)) + "원 | \(rawQuantity)개"
        returnProductView.couponDiscount.text = "\(common2.numberFormatter(number: rawDiscounted))원"
        returnProductView.returnPrice.text = String(common2.numberFormatter(number: rawPrice)) + "원"
    }
    func refundOrder(){
        var itemsArr = [String]()
        var params = [String:Any]()
        var itemsDic = [String:Any]()
        
        guard let orderId = itemsInfoDic["order_id"] as? String else {return}
        guard let quantityDic = itemsInfoDic["quantity"] as? [String:Any] else {return}
        guard let rawQuantity = quantityDic["raw"] as? Int else {return}
        guard let itemId = itemsInfoDic["_id"] as? String else {return}
        itemsDic.updateValue(itemId, forKey: "item")
        itemsDic.updateValue(rawQuantity, forKey: "quantity")
//        let jsonItemDic = common2.dicToJsonString(dic: itemsDic)
        let jsonItemDic = Common.object(toJsonString: itemsDic)
        itemsArr = [jsonItemDic]
        let reason = (returnProductView.retunrReasonLbl.text ?? "") + ":" + returnProductView.reasonDetailContent.text
        params.updateValue(reason, forKey: "reason")
        params.updateValue(Common.object(toJsonString: itemsArr), forKey: "items")
        
        common2.sendRequest(url: "https://api.clayful.io/v1/orders/\(orderId)/refunds", method: "post", params: params, sender: "") { resultJson in
            print("환불완료")
            print(resultJson)
            guard let resultDic = resultJson as? [String:Any] else {return}
            if resultDic["error"] != nil {
                self.present(self.common2.alert(title: "에러", message: "이미 환불된 제품입니다"), animated: true)
            }else {
                self.navigationController?.pushViewController(CompletedViewController(type: "return"), animated: true)
            }
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
        guard let orderId = itemsInfoDic["order_id"] as? String else {return}
        common2.iamportSendRequest(url: "https://api.iamport.kr/payments/find/\(orderId)", method: "get", params: [:], sender: token) { resultJson in
            guard let resultDic = resultJson as? [String:Any] else {return}
            
            if resultDic["response"] != nil {
                guard let responseDic = resultDic["response"] as? [String:Any] else {return}
                self.orderDetailDic = responseDic
                self.setData()
            }
           
        }
    }

    @objc func touchYesBtn(){
        refundOrder()
      
    }
    @objc func touchBackBtn(){
        self.navigationController?.popViewController(animated: true)
    }
}

