//
//  IamportViewController.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/10/26.
//

import UIKit
import WebKit
@objc class IamportViewController: UIViewController {
    var infoDic = [String:Any]()
    let topView = UIView().then{
        $0.backgroundColor = .white
    }
    let backBtn = UIButton().then{
        $0.setImage(UIImage(named: "back_btn"), for: .normal)
        $0.contentHorizontalAlignment = .left
        $0.addTarget(self, action: #selector(touchBackBtn), for: .touchUpInside)
    }
    lazy var wkWebView: WKWebView = {
        var view = WKWebView()
        view.backgroundColor = UIColor.clear
        view.navigationDelegate = self
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        view.configuration.preferences = preferences
        return view
    }()
    @objc init(initDic: [String:Any]) {
        super.init(nibName: nil, bundle: nil)
        self.infoDic = initDic
       
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print("결제 딕셔너리")
        addSubviewFunc()
        setLayout()
        print("####infodic")
        print(common2.dicToJsonString(dic: infoDic))
        print("###끝")
        // 결제 환경 설정
        callIamport()
    }
    func setLayout(){
        if UIDevice.current.hasNotch {
            topView.snp.makeConstraints{
                let window = UIApplication.shared.keyWindow
                let topPadding = window?.safeAreaInsets.top
                $0.top.equalToSuperview().offset(topPadding!)
                $0.left.right.equalToSuperview()
                $0.bottom.equalTo(view.snp.top).offset(90)
            }
        }else{
            topView.snp.makeConstraints{
                $0.top.left.right.equalToSuperview()
                $0.bottom.equalTo(view.snp.top).offset(90)
            }
        }
      
        wkWebView.snp.makeConstraints{
            $0.top.equalTo(topView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
        backBtn.snp.makeConstraints{
            $0.left.equalToSuperview().offset(17)
            $0.size.equalTo(CGSize(width: 50, height: 50))
            $0.centerY.equalToSuperview()
        }
    }
    func addSubviewFunc(){
        [wkWebView,topView].forEach{
            view.addSubview($0)
        }
        topView.addSubview(backBtn)
    }
    @objc func touchBackBtn(){
        guard let merchantUid = infoDic["merchant_uid"] as? String else {return}
        UserDefaults.standard.set("failed-customer", forKey: "pay_callback")
        UserDefaults.standard.set(merchantUid, forKey: "merchant_uid")
        deleteOrder()
    }
    
    func callIamport() {
        IAMPortPay.sharedInstance.configure(scheme: "sampleroad",              // info.plist에 설정한 scheme
                                            storeIdentifier: "imp11823150")     // iamport 에서 부여받은 가맹점 식별코드
        IAMPortPay.sharedInstance              // PG사 타입
            .setIdName(nil)                         // 상점아이디 ({PG사명}.{상점아이디}으로 생성시 사용)                 // 결제 형식
            .setWKWebView(self.wkWebView)           // 현재 Controller에 있는 WebView 지정
            .setRedirectUrl(nil)
        
//        if (UserDefaults.standard.bool(forKey: "BILLING_TEST")) {
            IAMPortPay.sharedInstance.setPGType(.html5_inicis)
//        }else {
//            IAMPortPay.sharedInstance.setPGType(.html5_inicis_prdc)
//        }
        guard let orderDic = infoDic["order"] as? [String:Any],
              let totalDic = orderDic["total"] as? [String:Any],
              let customerDic = orderDic["customer"] as? [String:Any],
              let nameDic = customerDic["name"] as? [String:Any],
              let addressDic = orderDic["address"] as? [String:Any],
              let shippingDic = addressDic["shipping"] as? [String:Any],
              let buyerNameDic = shippingDic["name"] as? [String:Any],
              let productName = infoDic["name"] as? String,
              let merchantUid = infoDic["merchant_uid"] as? String,
              let payMethod = infoDic["payMethod"] as? String,
              let amount = totalDic["amount"] as? Int,
              let email = customerDic["email"] as? String,
              let buyerName = buyerNameDic["full"] as? String,
              let mobile = shippingDic["mobile"] as? String,
              let address1 = shippingDic["address1"] as? String,
              let address2 = shippingDic["address2"] as? String,
              let postCode = shippingDic["postcode"] as? String
        else {return}
 
        
        if (payMethod == "card") {
            IAMPortPay.sharedInstance.setPayMethod(.card)
        }else if (payMethod == "trans"){
            IAMPortPay.sharedInstance.setPayMethod(.trans)
        }else {
            IAMPortPay.sharedInstance.setPayMethod(.vbank)
        }
        
        
        
        // 결제 정보 데이타
        let parameters: IAMPortParameters = [
            "merchant_uid": merchantUid,
            "name": productName,
            "amount": amount,
            "buyer_email": email,
            "buyer_name": buyerName,
            "buyer_tel": mobile,
            "buyer_addr": address1 + address2,
            "buyer_postcode": postCode,
            "custom_data": ["A1": 123, "B1": "Hello"]
            //"custom_data": "24"
        ]
        IAMPortPay.sharedInstance.setParameters(parameters).commit()
        
        // 결제 웹페이지(Local) 파일 호출
        if let url = IAMPortPay.sharedInstance.urlFromLocalHtmlFile() {
            let request = URLRequest(url: url)
            
            DispatchQueue.main.async {
                self.wkWebView.load(request)
            }
          
        }
    }
    
}

extension IamportViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let request = navigationAction.request
        
        IAMPortPay.sharedInstance.requestRedirectUrl(for: request, parser: { (data, response, error) -> Any? in
            // Background Thread 처리
            var resultData: [String: Any]?
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                switch statusCode {
                case 200:
                    resultData = [
                        "isSuccess": "OK"
                    ]
                    break
                default:
                    break
                }
            }

            return resultData
        }) { (pasingData) in
            // Main Thread 처리

        }
        
        let result = IAMPortPay.sharedInstance.requestAction(for: request)
        decisionHandler(result ? .allow : .cancel)
        
        
        let webUrl:String = webView.url!.absoluteString
        let sUrl = UserDefaults.standard.string(forKey:"PAY_SUCCESS_URL")!
        let fUrl = UserDefaults.standard.string(forKey:"PAY_FAILED_URL")!
        let vUrl = UserDefaults.standard.string(forKey: "VBANK_SUCCESS_URL")!
        
        if (webUrl.contains(sUrl)) {
            //결제성공
            print("결제성공")
            // imp_uid= 뒤로뽑기 -> 2차개발 새로운 뷰 띄우기(내역같은거) -> customerAlert
            UserDefaults.standard.set("success", forKey: "pay_callback")
            if UserDefaults.standard.bool(forKey: "order_isSample"){
                print("샘플 구매")
                addSample()
            }
            UserDefaults.standard.removeObject(forKey: "coupon")
//            deleteCart()
            self.navigationController?.pushViewController(OrderCompleteViewController(initDic: infoDic), animated: true)
        }
        
        if (webUrl.contains(fUrl)) {
            //결제실패
            print("결제실패")
            // popviewcontroller ->
            UserDefaults.standard.set("failed-store", forKey: "pay_callback")
            UserDefaults.standard.set(nil, forKey: "sample_order")
            deleteOrder()
            
        }
        if (webUrl.contains(vUrl)) {
            print("가상계좌 성공")
//            deleteCart()
            UserDefaults.standard.removeObject(forKey: "coupon")
            self.navigationController?.pushViewController(OrderCompleteViewController(initDic: infoDic), animated: true)
            
        }
    }
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
            common2.sendRequest(url: "https://api.clayful.io/v1/orders/\(orderId)/cancellation", method: "post", params: params, sender: "") { resultJson in
                print(resultJson)
                UserDefaults.standard.removeObject(forKey: "merchant_uid")
                UserDefaults.standard.removeObject(forKey: "coupon")
                self.navigationController?.popViewController(animated: false)
            }
        }
    }
    func deleteOrder(){
        if UserDefaults.contains("merchant_uid") {
            let orderId = UserDefaults.standard.string(forKey: "merchant_uid") ?? ""
            UserDefaults.standard.removeObject(forKey: "pay_callback")
            common2.sendRequest(url: "https://api.clayful.io/v1/orders/\(orderId)", method: "delete", params: [:], sender: "") { resultJson in
                print(resultJson)
                UserDefaults.standard.removeObject(forKey: "merchant_uid")
                UserDefaults.standard.removeObject(forKey: "coupon")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    func addSample(){
        guard let orderDic = infoDic["order"] as? [String:Any],
              let itmesDicArr = orderDic["items"] as? [[String:Any]]
        else {return}
        var sampleIdStr = String()
        for i in 0...itmesDicArr.count - 1 {
            guard let prdcId = itmesDicArr[i]["product"] as? String else {return}
            sampleIdStr += "," + prdcId
        }
        sampleIdStr.remove(at: sampleIdStr.startIndex)
        var params = [String:Any]()
        params.updateValue(customerId2, forKey: "customer_id")
        params.updateValue(sampleIdStr, forKey: "product_id")
        params.updateValue(1, forKey: "insert")
        common2.sendRequest(url: "http://110.165.17.124/sampleroad/v1/sample.php" , method: "post", params: params, sender: "") { resultJson in
            print(resultJson)
        }
    }
    func deleteCart(){
        
        guard let orderDic = infoDic["order"] as? [String:Any],
              let itemsDicArr = orderDic["items"] as? [[String:Any]]
        else {return}
        let custId = customerId2
        for i in 0...itemsDicArr.count - 1 {
            guard let productId = itemsDicArr[i]["_id"] as? String else {return}
            common2.sendRequest(url: "https://api.clayful.io/v1/customers/\(custId)/cart/items/\(productId)" , method: "delete", params: [:], sender: "") { resultJson in
                print("\(i)번째")
                print(resultJson)
            }
        }
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // 결제 환경으로 설정에 의한 웹페이지(Local) 호출 결과
        IAMPortPay.sharedInstance.requestIAMPortPayWKWebViewDidFinishLoad(webView) { (error) in
            if error != nil {
                switch error! {
                case .custom(let reason):
                    print("requestIAMPortPayWKWebViewDidFinishLoad error: \(reason)")
                    break
                }
            }else {
                print("OK")
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("didFail")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("didFailProvisionalNavigation \(error.localizedDescription)")
    }
    

}
