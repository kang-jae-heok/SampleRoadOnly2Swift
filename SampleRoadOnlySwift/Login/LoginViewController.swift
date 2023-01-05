//
//  LoginViewController.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/09/22.
//

import UIKit
import Foundation
import NaverThirdPartyLogin
import Alamofire
class LoginViewController: UIViewController {
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
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
        loginView.kakaoBtn.addTarget(self, action: #selector(touchKakaoBtn), for: .touchUpInside)
        loginView.naverBtn.addTarget(self, action: #selector(touchNaverBtn), for: .touchUpInside)
        
    }
    @objc func touchKakaoBtn(){
        common.kakaoLogin(vc: self)

    }
    @objc func touchNaverBtn(){
        if NaverThirdPartyLoginConnection
            .getSharedInstance()
            .isPossibleToOpenNaverApp() // Naver App이 깔려있는지 확인하는 함수
        {
            loginInstance?.requestThirdPartyLogin()
        } else { // 네이버 앱 안깔려져 있을때
            print("네이버 안깔려있음")
            loginInstance?.requestThirdPartyLogin()
        }
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
                getCustomerInfo2(customerId: customerId)
            }else {
                if resultDic["errorCode"] as? String == "not-existing-customer" {
                    present(common.alert(title: "", message: "존재하지 않는 아이디입니다"), animated: true)
                }else if (resultDic["message"] as! String).contains("password") {
                    present(common.alert(title: "", message: "비밀번호가 일치하지 않습니다"), animated: true)
                }
            }
        }
    }
 
    func getCustomerInfo2(customerId: String){
        common.sendRequest(url: "https://api.clayful.io/v1/customers/\(customerId)", method: "get", params: [:], sender: "") { resultJson in
            print("결과")
            print(resultJson)
            var gender = String()
            var email = String()
            var mobile = String()
            var name = String()
            var convertBirth = String()
            if let userDic =  resultJson as? [String:Any],
               let checkVerified = userDic["verified"] as? Bool
            {
                if let nameDic = userDic["name"] as? [String:Any],
                   let full = nameDic["full"] as? String
                {
                    name = full
                }else {
                    name = "NONAME"
                }
                if let birthDic = userDic["birthdate"] as? [String:Any],
                   let rawBirth =  birthDic["raw"] as? String {
                    convertBirth = String(rawBirth.prefix(10))
                }else {
                    convertBirth = self.common.getCurrentDateTime()
                }
                if let email2 = userDic["email"] as? String {
                    email = email2
                }else {
                    email = "sampleroadtest@gmail.com"
                }
                if let mobile2 = userDic["mobile"] as? String {
                    mobile = mobile2
                }else {
                    mobile = "010-9999-9999"
                }
                UserDefaults.standard.set(self.loginView.checkCheckBtn, forKey: "auto_login")
                UserDefaults.standard.set(customerId, forKey: "customer_id")
                UserDefaults.standard.set(email, forKey: "user_email")
                UserDefaults.standard.set(mobile, forKey: "user_mobile")
                UserDefaults.standard.set(name, forKey: "user_name")
                UserDefaults.standard.set(name, forKey: "user_alias")
                UserDefaults.standard.set(convertBirth, forKey: "user_birth")
                UserDefaults.standard.set(String(describing: userDic["gender"]), forKey: "user_gender")
                print("커스터머 로그인")
                if !UserDefaults.standard.bool(forKey: "PRDC_MODE"){
                    self.common.checkTypeFormDone(customerId: customerId, vc: self)
                }else{
                    if checkVerified {
                        self.common.checkTypeFormDone(customerId: customerId, vc: self)
                    }else {
                        self.navigationController?.pushViewController(CertificationEmailViewController(), animated: true)
                    }
                }
            }
        }
    }
    func checkVerifiedEmail(){
        
    }

}
extension LoginViewController: NaverThirdPartyLoginConnectionDelegate {
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("Success login")
        guard let token = loginInstance?.accessToken! else { return }
   
        print("여기")
        getInfo(token:token)
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        
        
    }
    
    func oauth20ConnectionDidFinishDeleteToken() {
        print("log out")
        
    }
    
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("error = \(error.localizedDescription)")
    }
    func getInfo(token:String) {
        guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow() else { return }
        if !isValidAccessToken {
            return
        }
        guard let tokenType = loginInstance?.tokenType else { return }
        guard let refreshToken = loginInstance?.refreshToken! else { return }
        guard let expireAt = loginInstance?.accessTokenExpireDate! else { return }
        
        let urlStr = "https://openapi.naver.com/v1/nid/me"
        let url = URL(string: urlStr)!
        
        let authorization = "\(tokenType) \(token)"
        
        let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
        
        req.responseJSON { [self] response in
            guard let result = response.value as? [String: Any] else { return }
            guard let object = result["response"] as? [String: Any] else { return }
            guard let fullName = object["name"] as? String else { return }
            guard let email = object["email"] as? String else { return }
            guard let id = object["id"] as? String else {return}
            guard let MorWm = object["gender"] as? String else {return}
            guard let mobile = object["mobile"] as? String else {return}
            var gender = String()
            if MorWm == "M"{
                gender = "male"
            }else{
                gender = "female"
            }
            guard let birthyear = object["birthyear"] as? String else {return}
            guard let birthday = object["birthday"] as? String else {return}
            let stringDate = birthyear + "-" + birthday
            print("생일" + stringDate)
            
            let birthdate = common.stringToDate2(string: stringDate)
            print("생일" + stringDate)
            print(birthdate)
            let name = ["full":fullName]
            let jsonData = try! JSONSerialization.data(withJSONObject: name, options: [])
            let decodedName = String(data: jsonData, encoding: .utf8)!
            var infoParams = [String: Any]()
            let params = ["token": token]
            infoParams = ["email": email, "name": decodedName, "mobile": mobile, "birthdate": birthdate, "gender": gender]
            print(object)
            common.sendRequest(url: "https://api.clayful.io/v1/customers/auth/naver" , method: "POST", params: params, sender: ""){ [self] resultJson in
                guard let resultJson = resultJson as? [String:Any] else {return}
                if resultJson["action"] == nil {
                    self.present(common.alert(title: "", message: "이미 가입이 되어있는 이메일입니다. \n 이메일로 로그인 해주세요."),animated: true)
                }else {
                    print(resultJson)
                    guard let customerId: String = resultJson["customer"] as? String else {return}
                    
                    guard let action: String = resultJson["action"] as? String else {return}
                    print(action)
                    let strDate = "\(birthdate)"
                    let convertDate = strDate.prefix(10)
                    UserDefaults.standard.set(true,forKey: "auto_login")
                    UserDefaults.standard.set(token,forKey: "naver_token")
                    UserDefaults.standard.set(true,forKey: "auto_login")
                    UserDefaults.standard.set(refreshToken,forKey: "naver_refreshToken")
                    UserDefaults.standard.set(expireAt,forKey: "naver_expireAt")
                    UserDefaults.standard.set(tokenType,forKey: "naver_tokenType")
                    if action == "login" {
                        print("로그인")
                        common.userUpdate(customerId: customerId, params: infoParams, sender: self) { resultJson2 in
                            guard let infoDic = resultJson2 as? [String:Any] else {return}
                            guard let nick = infoDic["alias"] as? String else {return}
                            self.common2.getCustomerInfo2(customerId: customerId, vc: self) { result in
                                if result {
                                    UserDefaults.standard.set(nick, forKey: "user_alias")
                                    // clayful에만 유저정보가 있고 ncloud에는 없는경우
                                    common.checkNcloudExist(vc: self, customerId: customerId, nick: nick) { exist in
                                        if exist {
                                            self.common.checkTypeFormDone(customerId: customerId, vc: self)
                                        }else {
                                            self.common.addUserNcloud(customerId: customerId, vc: self) {
                                                self.common.checkTypeFormDone(customerId: customerId, vc: self)
                                            }
                                        }
                                    }
                                }else {
                                    self.navigationController?.pushViewController(CheckNickViewController(), animated: true)
                                }
                            }
                        }
                    }else if action == "register"{
                        print("가입")
                        print(infoParams)
                        common.addUser(vc: self, customerId: customerId, infoParams: infoParams, social: "naver")
                    }
                }
            }
        }
    }
  
  
}
