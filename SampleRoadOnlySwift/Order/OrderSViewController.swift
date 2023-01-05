//
//  OrderViewController.swift
//  SampleLoad
//
//  Created by notegg on 2022/11/22.
//

import UIKit
import CRPickerButton

class OrderSViewController: UIViewController {
    let orderView = OrderSView()
    let common = CommonS()
    var orderListDic = [String:Any]()
    var orderInfoSavedDic = [String:Any]()
    var orderItemCount = 0
    var successOrderItemCount = 0
    var cartRootCount = 0
    var addedItemArr = [String]()
    var isSample = false
    var isFailed = false
    var isCart = false
    var isPickerChange = false
    
    init (orderListDic: [String:Any]) {
        super.init(nibName: nil, bundle: nil)
        self.orderListDic = orderListDic
        print("#####orderListDic")
        print(common.dicToJsonString(dic: orderListDic))
        print("끝")
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func loadView() {
        super.loadView()
        
        view = orderView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bindAction()
        setPickerBtn()
        orderView.firstPhonTextField.delegate = self
        orderView.secondPhonTextField.delegate = self
        orderView.thirdPhonTextField.delegate = self
        print("###여기")
        print(common.dicToJsonString(dic: orderListDic))
        setOrderText(disCount: 0, type: "none")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 배송 주소 설정
        if UserDefaults.standard.value(forKey: "address1") != nil {
            orderView.firstAddressLabel.text = UserDefaults.standard.string(forKey: "postcd")
            orderView.secondAddressLabel.text = UserDefaults.standard.string(forKey: "address2")
            UserDefaults.standard.removeObject(forKey: "address1")
            UserDefaults.standard.removeObject(forKey: "address2")
            UserDefaults.standard.removeObject(forKey: "postcd")
        }
        if UserDefaults.contains("coupon"){
            addedItemArr.removeAll()
            setOrderText(disCount: UserDefaults.standard.integer(forKey: "coupon") , type: "deliveryFee")
            orderView.couponDiscountPriceLabel.text = "\(common.numberFormatter(number: UserDefaults.standard.integer(forKey: "coupon")))원"
//            UserDefaults.standard.removeObject(forKey: "coupon")
        }else {
            addedItemArr.removeAll()
            setOrderText(disCount: 0, type: "none")
            orderView.couponDiscountPriceLabel.text = "0원"
        }
        
    }
    func setOrderText(disCount: Int, type: String) {
        var discountPrice = disCount
        if !UserDefaults.contains("coupon") {
            discountPrice = 0
        }
        if orderListDic["sample_list"] != nil {
            guard let sampleListDic = orderListDic["sample_list"] as? [[String:Any]] else {return}
            orderView.makeSampleInfoView(samples: sampleListDic)
            isSample = true
            UserDefaults.standard.set(true, forKey: "order_isSample")
            orderView.amountValueLabel.text = "무료"
            orderView.deliveryFeeValueLabel.text = "3,500원"
            orderView.totalPaymentLabel.text = "총 3,500원"
            orderView.getCouponButton.backgroundColor = common.gray()
        }else if orderListDic["product_list"] != nil {
            guard let productListDic = orderListDic["product_list"] as? [[String:Any]],
                  let priceDic = productListDic[0]["price"] as? [String:Any],
                  let salelDic = priceDic["sale"] as? [String:Any],
                  let rawPrice = salelDic["raw"] as? Int,
                  let quantity =  productListDic[0]["quantity"] as? Int
            else {return}
            orderView.makeSampleInfoView(samples: productListDic)
            let totalPrice = rawPrice * quantity
            if totalPrice < 50000 {
                if type == "deliveryFee" {
                    orderView.amountValueLabel.text = "\(common.numberFormatter(number: totalPrice))원"
                    orderView.deliveryFeeValueLabel.text = " \(common.numberFormatter(number: 3500 - discountPrice))원"
                    orderView.totalPaymentLabel.text = "총 \(common.numberFormatter(number: totalPrice + 3500 - discountPrice))원"
                }else {
                    orderView.amountValueLabel.text = "\(common.numberFormatter(number: totalPrice))원"
                    orderView.deliveryFeeValueLabel.text = "3,500원"
                    orderView.totalPaymentLabel.text = "총 \(common.numberFormatter(number: totalPrice + 3500 - discountPrice))원"
                }
            }else {
                orderView.amountValueLabel.text = "\(common.numberFormatter(number: totalPrice))원"
                orderView.deliveryFeeValueLabel.text = "무료"
                orderView.totalPaymentLabel.text = "총 \(common.numberFormatter(number: totalPrice))원"
                orderView.getCouponButton.backgroundColor = common.gray()
            }
            isSample = false
            isCart = false
            UserDefaults.standard.set(false, forKey: "order_isSample")
        }else if orderListDic["cart_list"] != nil {
            
            guard let cartListDicArr = orderListDic["cart_list"] as? [[String:Any]],
                  let totalPrice = orderListDic["total_price"] as? String,
                  let rawPrice = Int(totalPrice)
            else {return}
            orderView.makeSampleInfoView(samples: cartListDicArr)
            for i in 0...cartListDicArr.count - 1 {
                let cartListDic = cartListDicArr[i]
                guard let cartId = cartListDic["_id"] as? String else {return}
                addedItemArr.append(cartId)
            }
            if rawPrice < 50000 {
                if type == "deliveryFee" {
                    orderView.amountValueLabel.text = "\(common.numberFormatter(number: rawPrice))원"
                    orderView.deliveryFeeValueLabel.text = "\(common.numberFormatter(number:3500 - discountPrice))원"
                    orderView.totalPaymentLabel.text = "총 \(common.numberFormatter(number: rawPrice + 3500 - discountPrice))원"
                }else {
                    orderView.amountValueLabel.text = "\(common.numberFormatter(number: rawPrice))원"
                    orderView.deliveryFeeValueLabel.text = "\(common.numberFormatter(number:3500))원"
                    orderView.totalPaymentLabel.text = "총 \(common.numberFormatter(number: rawPrice + 3500 - discountPrice))원"
                }
            }else {
                orderView.amountValueLabel.text = "\(common.numberFormatter(number: rawPrice))원"
                orderView.deliveryFeeValueLabel.text = "무료"
                orderView.totalPaymentLabel.text = "총 \(common.numberFormatter(number: rawPrice))원"
            }
            
            print("####addedItem")
            print(addedItemArr)
            isSample = false
            isCart = true
            UserDefaults.standard.set(false, forKey: "order_isSample")
        }
    }
    func bindAction() {
        orderView.searchAddressButton.addTarget(self, action: #selector(searchAddressButtonTapped(_:)), for: .touchUpInside)
        orderView.creditSimpleButton.addTarget(self, action: #selector(paymentMethodButtonsTapped(_:)), for: .touchUpInside)
        orderView.accountTransferButton.addTarget(self, action: #selector(paymentMethodButtonsTapped(_:)), for: .touchUpInside)
        orderView.virtualAccountButton.addTarget(self, action: #selector(paymentMethodButtonsTapped(_:)), for: .touchUpInside)
        orderView.allAgreeButton.addTarget(self, action: #selector(allAgreeButtonTapped(_:)), for: .touchUpInside)
        orderView.checkPaymentButton.addTarget(self, action: #selector(agreeButtonsTapped(_:)), for: .touchUpInside)
        orderView.privacyInfoButton.addTarget(self, action: #selector(agreeButtonsTapped(_:)), for: .touchUpInside)
        orderView.savePaymentMethodButton.addTarget(self, action: #selector(savePaymentMethodButtonTapped(_:)), for: .touchUpInside)
        orderView.orderButton.addTarget(self, action: #selector(orderButtonTapped(_:)), for: .touchUpInside)
        orderView.backBtn.addTarget(self, action: #selector(backBtnTapped(_:)), for: .touchUpInside)
        orderView.firstAddressButton.addTarget(self, action: #selector(searchAddressButtonTapped(_:)), for: .touchUpInside)
        orderView.secondAddressButton.addTarget(self, action: #selector(searchAddressButtonTapped(_:)), for: .touchUpInside)
        orderView.getCouponButton.addTarget(self, action: #selector(getCouponButtonTapped), for: .touchUpInside)
    }
    
    @objc func getCouponButtonTapped() {
        if orderView.getCouponButton.backgroundColor == common.pointColor() {
            self.navigationController?.pushViewController(OrderCouponViewController(), animated: true)
        }
    }
    @objc func backBtnTapped(_ sender: UIButton) {
        if UserDefaults.contains("merchant_uid") {
            deleteOrder()
        }
        UserDefaults.standard.removeObject(forKey: "coupon")
        self.navigationController?.popViewController(animated: true)
    }
    @objc func orderButtonTapped(_ sender: UIButton) {
        if sender.isEnabled {
            if orderView.ordererNameTextField.text?.count == 0 {
                present(common.alert(title: "", message: "주문 고객 이름을 입력하세요"), animated: true)
                return
            }
            if orderView.secondPhonTextField.text?.count ?? 0 < 4 ||
                orderView.thirdPhonTextField.text?.count ?? 0 < 4 {
                present(common.alert(title: "", message: "주문 고객 번호를 입력하세요"), animated: true)
                return
            }
          
            if orderView.emailTextField.text?.count == 0 {
                present(common.alert(title: "", message: "주문 고객 이메일 입력하세요"), animated: true)
                return
            }
            if orderView.firstAddressLabel.text?.count == 0 ||
                orderView.secondAddressLabel.text?.count == 0 {
                present(common.alert(title: "", message: "배송지 주소를 입력하세요"), animated: true)
                return
            }
            if orderView.detailAddressTextField.text?.count == 0 {
                present(common.alert(title: "", message: "상세주소를 입력하세요"), animated: true)
                return
            }
            if !isPickerChange {
                present(common.alert(title: "", message: "배송 요청 사항을 선택해주세요"), animated: true)
                return
            }
            if orderView.firstPhonTextField.text?.count ?? 0 == 0  {
                orderView.firstPhonTextField.text = "010"
            }
            setUserDefaults()
           
                if isSample {
                    guard let productInfoArr = orderListDic["sample_list"] as? [[String:Any]] else {return}
                    orderItemCount = productInfoArr.count
                    setCartParams(productInfoArr: productInfoArr)
                    print("####productInfoArr")
                    print(productInfoArr)
                }else {
                    if isCart {
                        guard let cartInfoArr = orderListDic["cart_list"] as? [[String:Any]],
                              let product = cartInfoArr[0]["product"] as? [String:Any],
                              let id = cartInfoArr[0]["_id"] as? String
                        else {return}
                        insertOrder(itemId: id)
                    }else {
                        guard let productInfoArr = orderListDic["product_list"] as? [[String:Any]] else {return}
                        orderItemCount = productInfoArr.count
                        setCartParams(productInfoArr: productInfoArr)
                    }
                    
                }
            }
            
        
    }
    // UserDefualts 유저 정보 저장
    func setUserDefaults(){
        var userInfo = [
            "name": orderView.ordererNameTextField.text,
            "firstPhone": orderView.firstPhonTextField.text,
            "secondPhone": orderView.secondPhonTextField.text,
            "thirdPhone": orderView.thirdPhonTextField.text,
            "email": orderView.emailTextField.text
        ]
        var paymethod = String()
        if orderView.savePaymentMethodButton.isSelected {
            [orderView.creditSimpleButton, orderView.accountTransferButton, orderView.virtualAccountButton].forEach {
                if $0.isSelected {
                    paymethod = $0.titleLabel?.text ?? ""
                }
            }
            userInfo.updateValue(paymethod, forKey: "paymethod")
        }
        UserDefaults.standard.set(userInfo, forKey: "order_user_info")
    }
    //카트 파라미터 설정
    func setCartParams(productInfoArr: [[String:Any]]) {
        var paramsArr = [[String:Any]]()
        
        for i in 0...productInfoArr.count - 1 {
            var variant = String()
            guard let productId = productInfoArr[i]["_id"] as? String,
                  let variantsArr = productInfoArr[i]["variants"] as? [[String:Any]]
            else {return}
            for x in 0...variantsArr.count - 1 {
                guard let typesArr = variantsArr[x]["types"] as? [[String:Any]],
                      let variationDic = typesArr[0]["variation"] as? [String:Any],
                      let variantValue = variationDic["value"] as? String,
                      let variantId = variantsArr[x]["_id"] as? String
                else {return}
                if isSample {
                    if variantValue == "샘플" {
                        variant = variantId
                    }
                }else {
                    if variantValue != "샘플" {
                        variant = variantId
                    }
                }
            }
            var params = [String:Any]()
            if isSample {
                params.updateValue(1, forKey: "quantity")
            }else {
                params.updateValue(productInfoArr[0]["quantity"], forKey: "quantity")
            }
           
            params.updateValue(productId, forKey: "product")
            params.updateValue(variant, forKey: "variant")
         
            params.updateValue("BBJAWU65EV88", forKey: "shippingMethod")
            params.updateValue("orderId\(i)", forKey: "_id")
            paramsArr.append(params)
        }
        print("####paramsArr")
        print(paramsArr)
        insertOrder2(paramsArr: paramsArr)
        //addCart(paramsArr: paramsArr)`
    }
    func insertOrder2(paramsArr: [[String:Any]]) {
        var params = [String:Any]()
        if UserDefaults.contains("coupon") {
            let coupon = [
                "coupon": "DH8PZKCGBXCH",
                "item": "orderId0"
            ] as [String:String]
            print("#itemId")
            let shipping = [coupon] as [[String:Any]]
            let discount = ["shipping": shipping] as [String:Any]
            params.updateValue(common.dicToJsonString(dic: discount), forKey: "discount")
        }
        params.updateValue("clayful-iamport", forKey: "paymentMethod")
        params.updateValue(common.dicToJsonString(dic: setOrderInfo()), forKey: "address")
        params.updateValue("KRW", forKey: "currency")
        if orderView.requireTextField.isHidden {
            params.updateValue(orderView.selectRequireButton.titleLabel?.text ?? "", forKey: "request")
        }else {
            params.updateValue(orderView.requireTextField.text, forKey: "request")
        }
       
        if isSample {
            params.updateValue(common.objectTojsonString(from: ["UHAWQN6P3Y8V"]) , forKey: "tags")
        }
        params.updateValue(common.objectTojsonString(from: paramsArr) , forKey: "items")
        COMController.sendRequest("https://api.clayful.io/v1/customers/\(customerId2)/cart/checkout/order", params, self, #selector(insertOrderCallback(result:)))
    }
    // 카트 넣기
    func addCart(paramsArr: [[String:Any]]) {
        
        self.common.sendRequest(url: "https://api.clayful.io/v1/customers/\(self.customerId2)/cart/items", method: "post", params: paramsArr[cartRootCount], sender: "") {[self]  resultJson in
            print("###resultJson")
            print(resultJson)
            guard let resultDic = resultJson as? [String:Any] else {return}
            if resultDic["product"] != nil {
                //카트 정상적으로 들어갔을때
                guard let itemId = resultDic["_id"] as? String else {return}
                self.addedItemArr.append(itemId)
                if self.cartRootCount != self.orderItemCount - 1{
                    self.cartRootCount += 1
                    self.addCart(paramsArr: paramsArr)
                }else {
                    insertOrder(itemId: itemId)
                }
            }else {
                //카트 정상적으로 안 들어갔을때
                removeCart(itemIdArr: addedItemArr)
                present(common.alert(title: "", message: "카트 오류"), animated: true)
            }
        }
    }
    // 주문 만들기
    func insertOrder(itemId: String) {
        var params = [String:Any]()
        if UserDefaults.contains("coupon") {
            let coupon = [
                "coupon": "DH8PZKCGBXCH",
                "item": itemId
            ] as [String:String]
            print("#itemId")
            print(itemId)
            let shipping = [coupon]
            let discount = ["shipping": shipping]
            params.updateValue(common.dicToJsonString(dic: discount), forKey: "discount")
        }
        params.updateValue("clayful-iamport", forKey: "paymentMethod")
        params.updateValue(common.dicToJsonString(dic: setOrderInfo()), forKey: "address")
        params.updateValue("KRW", forKey: "currency")
        print(params)
        if orderView.requireTextField.isHidden {
            params.updateValue(orderView.selectRequireButton.titleLabel?.text ?? "", forKey: "request")
        }else {
            params.updateValue(orderView.requireTextField.text, forKey: "request")
        }
        if isSample {
            params.updateValue(common.objectTojsonString(from: ["UHAWQN6P3Y8V"]) , forKey: "tags")
        }
        var queryItems = String()
        for i in 0...addedItemArr.count - 1 {
            queryItems += ",\(addedItemArr[i])"
        }
        print("#####params")
        queryItems.remove(at: queryItems.startIndex)
        print(queryItems)
        COMController.sendRequest("https://api.clayful.io/v1/customers/\(customerId2)/cart/checkout/order?items=\(queryItems)", params, self, #selector(insertOrderCallback(result:)))
        
    }
    // 주문 만들기 callback
    @objc func insertOrderCallback(result :NSData) {
        guard var resultDic = common.JsonToDictionary(data: result) else {return}
        print("#####json")
        print(common.dicToJsonString(dic: resultDic))
        if resultDic["order"] != nil {
            guard let orderDic = resultDic["order"] as? [String:Any],
                  let orderId = orderDic["_id"] as? String
            else {return}
            resultDic.updateValue(orderId, forKey: "merchant_uid")
            pushIamportView(dic: resultDic)
        }else {
            present(common.alert(title: "에러", message: "잠시후에 다시 시도해주세요"), animated: true)
            self.navigationController?.popViewController(animated: true)
        }
    }
    // 주문 업데이트
    func updateOrder(){
        var params = [String:Any]()
        let orderId = UserDefaults.standard.string(forKey: "merchant_uid") ?? ""
   
        if UserDefaults.standard.bool(forKey: "order_isSample") {
            params.updateValue(common.objectTojsonString(from: ["UHAWQN6P3Y8V"]) , forKey: "tags")
        }
        if orderView.requireTextField.isHidden {
            params.updateValue(orderView.selectRequireButton.titleLabel?.text ?? "", forKey: "request")
        }else {
            params.updateValue(orderView.requireTextField.text, forKey: "request")
        }
        params.updateValue(common.dicToJsonString(dic: setOrderInfo()), forKey: "address")
        print("###params업데이트")
        print(params)
        COMController.sendRequest(withMethod: "put", "https://api.clayful.io/v1/orders/\(orderId)", params, self, #selector(updateOrderCallback(result:)))
    }
    // 주문 업데이트 callback
    @objc func updateOrderCallback(result: NSData) {
        guard let resultDic = common.JsonToDictionary(data: result) else {return}
        print("#####json")
        var convertDic = [String:Any]()
        print(common.dicToJsonString(dic: resultDic))
        if resultDic["_id"] != nil {
            guard let orderId = resultDic["_id"] as? String
            else {return}
            convertDic = ["order":resultDic]
            convertDic.updateValue(orderId, forKey: "merchant_uid")
            pushIamportView(dic: convertDic)
        }
    }
    // iamportviewcontroller push
    func pushIamportView(dic: [String:Any]){
        var sendDic = dic
        if orderView.creditSimpleButton.isSelected {
            sendDic.updateValue("card", forKey: "payMethod")
        }else if orderView.accountTransferButton.isSelected {
            sendDic.updateValue("trans", forKey: "payMethod")
        }else if orderView.virtualAccountButton.isSelected {
            sendDic.updateValue("vbank", forKey: "payMethod")
        }
        if isSample {
            sendDic.updateValue("샘플받아보기", forKey: "name")
        }else {
            if isCart {
                guard let cartInfoArr = orderListDic["cart_list"] as? [[String:Any]] else {return}
                guard let productDic = cartInfoArr[0]["product"] as? [String:Any] else {return}
                guard let name = productDic["name"] as? String else {return}
                var convertName = String()
                if cartInfoArr.count == 1 {
                    convertName = "\(name)"
                }else {
                    convertName = "\(name) 외 \(cartInfoArr.count - 1)개"
                }
                sendDic.updateValue(convertName, forKey: "name")
            }else {
                guard let productInfoArr = orderListDic["product_list"] as? [[String:Any]] else {return}
                guard let name = productInfoArr[0]["name"] as? String else {return}
                sendDic.updateValue(name, forKey: "name")
            }
        }
        self.navigationController?.pushViewController(IamportViewController(initDic: sendDic), animated: true)
    }
    // 주문 정보 set
    func setOrderInfo() -> [String: Any]{
        //        var shippingDic = [String:Any]()
        let phoneNum = (orderView.firstPhonTextField.text ?? "") + (orderView.secondPhonTextField.text ?? "") + (orderView.secondPhonTextField.text ?? "")
        let addressInfoDic = [
            "postcode": orderView.firstAddressLabel.text ?? "",
            "country": "KR",
            "city": orderView.secondAddressLabel.text!.prefix(2),
            "address1": orderView.secondAddressLabel.text ?? "",
            "address2": orderView.detailAddressTextField.text ?? "",
            "mobile": phoneNum,
            "name": ["full": orderView.ordererNameTextField.text ?? ""]
        ] as [String : Any]
        let address = [
            "shipping": addressInfoDic,
            "billing":  addressInfoDic
        ] as [String : Any]
        print("#####city")
        print(orderView.secondAddressLabel.text!.prefix(2))
        return address
        
    }
    //카트 지우기
    func removeCart(itemIdArr: [String]){
        for i in 0...itemIdArr.count - 1 {
            common.sendRequest(url: "https://api.clayful.io/v1/customers/\(customerId2)/cart/items/\(itemIdArr[i])", method: "delete", params: [:], sender: "") { resultJson in
                print("#####remove success")
            }
        }
    }
    // 주문 취소
    func cancelOrder(){
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
    func deleteOrder(){
        if UserDefaults.contains("merchant_uid") {
            var params = [String:Any]()
            let orderId = UserDefaults.standard.string(forKey: "merchant_uid") ?? ""
            UserDefaults.standard.removeObject(forKey: "pay_callback")
            common.sendRequest(url: "https://api.clayful.io/v1/orders/\(orderId)", method: "delete", params: [:], sender: "") { resultJson in
                print(resultJson)
                UserDefaults.standard.removeObject(forKey: "merchant_uid")
                UserDefaults.standard.removeObject(forKey: "coupon")
            }
        }
    }
    func setPickerBtn() {
        orderView.selectRequireButton.pickerViewDelegate = self
        orderView.selectRequireButton.pickerViewDataSource = self
        orderView.selectRequireButton.delegate = self
        orderView.selectRequireButton.setTitleForDoneButton("완료", color: common.pointColor())
    }
    @objc func searchAddressButtonTapped(_ sender: UIButton) {
        guard let serverURL = UserDefaults.standard.string(forKey: "SERVER_URL")
        else {return}
        let rURL = URL(string: serverURL + "daum_address_ios.html")
        let vc = ComWebViewController(url: rURL!.absoluteString)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func savePaymentMethodButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    @objc func paymentMethodButtonsTapped(_ sender: UIButton) {
        [
            orderView.creditSimpleButton,
            orderView.accountTransferButton,
            orderView.virtualAccountButton
        ].forEach {
            $0.isSelected = false
            $0.backgroundColor = .white
            $0.layer.borderColor = common.lightGray().cgColor
        }
        sender.isSelected = true
        sender.backgroundColor = common.pointColor()
        sender.layer.borderColor = common.pointColor().cgColor
        
    }
    @objc func agreeButtonsTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if orderView.checkPaymentButton.isSelected && orderView.privacyInfoButton.isSelected {
            orderView.allAgreeButton.isSelected = true
            orderView.orderButton.isEnabled = true
        }else {
            orderView.allAgreeButton.isSelected = false
            orderView.orderButton.isEnabled = false
            
        }
    }
    @objc func allAgreeButtonTapped(_ sender: UIButton) {
        if orderView.allAgreeButton.isSelected {
            orderView.orderButton.isEnabled = false
            orderView.allAgreeButton.isSelected = false
            orderView.checkPaymentButton.isSelected = false
            orderView.privacyInfoButton.isSelected = false
        }else {
            orderView.orderButton.isEnabled = true
            orderView.allAgreeButton.isSelected = true
            orderView.checkPaymentButton.isSelected = true
            orderView.privacyInfoButton.isSelected = true
        }
    }
    
}
extension OrderSViewController: UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, CRPickerButtonDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        common2.checkMaxLength(textField: orderView.firstPhonTextField, maxLength: 3)
        common2.checkMaxLength(textField: orderView.secondPhonTextField, maxLength: 4)
        common2.checkMaxLength(textField: orderView.thirdPhonTextField, maxLength: 4)
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow: Int) {
        print("Done Button Detected", orderView.orderModel.shippingRequest[titleForRow])
    }
    
 
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return orderView.orderModel.shippingRequest.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return orderView.orderModel.shippingRequest[row]
    }


    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        orderView.selectRequireButton.setTitle(orderView.orderModel.shippingRequest[row], for: .normal)
        orderView.selectRequireButton.setTitleColor(.black, for: .normal)
        if orderView.orderModel.shippingRequest[row] == "직접 입력" {
            orderView.requireTextField.isHidden = false
        }else {
            orderView.requireTextField.isHidden = true
        }
        orderView.layoutIfNeeded()
        isPickerChange = true
        
    }
}

