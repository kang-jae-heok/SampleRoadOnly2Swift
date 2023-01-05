//
//  ChartWebView.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/12/06.
//

import Foundation

class ChartWebView: UIView {
    var webView = WKWebView()
    var arr = [String]()
    init(frame: CGRect, arr: [String]) {
        super.init(frame: frame)
        self.arr = arr
        setWebView()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    func setWebView() {
        
        let jscript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
        let userScript = WKUserScript(source: jscript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let wkUController = WKUserContentController()
        wkUController.addUserScript(userScript)
        let wkWebConfig = WKWebViewConfiguration()
        wkWebConfig.userContentController = wkUController
        WKWebsiteDataStore.default().removeData(ofTypes: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache], modifiedSince: Date(timeIntervalSince1970: 0), completionHandler:{ })
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: screenBounds2.width/2 - margin2, height: screenBounds2.width/2), configuration: wkWebConfig)
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        let params0 = arr[0]
        let params1 = arr[1]
        let params2 = arr[2]
        let params3 = arr[3]
        let params4 = arr[4]
        
        
        
        let url = URL(string: "http://110.165.17.124/sampleroad/sampleroad_chart.html?Params0=\(params0)&Params1=\(params1)&Params2=\(params2)&Params3=\(params3)&Params4=\(params4)")
        let request = URLRequest(url: url!)
        //self.webView?.allowsBackForwardNavigationGestures = true  //뒤로가기 제스쳐 허용
        webView.configuration.preferences.javaScriptEnabled = true  //자바스크립트 활성화
        webView.load(request)
        webView.frame = CGRect(x: 0, y: 0, width: screenBounds2.width/2 - margin2, height: screenBounds2.width/2)
        self.addSubview(webView)
        print("3######")
        print(webView.frame)
    }
}
extension ChartWebView: WKUIDelegate, WKNavigationDelegate {
//    func didReceiveMemoryWarning() { didReceiveMemoryWarning() }
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void){
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in completionHandler() }))
        }

    //confirm 처리
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "취소", style: .default, handler: { (action) in completionHandler(false) }))
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in completionHandler(true) }))
         }
    
    // href="_blank" 처리
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil { webView.load(navigationAction.request) }
        return nil }
}
