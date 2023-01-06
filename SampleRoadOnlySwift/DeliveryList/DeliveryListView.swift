//
//  DeliveryHistoryView.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/10/28.
//

import Foundation
import UIKit

class DeliveryListView: UIView {
    let screenBounds = UIScreen.main.bounds
    let common = CommonS()
    let margin = 17.0
    var listDicArr = [[String:Any]]()
    var convertInfoproductListDicArr = [[String:Any]]()
    var convertInfoSampleListDicArr = [[String:Any]]()
    // 탑 영역
    let topView = UIView()
    let backBtn = UIButton().then{
        $0.setImage(UIImage(named: "back_btn"), for: .normal)
        $0.contentHorizontalAlignment = .left
    }
    lazy var titLbl = UILabel().then{
        $0.text = "주문/배송"
        $0.textColor = common.pointColor()
        $0.font = common.setFont(font: "bold", size: 20)
    }
    //탑 네비게이션(샘플/제품)
    let topNavView = UIView()
    lazy var sampleBtn = UIButton().then{
        $0.backgroundColor = common.pointColor()
        $0.layer.borderWidth = 2
        $0.layer.borderColor = common.pointColor().cgColor
        $0.setTitle("샘플", for: .normal)
        $0.titleLabel?.font = common.setFont(font: "bold", size: 18)
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(touchSampleBtn), for: .touchUpInside)
    }
    lazy var productBtn = UIButton().then{
        $0.backgroundColor = .white
        $0.layer.borderWidth = 2
        $0.layer.borderColor = common.pointColor().cgColor
        $0.setTitle("제품", for: .normal)
        $0.titleLabel?.font = common.setFont(font: "bold", size: 18)
        $0.setTitleColor(common.pointColor(), for: .normal)
        $0.addTarget(self, action: #selector(touchProductBtn), for: .touchUpInside)
    }
    //메인 컨텐츠
    let mainContentView = UIView()
    lazy var countLbl = UILabel().then{
        $0.textColor = common.pointColor()
        $0.font = common.setFont(font: "bold", size: 15)
        $0.asColor(targetStringList: ["총","개"], color: common.setColor(hex: "#b1b1b1"))
    }
    let deliveryListTableView = UITableView()
    //테이블에 들어갈 정보
    var infoProductListDicArr = [[String:Any]]()
    var productItemsInfoDicArr = [[String:Any]]()
    var infoSampleListDicArr = [[String:Any]]()
    let noneView = NoneView().then {
        $0.tit.text = "주문하신 내역이 없습니다"
        $0.isHidden = true
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
        [topView,topNavView,mainContentView,noneView].forEach{
            self.addSubview($0)
        }
        [titLbl,backBtn].forEach{
            topView.addSubview($0)
        }
        [sampleBtn,productBtn].forEach{
            topNavView.addSubview($0)
        }
        [countLbl,deliveryListTableView].forEach{
            mainContentView.addSubview($0)
        }
    }
    func setLayout(){
        //탑 뷰
        topView.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(super.snp.top).offset(screenBounds.width/4)
        }
        backBtn.snp.makeConstraints{
            $0.left.equalToSuperview().offset(margin)
            $0.size.equalTo(CGSize(width: 50, height: 50))
            $0.centerY.equalTo(titLbl)
        }
        titLbl.snp.makeConstraints{
            $0.centerX.bottom.equalToSuperview()
        }
        // 탑 네비게이션 뷰
        topNavView.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.top.equalTo(topView.snp.bottom).offset(13)
            $0.bottom.equalTo(topView.snp.bottom).offset(screenBounds.height/20 + 13)
        }
        sampleBtn.snp.makeConstraints{
            $0.left.equalToSuperview().offset(margin)
            $0.top.bottom.equalToSuperview()
            $0.right.equalTo(topNavView.snp.centerX)
        }
        productBtn.snp.makeConstraints{
            $0.right.equalToSuperview().offset(-margin)
            $0.top.bottom.equalToSuperview()
            $0.left.equalTo(topNavView.snp.centerX)
        }
        //메인 컨텐츠
        mainContentView.snp.makeConstraints{
            $0.top.equalTo(topNavView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
        countLbl.snp.makeConstraints{
            $0.left.equalToSuperview().offset(margin)
            $0.top.equalToSuperview().offset(15)
        }
        deliveryListTableView.snp.makeConstraints{
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(countLbl.snp.bottom).offset(15)
        }
        noneView.snp.makeConstraints {
            $0.edges.equalTo(mainContentView)
        }
    }
    func getDeliveryList(){
        let customerId = UserDefaults.standard.string(forKey: "customer_id") ?? ""
//        let customerId = "NNAEBKA7UUAB"
        print(customerId)
        convertInfoproductListDicArr.removeAll()
        convertInfoSampleListDicArr.removeAll()
        common.sendRequest(url: "https://api.clayful.io/v1/orders?customer=\(customerId)", method: "get", params: [:], sender: "") { [self] resultJson in
            self.infoProductListDicArr = resultJson as? [[String:Any]] ?? []
        
            if infoProductListDicArr.count != 0 {
                for i in 0...infoProductListDicArr.count - 1 {
                    guard let tagArr = infoProductListDicArr[i]["tags"] as? [[String:Any]] else {return} 
                    if tagArr.count == 0 {
                        convertInfoproductListDicArr.append(infoProductListDicArr[i])
                    }else {
                        convertInfoSampleListDicArr.append(infoProductListDicArr[i])
                    }
                }
            }
            print("###listDictArr")
            self.infoProductListDicArr = convertInfoproductListDicArr
            self.infoSampleListDicArr = convertInfoSampleListDicArr
            if infoProductListDicArr.count != 0 {
                for i in 0...infoProductListDicArr.count - 1 {
                    guard let orderId = infoProductListDicArr[i]["_id"] as? String else {return}
                    guard let fulfillmentsArr = infoProductListDicArr[i]["fulfillments"] as? [[String:Any]] else {return}
                    guard let status = infoProductListDicArr[i]["status"] as? String else {return}
                    guard var itemsArr = infoProductListDicArr[i]["items"] as? [[String:Any]] else {return}
                    guard let refundArr = infoProductListDicArr[i]["refunds"] as? [[String:Any]] else {return}
                    var refundId = [String]()
                    var refundStatus = String()
                    if refundArr.count != 0 {
                        for y in 0...itemsArr.count - 1 {
//                            guard let refundItemsArr = refundArr[y]["items"] as? [[String:Any]] else {return}
//                            guard let orderRefundStatus = refundArr[y]["status"] as? String else {return}
//                            guard let refundItemDic = refundItemsArr[0]["item"] as? [String:Any] else {return}
//                            guard let orderRefundId = refundItemDic["_id"] as? String else {return}
//                            refundId.append(orderRefundId)
//                            refundStatus = orderRefundStatus
                        }
                    }else {
                        refundId = []
                        refundStatus = ""
                    }
                    for x in 0...itemsArr.count - 1 {
                        itemsArr[x].updateValue(orderId, forKey: "order_id")
                        itemsArr[x].updateValue(fulfillmentsArr, forKey: "fulfillments")
                        itemsArr[x].updateValue(status, forKey: "status")
                        itemsArr[x].updateValue(refundId, forKey: "refund_arr")
                        itemsArr[x].updateValue(refundStatus, forKey: "refund_status")
                        productItemsInfoDicArr.append(itemsArr[x])
                    }
                }
            }
            if sampleBtn.backgroundColor == common.pointColor() {
                if convertInfoSampleListDicArr.count == 0 {
                    noneView.isHidden = false
                }else {
                    noneView.isHidden = true
                }
            }else {
                if convertInfoproductListDicArr.count == 0 {
                    noneView.isHidden = false
                }else {
                    noneView.isHidden = true
                }
            }
           
            deliveryListTableView.delegate = self
            deliveryListTableView.dataSource = self
            deliveryListTableView.reloadData()
            countLbl.text = "총 \(infoSampleListDicArr.count)개"
        }
    }
    func json(from object: [[String:Any]]) throws -> String {
        let data = try JSONSerialization.data(withJSONObject: object)
        return String(data: data, encoding: .utf8)!
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
    @objc func touchSampleBtn(){
        if sampleBtn.backgroundColor != common.pointColor() {
            sampleBtn.backgroundColor = common.pointColor()
            sampleBtn.setTitleColor(.white, for: .normal)
            productBtn.backgroundColor = .white
            productBtn.setTitleColor(common.pointColor(), for: .normal)
            countLbl.text = "총 \(infoSampleListDicArr.count)개"
            deliveryListTableView.register(DeliveryListSampleTableViewCell.self, forCellReuseIdentifier: DeliveryListSampleTableViewCell.cellId)
            deliveryListTableView.reloadData()
            countLbl.isHidden = false
            if convertInfoSampleListDicArr.count == 0 {
                noneView.isHidden = false
            }else {
                noneView.isHidden = true
            }
            deliveryListTableView.snp.remakeConstraints{
                $0.left.right.bottom.equalToSuperview()
                $0.top.equalTo(countLbl.snp.bottom).offset(15)
            }
        }
    }
    @objc func touchProductBtn(){
        if productBtn.backgroundColor != common.pointColor() {
            productBtn.backgroundColor = common.pointColor()
            productBtn.setTitleColor(.white, for: .normal)
            sampleBtn.backgroundColor = .white
            sampleBtn.setTitleColor(common.pointColor(), for: .normal)
            countLbl.text = "총 \(infoProductListDicArr.count)개"
            deliveryListTableView.register(DeliveryListProductTableViewCell.self, forCellReuseIdentifier: DeliveryListProductTableViewCell.cellId)
            deliveryListTableView.reloadData()
            countLbl.isHidden = true
            if convertInfoproductListDicArr.count == 0 {
                noneView.isHidden = false
            }else {
                noneView.isHidden = true
            }
            deliveryListTableView.snp.remakeConstraints {
                $0.top.equalTo(sampleBtn.snp.bottom)
                $0.left.right.bottom.equalToSuperview()
            }
            
        }
    }
    @objc func touchExchangeBtn(sender: UIButton){
        print("hi")
    }
    
}
extension DeliveryListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countProduct = Int()
        if infoProductListDicArr.count != 0 {
            for i in 0...infoProductListDicArr.count - 1 {
                let infoDeliveryListDic = infoProductListDicArr[i]
                let itemsInfoDicArr = infoDeliveryListDic["items"] as! [[String:Any]]
                countProduct += itemsInfoDicArr.count
            }
        }
        if sampleBtn.backgroundColor == common.pointColor(){
            return infoSampleListDicArr.count
        }else {
            return convertInfoproductListDicArr.count
        }
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sampleBtn.backgroundColor == common.pointColor(){
            return screenBounds.height/3 + 20

        }else {
            return  UITableView.automaticDimension
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if sampleBtn.backgroundColor == common.pointColor(){
            let sampleCell = DeliveryListSampleTableViewCell(style: DeliveryListSampleTableViewCell.CellStyle.default, reuseIdentifier: DeliveryListSampleTableViewCell.cellId)
            sampleCell.selectionStyle = .none
            if infoSampleListDicArr.count != 0 {
                self.countLbl.text = "총 \(infoSampleListDicArr.count)개"
                let infoDeliveryListDic = infoSampleListDicArr[indexPath.row]
                let fulfillments = infoDeliveryListDic["fulfillments"] as! [[String:Any]]
                if !(fulfillments.isEmpty) {
                    let status = fulfillments[0]["status"] as! String
                    if status == "pending" {
                        sampleCell.startBar.backgroundColor = common.pointColor()
                        sampleCell.situationBtn.setTitle("배송시작", for: .normal)
                    }else if status == "shipped" {
                        sampleCell.startBar.backgroundColor = common.pointColor()
                        sampleCell.shippingBar.backgroundColor = common.pointColor()
                        sampleCell.situationBtn.setTitle("배송중", for: .normal)
                    }else if status == "arrived" {
                        sampleCell.startBar.backgroundColor = common.pointColor()
                        sampleCell.shippingBar.backgroundColor = common.pointColor()
                        sampleCell.arrivalBar.backgroundColor = common.pointColor()
                        sampleCell.situationBtn.setTitle("도착예정", for: .normal)
                    }
                   
                }else {
                    guard let status = infoDeliveryListDic["status"] as? String else {return sampleCell}
                    if status == "placed" {
                        sampleCell.situationBtn.setTitle("결제대기", for: .normal)
                    }else if status == "paid" {
                            
                    }else if status == "cancelled" {
                        sampleCell.situationBtn.setTitle("주문취소", for: .normal)
                    } else {
                        sampleCell.situationBtn.setTitle("결제오류", for: .normal)
                    }
                }
                let itemsInfoDicArr = infoDeliveryListDic["items"] as! [[String:Any]]
                print(itemsInfoDicArr.count)
                let orderId = infoDeliveryListDic["_id"] as! String
                sampleCell.orderDetailBtn.name = orderId
                sampleCell.orderDetailBtnTapped = {
                    let vc = OrderDetailViewController(orderId: orderId)
                    self.parentViewController?.navigationController!.pushViewController(vc, animated: true)
                }
                sampleCell.deliveryTrackingTapped = {
                    let fulfillmentsArr:Array = infoDeliveryListDic["fulfillments"] as! Array<Any>
                    if fulfillmentsArr.count != 0 {
                        let firstArr = fulfillmentsArr[0] as! [String:Any]
                        let trackingDic = firstArr["tracking"] as! [String:Any]
                        let uid = trackingDic["uid"] as! String
                        UIApplication.shared.open(URL(string: "http://nplus.doortodoor.co.kr/web/detail.jsp?slipno=\(uid)")!)
                    }
                }
                for x in 0...itemsInfoDicArr.count - 1 {
                    let itemsInfoDic = itemsInfoDicArr[x]
                    let productInfo = itemsInfoDic["product"] as! [String:Any]
                    // 셀 이미지
                    let thumbnailInfo = productInfo["thumbnail"] as! [String:Any]
                    let thumbnailURL = thumbnailInfo["url"] as! String
                    let encodedthumbnailURL = thumbnailURL.description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    //셀 회사 이름
                    let companyInfo = itemsInfoDic["brand"] as! [String:Any]
                    let companyName = companyInfo["name"] as! String
                    // 셀 상품 이름
                    let productInfoDic = itemsInfoDic["product"]  as! [String:Any]
                    let productName = productInfoDic["name"] as! String
                    if x == 0 {
                        common.setImageUrl(url: encodedthumbnailURL ?? "", imageView: sampleCell.firstImgView)
                        sampleCell.firstCompanyLbl.text = companyName
                        sampleCell.firstProductNameLbl.text = productName
                    }else if x == 1 {
                        common.setImageUrl(url: encodedthumbnailURL ?? "", imageView: sampleCell.secondImgView)
                        sampleCell.secondCompanyLbl.text = companyName
                        sampleCell.secondProductNameLbl.text = productName
                    }else if x == 2 {
                        common.setImageUrl(url: encodedthumbnailURL ?? "", imageView: sampleCell.thirdImgView)
                        sampleCell.thirdCompanyLbl.text = companyName
                        sampleCell.thirdProductNameLbl.text = productName
                    }
                    
                }
            }else{
                self.countLbl.text = "총 0개"
            }
            sampleCell.preservesSuperviewLayoutMargins = false
            sampleCell.separatorInset = UIEdgeInsets.zero
            sampleCell.layoutMargins = UIEdgeInsets.zero
            return sampleCell
        }else{
            let productCell = DeliveryListProductTableViewCell(style: DeliveryListProductTableViewCell.CellStyle.default, reuseIdentifier: DeliveryListProductTableViewCell.cellId, dicArr: convertInfoproductListDicArr[indexPath.row])
            productCell.selectionStyle = .none
            
            
            
//            if productItemsInfoDicArr.count != 0 {
//                let itemsInfoDic  = productItemsInfoDicArr[indexPath.row]
//                guard let productInfo = itemsInfoDic["product"] as? [String:Any] else {return productCell}
//                // 셀 이미지
//                guard let thumbnailInfo = productInfo["thumbnail"] as? [String:Any] else {return productCell}
//                guard let thumbnailURL = thumbnailInfo["url"] as? String else {return productCell}
//                guard let encodedthumbnailURL = thumbnailURL.description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return productCell }
//                //셀 회사 이름
//                guard let companyInfo = itemsInfoDic["brand"] as? [String:Any] else {return productCell}
//                guard let companyName = companyInfo["name"] as? String else {return productCell}
//                // 셀 상품 이름
//                guard let productInfoDic = itemsInfoDic["product"]  as? [String:Any] else {return productCell}
//                guard let productName = productInfoDic["name"] as? String else {return productCell}
//                //셀 상품 가격
//                guard let totalInfoDic = itemsInfoDic["total"] as? [String:Any] else {return productCell}
//                guard let priceInfoDic = totalInfoDic["price"] as? [String:Any] else {return productCell}
//                guard let salePriceDic = priceInfoDic["sale"] as? [String:Any] else {return productCell}
//                guard let rawPrice = salePriceDic["raw"] as? Int else {return productCell}
//                //셀 상품 개수
//                guard let quantityDic = itemsInfoDic["quantity"] as? [String:Any] else {return productCell}
//                guard let rawQuantity = quantityDic["raw"] as? Int else {return productCell}
//                // 셀 오더 아이디
//                guard let orderId = itemsInfoDic["order_id"] as? String else {return productCell}
//                // 셀 배송정보
//                guard let fulfillmentsArr = itemsInfoDic["fulfillments"] as? [[String:Any]] else {return productCell}
//                // 셀 주문 상태
//                guard let status = itemsInfoDic["status"] as? String else {return productCell}
//                //환불된 제품
//                guard let refundArr = itemsInfoDic["refund_arr"] as? [String] else {return productCell}
//                guard let itemId = itemsInfoDic["_id"] as? String else {return productCell}
//                guard let refundStatus = itemsInfoDic["refund_status"] as? String else {return productCell}
//
//
//                common2.setImageUrl(url: encodedthumbnailURL, imageView: productCell.imgView)
//                productCell.companyNameLbl.text = companyName
//                productCell.productNameLbl.text = productName
//                productCell.priceLbl.text = common.numberFormatter(number: rawPrice) + "원 | \(rawQuantity)개"
//                productCell.orderDetailBtnTapped = {
//                    let vc = OrderDetailViewController(orderId: orderId)
//                    self.parentViewController?.navigationController?.pushViewController(vc, animated: true)
//                }
//                if fulfillmentsArr.count != 0 {
//                    let fulfillStatus = fulfillmentsArr[0]["status"] as! String
//                    if fulfillStatus == "pending" {
//                        productCell.startBar.backgroundColor = common.pointColor()
//                        productCell.situationBtn.setTitle("배송시작", for: .normal)
//                    }else if fulfillStatus == "shipped" {
//                        productCell.startBar.backgroundColor = common.pointColor()
//                        productCell.shippingBar.backgroundColor = common.pointColor()
//                        productCell.situationBtn.setTitle("배송중", for: .normal)
//                    }else if fulfillStatus == "arrived" {
//                        productCell.startBar.backgroundColor = common.pointColor()
//                        productCell.shippingBar.backgroundColor = common.pointColor()
//                        productCell.arrivalBar.backgroundColor = common.pointColor()
//                        productCell.situationBtn.setTitle("도착예정", for: .normal)
//                    }else {
//                        productCell.startBar.backgroundColor = common.pointColor()
//                        productCell.shippingBar.backgroundColor = common.pointColor()
//                        productCell.arrivalBar.backgroundColor = common.pointColor()
//                        productCell.situationBtn.setTitle("배송완료", for: .normal)
//                    }
//                }else {
//                    if status == "placed" {
//                        productCell.situationBtn.setTitle("결제 대기", for: .normal)
//                        productCell.deliveryTrackingBtn.snp.remakeConstraints {
//                            $0.edges.equalTo(productCell.exchangeBtn)
//                        }
//                        productCell.exchangeBtn.isHidden = true
//                    }else if status == "paid" {
//
//                    }else if status == "cancelled" {
//                        productCell.situationBtn.setTitle("주문 취소", for: .normal)
//                    }else {
//                        productCell.situationBtn.setTitle("결제 오류", for: .normal)
//                        productCell.deliveryTrackingBtn.snp.remakeConstraints {
//                            $0.edges.equalTo(productCell.exchangeBtn)
//                        }
//                        productCell.exchangeBtn.isHidden = true
//                    }
//                }
//
//
//
//                //버튼 액션 클로저
//                productCell.deliveryTrackingTapped = { [self] in
//                    if fulfillmentsArr.count != 0 {
//                        let firstArr = fulfillmentsArr[0]
//                        let trackingDic = firstArr["tracking"] as! [String:Any]
//                        let uid = trackingDic["uid"] as! String
//                        UIApplication.shared.open(URL(string: "http://nplus.doortodoor.co.kr/web/detail.jsp?slipno=\(uid)")!)
//                    }else {
//                        self.parentViewController?.present(self.common2.alert(title: "", message: "배송 준비중입니다"), animated: true)
//                    }
//                }
//                productCell.exchangeBtnTapped = {
//                    let vc = ReturnProductViewController(infoDic: itemsInfoDic)
//                    self.parentViewController?.navigationController?.pushViewController(vc, animated: true)
//                }
//                if refundArr.count != 0 {
//                    for i in 0...refundArr.count - 1 {
//                        if refundArr[i] == itemId {
//                            productCell.situationBtn.setTitle(returnStatus(status: refundStatus), for: .normal)
//                            if refundStatus == "requested" {
//                                productCell.situationBtn.backgroundColor = common.setColor(hex: "#ffbc00")
//                            }else if refundStatus == "accepted" {
//                                productCell.situationBtn.backgroundColor = common.setColor(hex: "#ffbc00")
//                            }else if refundStatus == "cancelled" {
//                                productCell.situationBtn.backgroundColor = common.setColor(hex: "#ffbc00")
//                            }else if status == "refunded" {
//                                productCell.situationBtn.backgroundColor = common.setColor(hex: "#36dc69")
//                            }
//                            productCell.deliveryTrackingBtn.snp.remakeConstraints {
//                                $0.edges.equalTo(productCell.exchangeBtn)
//                            }
//                            productCell.exchangeBtn.isHidden = true
//
//                        }
//                    }
//                }
//            }else{
//                self.countLbl.text = "총 0개"
//            }
            productCell.preservesSuperviewLayoutMargins = false
            productCell.separatorInset = UIEdgeInsets.zero
            productCell.layoutMargins = UIEdgeInsets.zero
            return productCell
        }
      
    }

    
}
