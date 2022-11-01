//
//  LoginViewController.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/09/22.
//

import UIKit

class LoginViewController: UIViewController {
    let loginView = LoginView()
    let mainVc = MainViewSController()
    let common = CommonS()
    override func loadView() {
        super.loadView()
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.loginBtn.addTarget(self, action: #selector(touchLoginBtn), for: .touchUpInside)
        loginView.findPassBtn.addTarget(self, action: #selector(touchFindBtn(sender:)), for: .touchUpInside)
        loginView.findEmailBtn.addTarget(self, action: #selector(touchFindBtn(sender:)), for: .touchUpInside)
        loginView.topView.homeBtn.addTarget(self, action: #selector(touchHomeBtn), for: .touchUpInside)
        loginView.kakaoBtn.addTarget(mainVc, action: #selector(mainVc.touchKakaoBtn), for: .touchUpInside)
        loginView.naverBtn.addTarget(mainVc, action: #selector(mainVc.touchNaverBtn), for: .touchUpInside)
        
    }
    @objc func touchLoginBtn(){
        if loginView.emailView.textField.text! != ""{
            if common.isValidEmail(testStr: loginView.emailView.textField.text!){
            }else{
                present(common.alert(title: "", message: "이메일을 확인해주세요."),animated: true)
            }
        }else{
            present(common.alert(title: "", message: "이메일을 입력해주세요."),animated: true)
        }
        if loginView.passView.textField.text! == ""{
            present(common.alert(title: "", message: "비밀번호를 입력해주세요."),animated: true)
        }else{
            loginFunc()
        }
    }
    @objc func touchFindBtn(sender: UIButton){
            var vc = UIViewController()
        if sender.titleLabel?.text == "비밀번호 찾기"{
            vc = FindPassViewController()
        }else{
            vc = FindEmailViewController()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func touchHomeBtn(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func loginFunc(){
        var params = [String:Any]()
        let email = loginView.emailView.textField.text
        let pass = loginView.passView.textField.text
        params.updateValue(email!, forKey: "email")
        params.updateValue(pass!, forKey: "password")
        
        common.sendRequest(url: "https://api.clayful.io/v1/customers/auth", method: "post", params: params, sender: ""){[self] resultJson in
            var resultDic = [String:Any]()
            resultDic = resultJson as! [String:Any]
            print(resultDic)
            if ((resultDic["token"] as? String) != nil) {
                let customerId = resultDic["customer"] as! String
                getCustomerInfo(customerId: customerId)
                common.checkTypeFormDone(customerId: customerId, vc: self)
            }else {
                if resultDic["errorCode"] as? String == "not-existing-customer" {
                    present(common.alert(title: "", message: "존재하지 않는 아이디입니다"), animated: true)
                }else if (resultDic["message"] as! String).contains("password") {
                    present(common.alert(title: "", message: "비밀번호가 일치하지 않습니다"), animated: true)
                }
            }
        }
        func getCustomerInfo(customerId: String){
            common.sendRequest(url: "https://api.clayful.io/v1/customers/\(customerId)", method: "get", params: [:], sender: "") { resultJson in
                print("결과")
                let userDic = resultJson as! [String:Any]
                let nameDic = userDic["name"] as! [String:Any]
                let birthDic = userDic["birthdate"] as! [String:Any]
                let rawBirth =  birthDic["raw"] as! String
                let convertBirth = rawBirth.prefix(10)
                print(userDic["email"]  as! String)
                print(userDic["mobile"]  as! String)
                print(nameDic["full"] as! String)
                print(convertBirth)
                print(String(describing: userDic["gender"]!))
                UserDefaults.standard.set(self.loginView.checkCheckBtn, forKey: "auto_login")
                UserDefaults.standard.set(customerId, forKey: "customer_id")
                UserDefaults.standard.set(userDic["email"] as! String, forKey: "user_email")
                UserDefaults.standard.set(userDic["mobile"] as! String, forKey: "user_mobile")
                UserDefaults.standard.set(nameDic["full"] as! String, forKey: "user_name")
                UserDefaults.standard.set(convertBirth, forKey: "user_birth")
                UserDefaults.standard.set(String(describing: userDic["gender"]), forKey: "user_gender")
            }
        }
    }


}
