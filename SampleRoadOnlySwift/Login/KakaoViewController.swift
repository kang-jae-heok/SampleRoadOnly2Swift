//
//  KakaoViewController.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/10/04.
//

import UIKit
import Foundation
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon
class KakaoViewController: UIViewController {
    let common = CommonS()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func onKakoLogin(sender: UIViewController){
        if(UserApi.isKakaoTalkLoginAvailable()){
            UserApi.shared.loginWithKakaoTalk { [self] oauthToken, error in
                onKakaoLoginCompleted(oauthToken?.accessToken,vc: sender)
            }
        }else{
            UserApi.shared.loginWithKakaoAccount(prompts:[.Login]) { [self] oauthToken, error  in
                onKakaoLoginCompleted(oauthToken?.accessToken,vc: sender)
            }
        }
    }
    
    func onKakaoLoginCompleted(_ accessToken : String?, vc: UIViewController){
        //        getKakaoUserInfo(accessToken)
        let token = accessToken ?? ""
        var params = ["token":token]
        var fullName = String()
        var email = String()
        var mobile = String()
        var birthdate = Date()
        var gender = String()
        var infoParams = [String:Any]()
        UserApi.shared.me{ [self] User, Error in
            if let name = User?.kakaoAccount?.profile?.nickname{
                fullName = name
                print("name:"+name)
            }
            if let mail = User?.kakaoAccount?.email{
                email = mail
                print("email:"+email)
            }
            if let phoneNum = User?.kakaoAccount?.phoneNumber{
                let NumArr = phoneNum.components(separatedBy: " ")
                mobile = "0" + NumArr[1]
                print("mobile:"+mobile)
            }
            if let birthday = User?.kakaoAccount?.birthday{
                if let birthyear = User?.kakaoAccount?.birthyear{
                    let stringDate = birthyear + "-" + birthday
                    print("생일" + stringDate)
                    birthdate = common.stringToDate2(string: stringDate)
                    print(birthdate)
                }
            }
            if let manOrWoman = User?.kakaoAccount?.gender{
                gender = String(describing: manOrWoman)
                gender = gender.lowercased()
                print("gender:"+gender)
            }
            let name = ["full":fullName]
            let jsonData = try! JSONSerialization.data(withJSONObject: name, options: [])
            let decodedName = String(data: jsonData, encoding: .utf8)!
            print(email, decodedName)
            infoParams.updateValue(email, forKey: "email")
            infoParams.updateValue(decodedName, forKey: "name")
            infoParams.updateValue(mobile, forKey: "mobile")
            infoParams.updateValue(birthdate, forKey: "birthdate")
            infoParams.updateValue(gender, forKey: "gender")
            if token != ""{
                common.sendRequest(url: "https://api.clayful.io/v1/customers/auth/kakao" , method: "POST", params: params, sender: ""){ [self] resultJson in
                    let resultJson = resultJson as! [String:Any]
                    if resultJson["action"] == nil {
                        vc.present(common.alert(title: "", message: "이미 가입이 되어있는 이메일입니다. \n 이메일로 로그인 해주세요."),animated: true)
                    }else {
                        print(resultJson)
                        guard let customerId: String = resultJson["customer"] as? String else {return}
                      
                        guard let action: String = resultJson["action"] as? String else {return}
                        
                        
                        print(action)
                        UserDefaults.standard.set(customerId, forKey: "customer_id")
                        UserDefaults.standard.set(email, forKey: "user_email")
                        UserDefaults.standard.set(mobile, forKey: "user_mobile")
                        UserDefaults.standard.set(name, forKey: "user_name")
                        UserDefaults.standard.set(birthdate, forKey: "user_birth")
                        UserDefaults.standard.set(gender, forKey: "user_gender")
                        UserDefaults.standard.set(true,forKey: "auto_login")
                        UserDefaults.standard.set(token,forKey: "kakao_token")
                        if action == "login" {
                            print("로그인")
                            common.userUpdate(customerId: customerId, params: infoParams, sender: vc) {
                                self.common.duplicateCheckOrMake2(vc: vc, customerId: customerId, bool: false, infoParams: infoParams, social: "kakao")
//                                self.common.checkTypeFormDone(customerId: customerId, vc: vc)
                            }
                        }else if action == "register"{
                            print("가입")
                            common.addUser(vc: vc, customerId: customerId, infoParams: infoParams, social: "kakao")
                        }
                    }
               
                }
            }
        }
    }
    
}




