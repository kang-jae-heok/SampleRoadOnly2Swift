//
//  CertificationViewController.swift
//  sampleroad
//
//  Created by NOTEGG on 2022/08/10.
//  Copyright © 2022 CNKANG. All rights reserved.
//

import UIKit

@objc class CertificationViewController: UIViewController {
    
    var impUid = String()
    @objc init(impUid: String) {
        self.impUid = impUid
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        selectToken()
    }
    

    
    @objc func selectToken() {
        var params:[String:Any] = [:]
 
        params.updateValue("7205042348128009", forKey: "imp_key")
        params.updateValue("e78e7afbf7be418d3b1f45912e35fb04b976885e6b32c3eab8bf38a0d383de3ba7bbb7ec0df99ba0", forKey: "imp_secret")
        print("파라미터")
        print(params)
        
        COMController.sendRequest("https://api.iamport.kr/users/getToken", params, self, #selector(selectTokenCallback(result:)))
        
    }
    
    
    
    @objc func selectTokenCallback(result :NSData) {
        let common = CommonSwift()
      

        let tokenDic = common.JsonToDictionary(data: result)!
        NSLog("selectTokenCallback : %@", tokenDic);
        let responseDic = tokenDic["response"] as! [String:Any]
        let accessToken = responseDic["access_token"] as! String
        print(accessToken)
        
        selectPhoneNum(token: accessToken)
    }
    
    @objc func selectPhoneNum(token:String) {
        
        var params:[String:Any] = [:]
 
        params.updateValue(token, forKey: "access_token")
        
        COMController.sendRequestGet("https://api.iamport.kr/certifications/\(impUid)", params, self, #selector(selectPhoneNumCallback(result:)))
    }
    
    
    
    @objc func selectPhoneNumCallback(result :NSData) {
        let common = CommonSwift()
        let phoneDic = common.JsonToDictionary(data: result)!
        NSLog("selectPhoneNumCallback : %@", phoneDic)
        if (phoneDic["message"] is NSNull) {
            if (phoneDic["response"] != nil) {
                let response:[String:Any] = phoneDic["response"] as! [String:Any]
                print(phoneDic)
                if response["phone"] != nil {
                    if (response["phone"] as! String != "<null>") {
                        UserDefaults.standard.set(response["phone"] as! String, forKey: "phone")
                    }
                }
              
            }
        }else{
        
            Common.alert(phoneDic["message"] as! String)
        }
        self.navigationController?.popViewController(animated: false)
  
    }

}

