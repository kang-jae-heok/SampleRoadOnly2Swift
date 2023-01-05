//
//  ExchangeProductViewController.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/11/22.
//

import UIKit

class ExchangeProductViewController: UIViewController {
    let exchangeProductView = ExchangeProductView()
    var itemsInfoDic = [String:Any]()
    public init(infoDic: [String:Any]) {
        super.init(nibName: nil, bundle: nil)
        self.itemsInfoDic = infoDic
    }
    required init?(coder: NSCoder) {
        fatalError("init-fail")
    }
    override func loadView() {
        super.loadView()
        view = exchangeProductView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
        setData()
    }
    func setTarget() {
        exchangeProductView.yesBtn.addTarget(self, action: #selector(touchYesBtn), for: .touchUpInside)
        exchangeProductView.topView.backBtn.addTarget(self, action: #selector(touchBackBtn), for: .touchUpInside)
        exchangeProductView.homeBtn.addTarget(self, action: #selector(touchHomeBtn), for: .touchUpInside)
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
        guard let totalInfoDic = itemsInfoDic["total"] as? [String:Any] else {return}
        guard let priceInfoDic = totalInfoDic["price"] as? [String:Any] else {return}
        guard let salePriceDic = priceInfoDic["sale"] as? [String:Any] else {return}
        guard let rawPrice = salePriceDic["raw"] as? Int else {return}
        //셀 상품 개수
        guard let quantityDic = itemsInfoDic["quantity"] as? [String:Any] else {return}
        guard let rawQuantity = quantityDic["raw"] as? Int else {return}
        // 셀 오더 아이디
        guard let orderId = itemsInfoDic["order_id"] as? String else {return}
        exchangeProductView.deliveryNumLbl.text = "주문번호 " + orderId
        common2.setImageUrl(url: encodedthumbnailURL, imageView: exchangeProductView.productImgView)
        exchangeProductView.companyNameLbl.text = companyName
        exchangeProductView.productNameLbl.text = productName
        exchangeProductView.priceLbl.text = String(rawPrice) + "원 | \(rawQuantity)개"
    }
    @objc func touchYesBtn(){
        self.navigationController?.pushViewController(CompletedViewController(type: "exchange"), animated: true)
    }
    @objc func touchBackBtn(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func touchHomeBtn(){
        self.navigationController?.pushViewController(MainContentViewController(), animated: true)
    }
    


}
