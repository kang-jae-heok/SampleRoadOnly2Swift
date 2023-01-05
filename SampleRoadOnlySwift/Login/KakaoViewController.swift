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
        let token = accessToken ?? ""
        var mobile = String()
        UserApi.shared.me{ [self] User, Error in
            if let phoneNum = User?.kakaoAccount?.phoneNumber{
                let NumArr = phoneNum.components(separatedBy: " ")
                mobile = "0" + NumArr[1]
                print("mobile:"+mobile)
            }
            if token != ""{
                common.sendRequest(url: "https://api.clayful.io/v1/customers/count?mobile=\(mobile)", method: "get", params: [:], sender: "") { [self] resultJson in
                    guard let resultDic = resultJson as? [String:Any],
                          let countDic = resultDic["count"] as? [String:Any],
                          let count = countDic["raw"] as? Int
                    else {return}
                    print(resultDic)
                    logintClayFul(accessToken, vc: vc, count: count)
                }
            }
        }
    }
    func logintClayFul(_ accessToken : String?, vc: UIViewController, count: Int){
        let token = accessToken ?? ""
        var params = ["token":token]
        print("여기 토큰")
        print(token)
        var fullName = String()
        var email = String()
        var mobile = String()
        var birthdate = Date()
        var gender = String()
        var infoParams = [String:Any]()
        UserApi.shared.me{ [self] User, Error in
            if let name = User?.kakaoAccount?.name{
                fullName = "NONAME"
                print("name:"+name)
            }else {
                fullName = "NONAME"
            }
            if let mail = User?.kakaoAccount?.email{
                email = mail
                print("email:"+email)
            }else {
                email = "sampleroadtest@gmail.com"
            }
            if let phoneNum = User?.kakaoAccount?.phoneNumber{
                let NumArr = phoneNum.components(separatedBy: " ")
                mobile = "0" + NumArr[1]
                print("mobile:"+mobile)
            }else {
                mobile = "01099999999"
            }
            if let birthday = User?.kakaoAccount?.birthday{
                if let birthyear = User?.kakaoAccount?.birthyear{
                    let stringDate = birthyear + "-" + birthday
                    print("생일" + stringDate)
                    birthdate = common.stringToDate4(string: stringDate)
                    print(birthdate)
                }
            }else {
                birthdate = common.stringToDate2(string: "2111-11-11")
            }
            if let manOrWoman = User?.kakaoAccount?.gender{
                gender = String(describing: manOrWoman)
                gender = gender.lowercased()
                print("성별")
                print("gender:"+gender)
            }else {
                gender = "male"
            }
            let name = ["full":fullName]
            let jsonData = try! JSONSerialization.data(withJSONObject: name, options: [])
            let decodedName = String(data: jsonData, encoding: .utf8)!
            infoParams.updateValue(email, forKey: "email")
            infoParams.updateValue(decodedName, forKey: "name")
            infoParams.updateValue(mobile, forKey: "mobile")
            infoParams.updateValue(birthdate, forKey: "birthdate")
            infoParams.updateValue(gender, forKey: "gender")
            common.sendRequest(url: "https://api.clayful.io/v1/customers/auth/kakao", method: "POST", params: params, sender: ""){ [self] resultJson in
                guard let resultJson = resultJson as? [String:Any] else {return}
                if resultJson["action"] == nil {
                    vc.present(common.alert(title: "", message: "이미 가입이 되어있는 이메일입니다. \n 이메일로 로그인 해주세요."),animated: true)
                }else {
                    print(resultJson)
                    guard let customerId: String = resultJson["customer"] as? String else {return}
                    
                    guard let action: String = resultJson["action"] as? String else {return}
                    print(action)
                    let strDate = "\(birthdate)"
                    let convertDate = strDate.prefix(10)
                    UserDefaults.standard.set(true,forKey: "auto_login")
                    UserDefaults.standard.set(token,forKey: "kakao_token")
                    if action == "login" {
                        print("로그인")
                        common.userUpdate(customerId: customerId, params: infoParams, sender: vc) {[self] resultJson2 in
                            guard let infoDic = resultJson2 as? [String:Any] else {return}
                            guard let nick = infoDic["alias"] as? String else {return}
                            self.common2.getCustomerInfo2(customerId: customerId, vc: vc) { result in
                                if result {
                                    UserDefaults.standard.set(nick, forKey: "user_alias")
                                    // clayful에만 유저정보가 있고 ncloud에는 없는경우
                                    common.checkNcloudExist(vc: vc, customerId: customerId, nick: nick) { exist in
                                        if exist {
                                            self.common.checkTypeFormDone(customerId: customerId, vc: vc)
                                        }else {
                                            self.common.addUserNcloud(customerId: customerId, vc: vc) {
                                                self.common.checkTypeFormDone(customerId: customerId, vc: vc)
                                            }
                                        }
                                    }
                                }else {
                                    vc.navigationController?.pushViewController(CheckNickViewController(), animated: true)
                                }
                            }
                        }
                    }else if action == "register"{
                            print("가입")
                            print(infoParams)
                        if count == 0 {
                            common.addUser(vc: vc, customerId: customerId, infoParams: infoParams, social: "kakao")
                        }else {
                            common.deleteUserDefaults()
                            common.deleteUser(customerId: customerId)
                            vc.present(common.alert(title: "", message: "이미 가입된 번호입니다."), animated: true)
                        }
                    }
                }
            }
        }
    }
}




