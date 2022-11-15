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
    // 탑 영역
    let topView = UIView()
    let backBtn = UIButton().then{
        $0.setImage(UIImage(named: "back_btn"), for: .normal)
        $0.contentHorizontalAlignment = .left
    }
    lazy var titLbl = UILabel().then{
        $0.text = "주문/배송"
        $0.textColor = common.pointColor()
        $0.font = common.setFont(font: "bold", size: 23)
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
    var infoSampleListDicArr = [[String:Any]]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        getDeliveryList()
        deliveryListTableView.register(DeliveryListSampleTableViewCell.self, forCellReuseIdentifier: DeliveryListSampleTableViewCell.cellId)
        
        addSubviewFunc()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init fail")
    }
    
    
    func addSubviewFunc(){
        [topView,topNavView,mainContentView].forEach{
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
            $0.bottom.equalToSuperview()
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
    }
    func getDeliveryList(){
        let customerId = UserDefaults.standard.string(forKey: "customer_id") ?? ""
        print(customerId)
        common.sendRequest(url: "https://api.clayful.io/v1/orders?status=paid,refunded,partially-refunded&customer=\(customerId)&fields=_id,items,total.price.sale,fulfillments", method: "get", params: [:], sender: "") { [self] resultJson in
            self.infoProductListDicArr = resultJson as? [[String:Any]] ?? []
        }
        common.sendRequest(url: "https://api.clayful.io/v1/orders?status=paid,refunded,partially-refunded&fields=_id,items,total.price.sale,fulfillments&customer=\(customerId)", method: "get", params: [:], sender: "") { [self] resultJson in
            self.infoSampleListDicArr = resultJson as? [[String:Any]] ?? []
            deliveryListTableView.delegate = self
            deliveryListTableView.dataSource = self
            deliveryListTableView.reloadData()
            countLbl.text = "총 \(infoSampleListDicArr.count)개"
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
        }
    }
    @objc func touchProductBtn(){
        if productBtn.backgroundColor != common.pointColor() {
            productBtn.backgroundColor = common.pointColor()
            productBtn.setTitleColor(.white, for: .normal)
            sampleBtn.backgroundColor = .white
            sampleBtn.setTitleColor(common.pointColor(), for: .normal)
            countLbl.text = "총 \(infoProductListDicArr.count)개"
            deliveryListTableView.register(DeliveryListTableViewCell.self, forCellReuseIdentifier: DeliveryListTableViewCell.cellId)
            deliveryListTableView.reloadData()
        }
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
            return countProduct
        }
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return screenBounds.height/3 + 20
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
                }
                let itemsInfoDicArr = infoDeliveryListDic["items"] as! [[String:Any]]
                let orderId = infoDeliveryListDic["_id"] as! String
                sampleCell.orderDetailBtn.name = orderId
                sampleCell.orderDetailBtnTapped = {
                    let vc = OrderDetailViewController(orderId: orderId)
                    self.parentViewController?.navigationController!.pushViewController(vc, animated: true)
                }
                for x in 0...2 {
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
            return sampleCell
        }else{
            let productCell = DeliveryListTableViewCell(style: DeliveryListTableViewCell.CellStyle.default, reuseIdentifier: DeliveryListTableViewCell.cellId)
            var cellInfoDicArr = [[String:Any]]()
            var cellInfoDic = [String:Any]()
            var checkId = [String]()
            if infoProductListDicArr.count != 0 {
                for i in 0...infoProductListDicArr.count - 1 {
                    let infoDeliveryListDic = infoProductListDicArr[i]
                    if infoDeliveryListDic["fulfillments"] != nil {
                        let fulfillments = infoDeliveryListDic["fulfillments"] as! [[String:Any]]
                        if fulfillments.count != 0 {
                            for x in 0...fulfillments.count - 1 {
                                let itemsDicArr = fulfillments[x]["items"] as! [[String:Any]]
                                for y in 0...itemsDicArr.count - 1 {
                                    let item = itemsDicArr[y]["item"] as! [String:Any]
                                    let itemId = item["_id"] as! String
                                    if !(checkId.contains(itemId)) {
                                        checkId.append(itemId)
                                        print("여기")
                                        print(fulfillments[x]["status"] as! String)
                                        cellInfoDic.updateValue(fulfillments[x]["status"] as! String, forKey: itemId)
                                    }
                                }
                            }
                        }
                    }
                    let itemsInfoDicArr = infoDeliveryListDic["items"] as! [[String:Any]]
                    let orderId = infoDeliveryListDic["_id"] as! String
                    for x in 0...itemsInfoDicArr.count - 1 {
                        let itemsInfoDic = itemsInfoDicArr[x]
                        let productInfo = itemsInfoDic["product"] as! [String:Any]
                        let itemId = itemsInfoDic["_id"] as! String
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
                        //셀 상품 가격
                        let priceTotalInfo = itemsInfoDic["total"] as! [String:Any]
                        let priceInfo = priceTotalInfo["price"] as! [String:Any]
                        let salePriceInfo = priceInfo["sale"] as! [String:Any]
                        let price = salePriceInfo["converted"] as! String
                        //셀 상품 개수
                        let quantityInfo = itemsInfoDic["quantity"] as! [String:Any]
                        let quantity = quantityInfo["raw"] as! Int
                        if cellInfoDic[itemId] != nil {
                            cellInfoDic.updateValue(cellInfoDic[itemId] as! String, forKey: "status")
                        }else {
                            cellInfoDic.updateValue("ready", forKey: "status")
                        }
                        cellInfoDic.updateValue(encodedthumbnailURL, forKey: "encodedthumbnailURL")
                        cellInfoDic.updateValue(companyName, forKey: "companyName")
                        cellInfoDic.updateValue(productName, forKey: "productName")
                        cellInfoDic.updateValue(price, forKey: "price")
                        cellInfoDic.updateValue(quantity, forKey: "quantity")
                        cellInfoDic.updateValue(orderId, forKey: "orderId")
                        cellInfoDicArr.append(cellInfoDic)
                    }
                }
                if cellInfoDicArr.count != 0 {
                    self.countLbl.text = "총 \(cellInfoDicArr.count)개"
                    let infoDic = cellInfoDicArr[indexPath.row]
                    common.setImageUrl(url: infoDic["encodedthumbnailURL"] as! String, imageView: productCell.imgView)
                    productCell.orderDetailBtnTapped = {
                        guard let orderId: String = infoDic["orderId"] as? String else {return}
                        print(orderId)
                        let vc = OrderDetailViewController(orderId: orderId)
                        self.parentViewController?.navigationController!.pushViewController(vc, animated: true)
                    }
                    productCell.companyNameLbl.text = infoDic["companyName"] as? String
                    productCell.productNameLbl.text = infoDic["productName"] as? String
                    productCell.priceLbl.text = "\(common.numberFormatter(number: Int(infoDic["price"] as! String) ?? 0)) | \(infoDic["quantity"]!)개"
                    if infoDic["status"] as! String == "pending" {
                        productCell.startBar.backgroundColor = common.pointColor()
                        productCell.situationBtn.setTitle("배송시작", for: .normal)
                    }else if infoDic["status"] as! String == "shipped" {
                        productCell.startBar.backgroundColor = common.pointColor()
                        productCell.shippingBar.backgroundColor = common.pointColor()
                        productCell.situationBtn.setTitle("배송중", for: .normal)
                    }else if infoDic["status"] as! String == "arrived" {
                        productCell.startBar.backgroundColor = common.pointColor()
                        productCell.shippingBar.backgroundColor = common.pointColor()
                        productCell.arrivalBar.backgroundColor = common.pointColor()
                        productCell.situationBtn.setTitle("도착예정", for: .normal)
                    }
                }else{
                    self.countLbl.text = "총 0개"
                    //나중에 입력할것
                }
            }
            return productCell
        }
    }
    
    
}
