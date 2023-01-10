//
//  ChartViewController.swift
//  sampleroad
//
//  Created by NOTEGG on 2022/07/12.
//  Copyright © 2022 CNKANG. All rights reserved.
//

import UIKit
import WebKit

@objc class ChartViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    var webViewRect = CGRect()
    var screenBounds = CGRect()
    var arr = Array<Any>()
    @objc init(webViewRect: CGRect, arr: Array<Any>) {
        self.webViewRect = webViewRect
        self.arr = arr
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    var webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame = CGRect(x: 0, y: 0, width: self.webViewRect.size.width, height: self.webViewRect.size.height);
        
        let jscript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
        let userScript = WKUserScript(source: jscript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let wkUController = WKUserContentController()
        wkUController.addUserScript(userScript)
        let wkWebConfig = WKWebViewConfiguration()
        wkWebConfig.userContentController = wkUController
        WKWebsiteDataStore.default().removeData(ofTypes: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache], modifiedSince: Date(timeIntervalSince1970: 0), completionHandler:{ })
        webView = WKWebView(frame: self.webViewRect, configuration: wkWebConfig)
        
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

        view.addSubview(webView)
    }
    
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() } //모달창 닫힐때 앱 종료현상 방지.
        
        //alert 처리
        func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String,
                     initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void){
            let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in completionHandler() }))
            self.present(alertController, animated: true, completion: nil) }

        //confirm 처리
        func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
            let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "취소", style: .default, handler: { (action) in completionHandler(false) }))
            alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in completionHandler(true) }))
            self.present(alertController, animated: true, completion: nil) }
        
        // href="_blank" 처리
        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if navigationAction.targetFrame == nil { webView.load(navigationAction.request) }
            return nil }

}
