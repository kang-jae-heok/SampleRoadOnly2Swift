//
//  WebView.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/10/07.
//

import Foundation
import WebKit

class WebView : UIView{
    var webView = WKWebView()
    let common = CommonS()
    let screenBounds = UIScreen.main.bounds
    override init(frame: CGRect) {
        super.init(frame: frame)
        setWebView()
        addSubviewFunc()
        setLayout()
     
    }
    required init(coder: NSCoder) {
        fatalError("init fail")
    }
    func setLayout(){
        webView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    func addSubviewFunc(){
        self.addSubview(webView)
    }
    func setWebView(){
        let jscript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
        let userScript = WKUserScript(source: jscript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let wkUController = WKUserContentController()
        wkUController.addUserScript(userScript)
        let wkWebConfig = WKWebViewConfiguration()
        wkWebConfig.userContentController = wkUController
        WKWebsiteDataStore.default().removeData(ofTypes: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache], modifiedSince: Date(timeIntervalSince1970: 0), completionHandler:{ })
        webView = WKWebView(frame: frame, configuration: wkWebConfig)
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        let url = URL(string: "https://ordergray1.typeform.com/to/Kv5D3HHI")
        let request = URLRequest(url: url!)
        self.webView.allowsBackForwardNavigationGestures = true  //뒤로가기 제스쳐 허용
        webView.configuration.preferences.javaScriptEnabled = true  //자바스크립트 활성화
        webView.load(request)
    }
     
}
extension WebView: WKUIDelegate, WKNavigationDelegate{

//    override func didReceiveMemoryWarning() { window?.rootViewController!.didReceiveMemoryWarning() }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void){
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in completionHandler() }))
        window?.rootViewController!.present(alertController, animated: true, completion: nil) }

    //confirm 처리
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "취소", style: .default, handler: { (action) in completionHandler(false) }))
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in completionHandler(true) }))
        window?.rootViewController!.present(alertController, animated: true, completion: nil) }
    
    // href="_blank" 처리
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil { webView.load(navigationAction.request) }
        return nil }
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
//
//    }
    func webView(_ webView: WKWebView,decidePolicyFor navigationAction: WKNavigationAction,decisionHandler: @escaping (WKNavigationActionPolicy) -> Void){
        print("hi")
        print(navigationAction.request.url?.absoluteString)
        print(navigationAction.request.url?.absoluteString.contains("http://110.165.17.124/sampleroad/db/surve"))
        let bool = navigationAction.request.url?.absoluteString.contains("http://110.165.17.124/sampleroad/db/surve") ?? false
        if (bool) {
            print("완료")
            let arr = navigationAction.request.url?.absoluteString.components(separatedBy: "http://110.165.17.124/sampleroad/db/survey.php?") ?? ["" , ""]
            let quaryData = arr[1] as String ?? ""
            let separateDataArr = quaryData.components(separatedBy: "&")
            print(arr)
            print(separateDataArr)
            var dataDic = [String:String]()
            for i in 0...separateDataArr.count - 1{
                let a = separateDataArr[i].components(separatedBy: "=")
                let b = a[1].removingPercentEncoding!
                let c = String(b.filter { !" \n\t\r".contains($0) })
                dataDic.updateValue(c, forKey: a[0])
            }
            print(dataDic)
            dataDic.updateValue(UserDefaults.standard.string(forKey: "customer_id") ?? "", forKey: "customer_id")
            common.sendRequest(url: "http://110.165.17.124/sampleroad/db/survey.php", method: "post", params: dataDic, sender: ""){resultJson in
                print(resultJson)
                let errorCode = resultJson as! [String: Any]
                if errorCode["error"] as! String == "1"{
                    let vc = MainContentViewController()
                    self.parentViewController?.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        decisionHandler(.allow)
    }
}
    