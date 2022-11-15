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
        setTarget()
        getOrderDic()
    }
    func setText(){
        orderDetailView.titLbl.text = "주문/배송"
        orderDetailView.homeBtn.setTitle("뒤로 가기", for: .normal)
    }
    func getOrderDic() {
        print(orderId)
        common.sendRequest(url: "https://api.clayful.io/v1/orders/\(orderId)", method: "get", params: [:], sender: "") { resultJson in
            guard let orderDic: [String:Any] = resultJson as? [String : Any] else { return }
            print(orderDic)
            self.setInfo(orderDic: orderDic)
        }
    }
    func setTarget(){
        orderDetailView.homeBtn.addTarget(self, action: #selector(touchHomeBtn), for: .touchUpInside)
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
        
        

        
        guard let name: String = nameDic["full"] as? String else {return}
        guard let telNum: String = addressShippingDic["mobile"] as? String else {return}
        guard let postcode: String = addressShippingDic["postcode"] as? String else {return}
        guard let address1: String = addressShippingDic["address1"] as? String else {return}
        guard let address2: String = addressShippingDic["address2"] as? String else {return}
        guard let request: String = orderDic["request"] as? String else {return}
        guard let totalPrice: Int = originalPriceDic["raw"] as? Int else {return}
        guard let itmesPrice: Int = itemsPriceOriginalDic["raw"] as? Int else {return}
        guard let shippingPrice: Int = shippingFeeOriginalDic["raw"] as? Int else {return}
        print("ㅇㅇㅇㅇ")
        print(priceDic)
        print(totalDic)
        print(originalPriceDic)
        print(totalPrice)
//        let totalPrice = Int((orderDic["amount"] as! String)) ?? 0
        orderDetailView.recipient.text = name
        orderDetailView.telNum.text = telNum
        orderDetailView.addressNum.text = postcode
        orderDetailView.address.text = address1 + address2
        orderDetailView.deliveryRequest.text = request
        //추후에 작업해야됨
        orderDetailView.paymentMethod.text = "카드"
        orderDetailView.orderTotalPrice.text = common.numberFormatter(number: totalPrice) + "원"
        orderDetailView.productPrice.text = common.numberFormatter(number: itmesPrice) + "원"
        orderDetailView.deliveryPrice.text = common.numberFormatter(number: shippingPrice) + "원"
//        orderDetailView.couponDiscount.text = "- \(common.numberFormatter(number: Int(orderDic["coupon_discount"] as! String) ?? 0))"
//        orderDetailView.point.text = "- \(common.numberFormatter(number: Int(orderDic["point_discount"] as! String) ?? 0))"
        
//        orderDetailView.savedPoint.text = "최대 \(totalPrice/10)p"
//        orderDetailView.earnTextReview.text = "\(totalPrice/20)p"
//        orderDetailView.earnPhotoReview.text = "\(totalPrice/20)p"
    }
    @objc func touchHomeBtn(){
        self.navigationController?.popViewController(animated: true)
    }
}
