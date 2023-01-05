//
//  DetailProductViewController.swift
//  SampleLoad
//
//  Created by notegg on 2022/11/23.


import UIKit
import Alamofire
import zaiclient



class DetailProductViewController: UIViewController {
    let detailProductView = DetailProductView()
    var productID: String?
    var product: Product?
    var productDic: [String:Any]?
    var reviews = [Review]()
    lazy var customerID = customerId2
    var variationID = String()
    let common = CommonS()
    var btnDuplicateCheck = true
   
    
    public init(productDic: [String:Any]){
        super.init(nibName: nil, bundle: nil)
        guard let id = productDic["_id"] as? String else {return}
        productID = id
        self.productDic = productDic
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        super.loadView()
        view = detailProductView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        addChild(chartVc)
//        chartVc.view.backgroundColor = .red
//        detailProductView.AIParsingWebView = chartVc.view
//        print("####chartVc frame")
//        print(chartVc.view.frame)
        
        setTableView()
        getProductInfo()
        getReviewList()
        bindAction()
        addAi()
        print("####initDic")
        print(detailProductView.productThumbImageView.image)
        let opacityViewRecognizer = UITapGestureRecognizer(target: self, action: #selector(opacityViewTapped(_:)))
        detailProductView.purchasePopupView.opacityView.addGestureRecognizer(opacityViewRecognizer)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        switch detailProductView.selectedView {
            case .AIParsing:
                detailProductView.AIParsingButton.isSelected = true
                detailProductView.AIParsingButton.layer.addBorder([.bottom], color: .black, width: 3)
            case .productDesc:
                detailProductView.productDescriptionButton.isSelected = true
            case .review:
                detailProductView.reviewButton.isSelected = true
        }
        
        
    }

    func bindAction() {
        detailProductView.cartButton.addTarget(self, action: #selector(cartButtonTapped(_:)), for: .touchUpInside)
        detailProductView.shareButton.addTarget(self, action: #selector(shareButtonTapped(_:)), for: .touchUpInside)
        detailProductView.likeButton.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)
        detailProductView.purchaseButton.addTarget(self, action: #selector(purchaseButtonTapped(_:)), for: .touchUpInside)
        detailProductView.backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        detailProductView.purchasePopupView.cartAddButton.addTarget(self, action: #selector(cartAddButtonTapped(_:)), for: .touchUpInside)
        detailProductView.purchasePopupView.orderButton.addTarget(self, action: #selector(orderButtonTapped(_:)), for: .touchUpInside)
        detailProductView.showAllReviewListButton.addTarget(self, action: #selector(showAllReviewButtonTapped(_:)), for: .touchUpInside)
        detailProductView.writeReviewButton.addTarget(self, action: #selector(writeReviewButtonTapped(_:)), for: .touchUpInside)
        
    }
    func setTableView() {
        detailProductView.reviewListTableView.dataSource = self
        detailProductView.reviewListTableView.register(
            ReviewListTableViewCell.self,
            forCellReuseIdentifier: ReviewListTableViewCell.identifier
        )
    }
    func addAi() {
        do {
            let zaiClient = try ZaiClient(zaiClientID: self.clientId, zaiSecret: self.clientSecret)

            let productDetailViewEvent = try ProductDetailViewEvent(userId: self.customerID, itemId: productID ?? "")
          zaiClient.addEventLog(productDetailViewEvent) {
            (res, err) in if let error = err {
                print(error)
            }
              print(res)
              print("성공")
          }
        } catch let error {
            print("에러")
          print(error.localizedDescription)
        }
    }
    func getProductInfo() {
        guard let productID = productID else {
            return
        }
        
        var url = "https://api.clayful.io/v1/products/\(productID)"
//        let header: HTTPHeaders = [
//            "Content-Type":"application/json",
//            "Accept":"application/json",
//            "Accept-Encoding":"gzip",
//            "Authorization":"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjM4N2NkNjVkZGUxOWExZjdkNGM0NTk2ODhlZTJkNTk1MWZkZjRlYTI5ZWQ1OWE1NTc2MjBlOTI5Y2M4OTNiZTAiLCJyb2xlIjoiY2xpZW50IiwiaWF0IjoxNjU0NTc5NzQ0LCJzdG9yZSI6IlZLS1RZTjIzVEJFUS5GOVg5R0pKQkVFNVEiLCJzdWIiOiJYUzRVRVRCOFNFVkcifQ.G1j5SEaS-sjgRf1dPTr0l7zeIPNVPKVNw2Ga49FfUG0"
//        ]
//        AF.request(url,
//                   method: .get,
//                   parameters: nil,
//                   encoding: URLEncoding.default,
//                   headers: header
//        ).responseDecodable(of: Product.self) { [weak self] res in
//            switch res.result {
//                case .failure(let error):
//                    print(error)
//                case .success(let product):
//                    self?.detailProductView.product = product
//                    self?.detailProductView.setProperties()
//                    product.variants.forEach {
//                        if $0.types[0].variation.value != "샘플" {
//                            self?.variationID = $0.id
//                        }
//                    }
//            }
//        }
        
        
        
        
        let decoder = JSONDecoder()
        print("###product")
        print(common.dicToJsonString(dic: productDic!))
        var data = common.dicToJsonString(dic: productDic!).data(using: .utf8)
        if let data = data, let myProduct = try? decoder.decode(Product.self, from: data) {
            detailProductView.product = myProduct
            self.detailProductView.setProperties()
            detailProductView.product?.variants.forEach {
                if $0.types[0].variation.value != "샘플" {
                    self.variationID = $0.id
                    print("###variantID" + variationID)
                }
            }
        }
       
//            self.detailProductView.product = convertDic
            
       
        
        url = "http://110.165.17.124/sampleroad/v1/product.php"
        let parameters: Parameters = [
            "customer_id": customerID,
            "check": "check",
            "product_id": productID
        ]
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoding: URLEncoding.default,
                   headers: nil
        ).responseData { [weak self] res in
            switch res.result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    guard let json = try? JSONSerialization.jsonObject(with: data),
                          let dictionary = json as? [String: Any] else {
                        return
                    }
                    self?.setPickPresentation(dictionary)
            }
        }
    }
    func getReviewList() {
        guard let productID = productID else {
            return
        }
        let url = "https://api.clayful.io/v1/products/reviews/published?product=\(productID)"
        let header: HTTPHeaders = [
            "Content-Type":"application/json",
            "Accept":"application/json",
            "Accept-Encoding":"gzip",
            "Authorization":"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjM4N2NkNjVkZGUxOWExZjdkNGM0NTk2ODhlZTJkNTk1MWZkZjRlYTI5ZWQ1OWE1NTc2MjBlOTI5Y2M4OTNiZTAiLCJyb2xlIjoiY2xpZW50IiwiaWF0IjoxNjU0NTc5NzQ0LCJzdG9yZSI6IlZLS1RZTjIzVEJFUS5GOVg5R0pKQkVFNVEiLCJzdWIiOiJYUzRVRVRCOFNFVkcifQ.G1j5SEaS-sjgRf1dPTr0l7zeIPNVPKVNw2Ga49FfUG0"
        ]

        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: header
        ).responseDecodable(of: [Review].self) { [weak self] res in
            switch res.result {
                case .failure(let error):
                    print(error)
                case .success(let reviews):
                print("여기")
                print(reviews)
                    if reviews.count == 0 {
                        self?.detailProductView.reviewNoDataView.isHidden = false
                        self?.detailProductView.writeReviewButton.isHidden = true
                    }
                    self?.detailProductView.showAllReviewListButton.setTitle("리뷰 \(reviews.count)개 전체보기",
                                                                             for: .normal)
                    self?.reviews = reviews
                    self?.detailProductView.reviewListTableView.reloadData()
            }
        }
        self.detailProductView.product = product
        self.detailProductView.setProperties()
    }
    func setPickPresentation(_ dictionary: [String: Any]) {
        guard let pick = dictionary["pick"] as? String,
              let pickCount = dictionary["count"] as? Int else {
            return
        }
        var isPick = false
        if pick == "1" {
            isPick = true
        } else {
            isPick = false
        }
        detailProductView.setPick(isPick: isPick, count: String(pickCount))
    }

    @objc func cartButtonTapped(_ sender: UIButton) {
        goCart()
    }
   
    @objc func shareButtonTapped(_ sender: UIButton) {
        guard let productID = productID else {
            return
        }
        let shareURL = "http://110.165.17.124/product.html?product=\(productID)"
        common.makeShortUrl(url: shareURL) { shourtURL in
            let activityVC = UIActivityViewController(activityItems: [shourtURL], applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.detailProductView
            self.present(activityVC, animated: true)
        }
       
    }
    @objc func likeButtonTapped(_ sender: UIButton) {
        guard let productID = productID else {
            return
        }
        let url = "http://110.165.17.124/sampleroad/v1/product.php"
        let parameters: Parameters = [
            "customer_id": customerID,
            "update": "update",
            "product_id": productID
        ]
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoding: URLEncoding.default,
                   headers: nil
        ).responseData { [weak self] res in
            switch res.result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    guard let json = try? JSONSerialization.jsonObject(with: data),
                          let dictionary = json as? [String: Any] else {
                        return
                    }
                    self?.setPickPresentation(dictionary)
                do {
                    let zaiClient = try ZaiClient(zaiClientID: self!.clientId, zaiSecret: self!.clientSecret)

                    let productDetailViewEvent = try LikeEvent(userId: self!.customerID, itemId: productID)
                  zaiClient.addEventLog(productDetailViewEvent) {
                    (res, err) in if let error = err {
                        print(error)
                    }
                      print(res)
                      print("성공")
                  }
                } catch let error {
                    print("에러")
                  print(error.localizedDescription)
                }
            }
        }

    }
    @objc func purchaseButtonTapped(_ sender: UIButton) {
        detailProductView.purchasePopupView.isHidden = false
    }
    @objc func cartAddButtonTapped(_ sender: UIButton) {
        if btnDuplicateCheck {
            getCartList()
        }
        btnDuplicateCheck = false
   
    }
    @objc func orderButtonTapped(_ sender: UIButton) {
        productDic?.updateValue(detailProductView.purchasePopupView.productCount, forKey: "quantity")
        self.navigationController?.pushViewController(OrderSViewController(orderListDic: ["product_list":[productDic]]), animated: true)
    }
    @objc func opacityViewTapped(_ sender:UIGestureRecognizer) {
        detailProductView.purchasePopupView.isHidden = true
    }
    @objc func writeReviewButtonTapped(_ sender: UIButton) {
        self.navigationController?.pushViewController(WriteReivewSViewController(dic: productDic ?? [:]), animated: true)
    }
    func likeToggle() {
        let url = "http://110.165.17.124/sampleroad/v1/product.php"
        let parameters: Parameters = [
            "customer_id": customerID,
            "update": "update",
            "product_id": productID
        ]
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoding: URLEncoding.default,
                   headers: nil
        ).responseData { res in
            switch res.result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    guard let json = try? JSONSerialization.jsonObject(with: data),
                          let dictionary = json as? [String: Any] else {
                        return
                    }

            }
        }
    }
    func getCartList() {
        let url = "https://api.clayful.io/v1/customers/\(customerID)/cart"
        print(customerID)
        let header: HTTPHeaders = [
            "Content-Type":"application/json",
            "Accept":"application/json",
            "Accept-Encoding":"gzip",
            "Authorization":"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjM4N2NkNjVkZGUxOWExZjdkNGM0NTk2ODhlZTJkNTk1MWZkZjRlYTI5ZWQ1OWE1NTc2MjBlOTI5Y2M4OTNiZTAiLCJyb2xlIjoiY2xpZW50IiwiaWF0IjoxNjU0NTc5NzQ0LCJzdG9yZSI6IlZLS1RZTjIzVEJFUS5GOVg5R0pKQkVFNVEiLCJzdWIiOiJYUzRVRVRCOFNFVkcifQ.G1j5SEaS-sjgRf1dPTr0l7zeIPNVPKVNw2Ga49FfUG0"
        ]
        AF.request(url,
                   method: .post,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: header
        ).responseDecodable(of: CartData.self) { [weak self] res in
            switch res.result {
                case .failure(let error):
                    print(error)
                self!.btnDuplicateCheck = true
                case .success(let cartData):
                    self?.checkExistCartList(cartData: cartData)
               
            }
        }
    }
    func checkExistCartList(cartData: CartData) {
        var isExist = false
        cartData.cart.items.forEach {
            if variationID == $0.variant.id {
                isExist = true
                addAmountCartProduct(cartItem: $0)
                print($0.id)
            }
        }
        if !isExist {
            addCartProduct()
        }
    }
    func addAmountCartProduct(cartItem: Item) {
        let selectedAmount = detailProductView.purchasePopupView.productCount
        let containedAmount = cartItem.quantity.raw
        let resultAmount = selectedAmount + containedAmount

        let url = "https://api.clayful.io/v1/customers/\(customerID)/cart/items/\(cartItem.id)"
        let header: HTTPHeaders = [
            "Content-Type":"application/json",
            "Accept":"application/json",
            "Accept-Encoding":"gzip",
            "Authorization":"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjM4N2NkNjVkZGUxOWExZjdkNGM0NTk2ODhlZTJkNTk1MWZkZjRlYTI5ZWQ1OWE1NTc2MjBlOTI5Y2M4OTNiZTAiLCJyb2xlIjoiY2xpZW50IiwiaWF0IjoxNjU0NTc5NzQ0LCJzdG9yZSI6IlZLS1RZTjIzVEJFUS5GOVg5R0pKQkVFNVEiLCJzdWIiOiJYUzRVRVRCOFNFVkcifQ.G1j5SEaS-sjgRf1dPTr0l7zeIPNVPKVNw2Ga49FfUG0"
        ]
        let parameters: Parameters = [
            "quantity": resultAmount
        ]
        AF.request(url,
                   method: .put,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: header
        ).responseData(completionHandler: { [self] res in
            switch res.result {
                case .failure(let error):
                    print(error)
                self.btnDuplicateCheck = true
                case .success(let _):
                do {
                    let zaiClient = try ZaiClient(zaiClientID: self.clientId, zaiSecret: self.clientSecret)

                    let productDetailViewEvent = try CartaddEvent(userId: self.customerID, itemId: productID ?? "")
                  zaiClient.addEventLog(productDetailViewEvent) {
                    (res, err) in if let error = err {
                        print(error)
                    }
                      print(res)
                      print("성공")
                  }
                } catch let error {
                    print("에러")
                  print(error.localizedDescription)
                }
                    let alertText = NSMutableAttributedString(string: "장바구니에 담겼습니다.")
                    alertText.addAttributes([
                        .foregroundColor: common.lightGray(),
                        .font: common.setFont(font: "medium", size: 16)],
                                            range: NSRange(location: 0, length: alertText.length))
//                    alertText.addAttribute(.foregroundColor, value: common.lightGray(), range: NSRange()
                    Common.customAlert2(alertText, "확인하기", "취소", self, #selector(goCart))
            }
            self.btnDuplicateCheck = true
        })
    }
    func addCartProduct() {
        let url = "https://api.clayful.io/v1/customers/\(customerID)/cart/items"
        let header: HTTPHeaders = [
            "Content-Type":"application/json",
            "Accept":"application/json",
            "Accept-Encoding":"gzip",
            "Authorization":"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjM4N2NkNjVkZGUxOWExZjdkNGM0NTk2ODhlZTJkNTk1MWZkZjRlYTI5ZWQ1OWE1NTc2MjBlOTI5Y2M4OTNiZTAiLCJyb2xlIjoiY2xpZW50IiwiaWF0IjoxNjU0NTc5NzQ0LCJzdG9yZSI6IlZLS1RZTjIzVEJFUS5GOVg5R0pKQkVFNVEiLCJzdWIiOiJYUzRVRVRCOFNFVkcifQ.G1j5SEaS-sjgRf1dPTr0l7zeIPNVPKVNw2Ga49FfUG0"
        ]

        let parameters: Parameters = [
            "product": productID ?? "",
            "variant": variationID,
            "quantity": detailProductView.purchasePopupView.productCount,
            "shippingMethod": "BBJAWU65EV88"
        ]
        print("####cartAddParams")
        print(parameters)
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: header
        ).responseData(completionHandler: { [self] res in
            switch res.result {
                case .failure(let error):
                    print(error)
                self.btnDuplicateCheck = true
                case .success(let data):
                guard let json = try? JSONSerialization.jsonObject(with: data),
                      let dictionary = json as? [String: Any] else {
                    return
                }
                print("###responseData")
                print(dictionary)
                print()
                    let alertText = NSMutableAttributedString(string: "장바구니에 담겼습니다.")
                    alertText.addAttributes([
                        .foregroundColor: common.lightGray(),
                        .font: common.setFont(font: "medium", size: 16)],
                                            range: NSRange(location: 0, length: alertText.length))
//                    alertText.addAttribute(.foregroundColor, value: common.lightGray(), range: alertText.)
                self.btnDuplicateCheck = true
                    Common.customAlert2(alertText, "확인하기", "취소", self, #selector(goCart))
            }
        })
    }
    @objc func goCart() {
        Common.closeCustomAlert2()
        self.navigationController?.pushViewController(CartListSViewController(), animated: true)
    }
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func showAllReviewButtonTapped(_ sender: UIButton) {
        let vc = AllReviewListViewController()
        vc.productID = productID
        vc.productDic = productDic
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension DetailProductViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reviews.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tableView.dequeueReusableCell(
            withIdentifier: ReviewListTableViewCell.identifier,
            for: indexPath
        )
        guard let cell = dequeuedCell as? ReviewListTableViewCell else {
            return dequeuedCell
        }
        cell.selectionStyle = .none
        cell.reviewInfo = reviews[indexPath.row]
        cell.setProperties()
        cell.reviewImageButtonPressed = { [weak self] in
            let vc = ReviewImageDetailViewController()
            var reviewImageUrls = [String]()
            self?.reviews[indexPath.row].images.forEach {
                reviewImageUrls.append($0.url)
            }
            vc.reviewImageDetailView.imageUrls = reviewImageUrls
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        cell.thumbBtnPressed = { [self] in
            common.sendRequest(url: "https://api.clayful.io/v1/products/reviews/\(self.reviews[indexPath.row].id)/helped/up", method: "post", params: ["customer":self.customerID], sender: "") { [self] resultJson in
                print(resultJson)
                let resultDic = resultJson as? [String:Any] ?? [:]
                if let errorCode = resultDic["errorCode"] as? String {
                    if errorCode == "duplicated-vote" {
                        self.present(common.alert(title: "공지", message: "이미 좋아요를 누른 제품입니다"), animated: true)
                    }
                }
                self.getReviewList()
            }
            
        }
        return cell
    }
}

extension Encodable {
    
    var toDictionary : [String: Any]? {
        guard let object = try? JSONEncoder().encode(self) else { return nil }
        guard let dictionary = try? JSONSerialization.jsonObject(with: object, options: []) as? [String:Any] else { return nil }
        return dictionary
    }
}

