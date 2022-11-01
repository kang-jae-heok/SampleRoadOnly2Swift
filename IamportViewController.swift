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
        return view
    }()
    @objc init(initDic: [String:Any]) {
        super.init(nibName: nil, bundle: nil)
        self.infoDic = initDic
        print(initDic)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviewFunc()
        setLayout()
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
        UserDefaults.standard.set("failed", forKey: "pay_callback")
        self.navigationController?.popViewController(animated: false)
    }
    
    func callIamport() {
        IAMPortPay.sharedInstance.configure(scheme: "sampleroad",              // info.plist에 설정한 scheme
                                            storeIdentifier: "imp11823150")     // iamport 에서 부여받은 가맹점 식별코드
        IAMPortPay.sharedInstance              // PG사 타입
            .setIdName(nil)                         // 상점아이디 ({PG사명}.{상점아이디}으로 생성시 사용)                 // 결제 형식
            .setWKWebView(self.wkWebView)           // 현재 Controller에 있는 WebView 지정
            .setRedirectUrl(nil)
        
        if (UserDefaults.standard.bool(forKey: "BILLING_TEST")) {
            IAMPortPay.sharedInstance.setPGType(.html5_inicis)
        }else {
            IAMPortPay.sharedInstance.setPGType(.html5_inicis_prdc)
        }
        
        var payMethod = infoDic["payMethod"] as! String
        
        if (payMethod == "card") {
            IAMPortPay.sharedInstance.setPayMethod(.card)
        }else if (payMethod == "trans"){
            IAMPortPay.sharedInstance.setPayMethod(.trans)
        }else {
            IAMPortPay.sharedInstance.setPayMethod(.vbank)
        }
        
        // 결제 정보 데이타
        let parameters: IAMPortParameters = [
            "merchant_uid": infoDic["merchant_uid"] as! String,
            "name": infoDic["name"] as! String,
            "amount": infoDic["amount"] as! String,
            "buyer_email": infoDic["buyer_email"] as! String,
            "buyer_name": infoDic["buyer_name"] as! String,
            "buyer_tel": infoDic["buyer_tel"] as! String,
            "buyer_addr": infoDic["buyer_addr"] as! String,
            "buyer_postcode": infoDic["buyer_postcode"] as! String,
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
        
        if (webUrl.contains(sUrl)) {
            //결제성공
            print("결제성공")
            // imp_uid= 뒤로뽑기 -> 2차개발 새로운 뷰 띄우기(내역같은거) -> customerAlert
            UserDefaults.standard.set("success", forKey: "pay_callback")
            Common.customAlert1("주문완료", "주문이 완료되었습니다.\nMy - 주문/배송 메뉴에서 주문내역을 확인가능합니다.")
            Common.goMain()
        }
        
        if (webUrl.contains(fUrl)) {
            //결제실패
            print("결제실패")
            // popviewcontroller ->
            UserDefaults.standard.set("failed", forKey: "pay_callback")
            self.navigationController?.popViewController(animated: false)
            
            
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
