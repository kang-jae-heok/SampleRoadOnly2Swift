//
//  FindPassViewController.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/09/23.
//

import UIKit
import Alamofire
class FindPassViewController: UIViewController {
    let findEmailView = FindPassView()
    override func loadView() {
        super.loadView()
        view = findEmailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
    }
    func setTarget() {
        findEmailView.topView.homeBtn.addTarget(self, action: #selector(touchHomeBtn), for: .touchUpInside)
        findEmailView.sendBtn.addTarget(self, action: #selector(touchSendBtn), for: .touchUpInside)
    }
    func sendEmail(){
        var params = [String:Any]()
        params.updateValue(findEmailView.emailTextField.textField.text!, forKey: "email")
        params.updateValue("reset-password", forKey: "scope")
        params.updateValue(3600, forKey: "expiresIn")
        sendRequest3(url: "https://api.clayful.io/v1/customers/verifications/emails", method: "post", params: params, sender: "") { resultJson in
            guard let resultDic = resultJson as? [String:Any]  else {return}
            print(resultDic)
            if resultDic["error"] != nil {
                self.present(self.common2.alert(title: "", message: "존재하지 않은 이메일입니다"), animated: true)
            }else{
                self.present(self.common2.alert(title: "", message: "메일이 정상적으로 전송되었습니다"), animated: true)
            }
        }
    }
    func sendRequest3(url: String, method: String, params: Dictionary<String, Any>, sender: String,  completion:@escaping (Any) -> Void) {
        AF.request(url,
                   method: HTTPMethod(rawValue: method),
                   parameters: params,
                   encoding: URLEncoding.httpBody,
                   headers: ["Content-Type":"application/x-www-form-urlencoded",
                             "Accept":"application/json",
                             "Accept-Encoding":"gzip",
                             "Authorization":"Bearer    eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjM4N2NkNjVkZGUxOWExZjdkNGM0NTk2ODhlZTJkNTk1MWZkZjRlYTI5ZWQ1OWE1NTc2MjBlOTI5Y2M4OTNiZTAiLCJyb2xlIjoiY2xpZW50IiwiaWF0IjoxNjU0NTc5NzQ0LCJzdG9yZSI6IlZLS1RZTjIzVEJFUS5GOVg5R0pKQkVFNVEiLCJzdWIiOiJYUzRVRVRCOFNFVkcifQ.G1j5SEaS-sjgRf1dPTr0l7zeIPNVPKVNw2Ga49FfUG0" ])
        //.validate(statusCode: 200..<300)
        
        .responseJSON { [self] (response) in
            //            print(response.result)
            print("sendURL -> " + url)
            print(params)
            //여기서 가져온 데이터를 자유롭게 활용하세요.
            //            print(params)
            //            print(response)
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                // error handling
                self.present(self.common2.alert(title: "", message: "메일이 정상적으로 전송되었습니다"), animated: true)
                print(error)
            }
        }
    }
    @objc func touchHomeBtn(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func touchSendBtn(){
        if findEmailView.sendBtn.backgroundColor == common2.pointColor() {
            sendEmail()
        }
        findEmailView.sendBtn.backgroundColor = common2.lightGray()
    
    }

}
