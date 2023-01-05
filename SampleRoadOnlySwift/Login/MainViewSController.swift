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
    func checkMobileDuplicate(mobile: String, completion: @escaping (Int) -> Void){
        common.sendRequest(url: "https://api.clayful.io/v1/customers/count?mobile=\(mobile)", method: "get", params: [:], sender: "") { [self] resultJson in
            guard let resultDic = resultJson as? [String:Any],
                  let countDic = resultDic["count"] as? [String:Any],
                  let count = countDic["raw"] as? Int
            else {return}
            completion(count)
        }
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
            var fullName = String()
            var email = String()
            guard let result = response.value as? [String: Any] else { return }
            guard let object = result["response"] as? [String: Any] else { return }
            if let name = object["name"] as? String {
                fullName = "NONAME"
            } else {
                fullName = "NONAME"
            }
            if let email2 = object["email"] as? String {
                email = email2
            } else {
                email = "sampleroad"
            }
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
            checkMobileDuplicate(mobile: mobile) { count in
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
                            common.userUpdate(customerId: customerId, params: infoParams, sender: self) {[self] resultJson2 in
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
                            if count == 0 {
                                common.addUser(vc: self, customerId: customerId, infoParams: infoParams, social: "naver")
                            }else {
                                common.deleteUserDefaults()
                                common.deleteUser(customerId: customerId)
                                self.present(common.alert(title: "", message: "이미 가입된 번호입니다."), animated: true)
                            }
                        }
                    }
                }
            }
          
        }
    }
  
  
}

