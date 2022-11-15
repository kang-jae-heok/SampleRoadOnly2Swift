//
//  MainViewController.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/09/22.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import NaverThirdPartyLogin
import Alamofire

class MainViewSController: UIViewController {
    let mainView = MainViewS()
    let common = CommonS()
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loginInstance?.delegate = self
        mainView.joinEmail.addTarget(self, action: #selector(touchJoinEmail), for: .touchUpInside)
        mainView.startBtn.addTarget(self, action: #selector(touchStartBtn), for: .touchUpInside)
        mainView.naverBtn.addTarget(self, action: #selector(touchNaverBtn), for: .touchUpInside)
        mainView.kakaoBtn.addTarget(self, action: #selector(touchKakaoBtn), for: .touchUpInside)
    }
    
    
    @objc func touchJoinEmail(){
        let vc = AgreeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func touchStartBtn(){
        let vc = LoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
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
    @objc func touchKakaoBtn(){
        common.kakaoLogin(vc: self)

    }
    func alertDuplicate(){
        present(common.alert(title: "", message: "이메일을 확인해주세요."),animated: true)
    }

}
extension MainViewSController: NaverThirdPartyLoginConnectionDelegate {
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
                let resultJson = resultJson as! [String:Any]
                let customerId = resultJson["customer"] as! String
                let action = resultJson["action"] as! String
                print(resultJson)
                UserDefaults.standard.set(customerId, forKey: "customer_id")
                UserDefaults.standard.set(email, forKey: "user_email")
                UserDefaults.standard.set(mobile, forKey: "user_mobile")
                UserDefaults.standard.set(decodedName, forKey: "user_name")
                UserDefaults.standard.set(birthdate, forKey: "user_birth")
                UserDefaults.standard.set(gender, forKey: "user_gender")
                UserDefaults.standard.set(token,forKey: "naver_token")
                UserDefaults.standard.set(true,forKey: "auto_login")
                UserDefaults.standard.set(refreshToken,forKey: "naver_refreshToken")
                UserDefaults.standard.set(expireAt,forKey: "naver_expireAt")
                UserDefaults.standard.set(tokenType,forKey: "naver_tokenType")
                if action == "login" {
                    print("로그인")
                    common.userUpdate(customerId: customerId, params: infoParams, sender: self) {
//                        let vc = MainContentViewController()
//                        self.navigationController?.pushViewController(vc, animated: true)
                        self.common.duplicateCheckOrMake2(vc: self, customerId: customerId, bool: false, infoParams: infoParams, social: "naver")
                    }
                }else if action == "register"{
                    print("가입")
                    common.addUser(vc: self, customerId: customerId, infoParams: infoParams, social: "naver")
                }
            }
        }
    }
  
  
}

