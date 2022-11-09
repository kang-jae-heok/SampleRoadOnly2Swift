//
//  Common.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/09/21.
//

import Foundation
import UIKit
import KakaoSDKUser
import Alamofire

class CommonS{
    func setFont(font: String, size: CGFloat) -> UIFont{
        let upperFont = font.uppercased()
        if upperFont == "BOLD"{
            return UIFont(name: "AppleSDGothicNeo-Bold", size: size)!
        }else if upperFont == "EXTRABOLD"{
            return UIFont(name: "AppleSDGothicNeo-ExtraBold", size: size)!
        }else if upperFont == "SEMIBOLD"{
            return UIFont(name: "AppleSDGothicNeo-SemiBold", size: size)!
        }else if upperFont == "LIGHT"{
            return UIFont(name: "AppleSDGothicNeo-Light", size: size)!
        }else if upperFont == "MEDIUM"{
            return UIFont(name: "AppleSDGothicNeo-Medium", size: size)!
        }else{
            return UIFont(name: "AppleSDGothicNeo-Regular", size: size)!
        }
    }
    func setColor(hex: String) -> UIColor {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0

        return(UIColor(red: r, green: g, blue: b, alpha: 1.0))
    }
    func pointColor() -> UIColor{
        return self.setColor(hex: "#97C5E9")
    }
    func lightGray() -> UIColor{
        return self.setColor(hex: "#e6e6e6")
    }
    func gray() -> UIColor{
        return self.setColor(hex: "#b1b1b1")
    }
    func alert(title:String , message: String) -> UIAlertController{

        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in

        }
        alert.addAction(okAction)
        return alert
    }
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    func isValidPass(testStr: String) -> Bool{
        //문자와 숫자 무조건 포함
        let RegEx = "^(?=.*[A-Za-z])(?=.*[0-9]).{6,12}"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: testStr)
    }
    func checknilTextField(text: String) -> Bool{
        if text == "" {
            return true
        }else {
            return false
        }
    }
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text?.count ??  "".count > maxLength) {
            textField.deleteBackward()
        }
    }
    func kakaoLogin(vc: UIViewController){
        let kakaoVc = KakaoViewController()
        if(UserApi.isKakaoTalkLoginAvailable()){
            print("여기서 멈춤")
            UserApi.shared.loginWithKakaoTalk { [vc] oauthToken, error in
                print(error)
                kakaoVc.onKakaoLoginCompleted(oauthToken?.accessToken, vc: vc)
            }
        }else{
            print("저기서 멈춤")
            UserApi.shared.loginWithKakaoAccount(prompts:[.Login]) { [vc] oauthToken, error  in
                kakaoVc.onKakaoLoginCompleted(oauthToken?.accessToken, vc: vc)
            }
        }
    }
//    func kakaoLogin(vc:UIViewController){
//        if(UserApi.isKakaoTalkLoginAvailable()){
//            UserApi.shared.loginWithKakaoTalk { [vc] oauthToken, error in
//                onKakaoLoginCompleted(oauthToken?.accessToken, vc: vc)
//            }
//        }else{
//            UserApi.shared.loginWithKakaoAccount(prompts:[.Login]) { [vc] oauthToken, error  in
//                onKakaoLoginCompleted(oauthToken?.accessToken, vc: vc)
//            }
//        }
//    }
    func sendRequest(url: String, method: String, params: Dictionary<String, Any>, sender: String,  completion:@escaping (Any) -> Void) {
        AF.request(url,
                   method: HTTPMethod(rawValue: method),
                   parameters: params,
                   encoding: URLEncoding.default,
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
            case .failure(let error): break
                // error handling
                print(error)
            }
        }
    }
    func sendRequest2(url: String, method: String, params: Dictionary<String, Any>, sender: String,  completion:@escaping (Any) -> [[String:Any]]) {
        AF.request(url,
                   method: HTTPMethod(rawValue: method),
                   parameters: params,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/x-www-form-urlencoded",
                             "Accept":"application/json",
                             "Accept-Encoding":"gzip",
                             "Authorization":"Bearer    eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjM4N2NkNjVkZGUxOWExZjdkNGM0NTk2ODhlZTJkNTk1MWZkZjRlYTI5ZWQ1OWE1NTc2MjBlOTI5Y2M4OTNiZTAiLCJyb2xlIjoiY2xpZW50IiwiaWF0IjoxNjU0NTc5NzQ0LCJzdG9yZSI6IlZLS1RZTjIzVEJFUS5GOVg5R0pKQkVFNVEiLCJzdWIiOiJYUzRVRVRCOFNFVkcifQ.G1j5SEaS-sjgRf1dPTr0l7zeIPNVPKVNw2Ga49FfUG0" ])
        //.validate(statusCode: 200..<300)
        
        .responseJSON { [self] (response) in
            print(response.result)
            //여기서 가져온 데이터를 자유롭게 활용하세요.
            print(params)
            print(response)
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error): break
                // error handling
                print(error)
            }
        }
    }
    func stringToDate(string: String) -> Date {
        var returnDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: string) {
            let date2 = Calendar.current.date(byAdding: .hour, value: 9, to: Date())
            print(String(describing: date))
            print(String(describing: date2))
            returnDate = date2!
        }
    return returnDate
    }
    func stringToDate2(string: String) -> Date {
        var returnDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: string) {
            let date2 = Calendar.current.date(byAdding: .hour, value: 9, to: Date())
            print(String(describing: date))
            print(String(describing: date2))
            returnDate = date
        }
    return returnDate
    }
    func stringToDate3(string: String) -> Date {
        var returnDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: string) {
            let date2 = Calendar.current.date(byAdding: .hour, value: 9, to: Date())
            print(String(describing: date))
            print(String(describing: date2))
            returnDate = date
        }
    return returnDate
    }

    func userUpdate(customerId: String, params: [String:Any], sender: UIViewController, completion: @escaping () -> Void){
        print(#function)
//        UserDefaults.standard.set(customerId, forKey: "customerId")
//        UserDefaults.standard.set(email, forKey: "user_email")
//        UserDefaults.standard.set(mobile, forKey: "user_mobile")
//        UserDefaults.standard.set(name, forKey: "user_name")
//        UserDefaults.standard.set(birthdate, forKey: "user_birth")
//        UserDefaults.standard.set(gender, forKey: "user_gender")
        self.sendRequest(url: "https://api.clayful.io/v1/customers/\(customerId)", method: "put", params: params, sender: ""){ resultJson in
            print("성공")
            print(resultJson)
            
    
            completion()
        }
    }
    func duplicateCheckOrMake(vc: UIViewController, customerId: String, bool: Bool, infoParams: [String:Any], social:String){
        print("중복체크 함수!!")
        guard let email = infoParams["email"] else {
            return
        }
        guard let mobile = infoParams["mobile"] else { return }
        var params = [String:Any]()
        params = ["email":email , "mobile":mobile,"social":social]
        if bool {
            params.updateValue(customerId, forKey: "customer_id")
        }
        //중복 체크
        self.sendRequest(url: "http://110.165.17.124/sampleroad/db/sr_user_insert.php", method: "post", params: params, sender: ""){ [self] reusultJson in
            print(reusultJson)
            let resultDic = reusultJson as! [String:Any]
            let code = resultDic["error"] as! String
            print(code)
            if code == "1" && !bool{
                //중복체크 -> 중복없음
                print("중복체크 -> 중복없음")
                duplicateCheckOrMake(vc: vc, customerId: customerId, bool: true, infoParams: infoParams, social: social)
            }else if code == "2"{
                print("에러코드 2")
                deleteUser(customerId: customerId)
                print("@@@@@@@")
            }else if code == "0"{
                print("에러코드 0")
                vc.present(self.alert(title: "", message: "오류!!"), animated: false)
            }else if code == "1" && bool{
                //db넣기 -> 성공
                print("db넣기 -> 성공")
                self.checkTypeFormDone(customerId: customerId, vc: vc)
            }
        }
    }
    func addUser(vc: UIViewController, customerId: String, infoParams: [String:Any],social: String){
        print("customerID" + customerId)
        self.userUpdate(customerId: customerId, params: infoParams, sender: vc) { [weak self] in
            self?.duplicateCheckOrMake(vc: vc, customerId: customerId, bool: false, infoParams: infoParams, social: social)
        }
        
    }
    func deleteUser(customerId: String){
        self.sendRequest(url: "https://api.clayful.io/v1/customers/\(customerId)", method: "delete", params: [:], sender: "") { resultJson in
            print(resultJson)
        }
    }
    func setImageUrl(url: String, imageView: UIImageView){
        let cacheKey = NSString(string: url) // 캐시에 사용될 Key 값
        
        if let cachedImage = ImageCacheManager.share.object(forKey: cacheKey) { // 해당 Key 에 캐시이미지가 저장되어 있으면 이미지를 사용
            print("cachedImage")
            imageView.image = cachedImage
            return
        }
        print("not")
        DispatchQueue.global(qos: .background).async {
            if let imageUrl = URL(string: url) {
                URLSession.shared.dataTask(with: imageUrl) { (data, res, err) in
                    if let _ = err {
                        DispatchQueue.main.async { [self] in
                            imageView.image = UIImage()
                        }
                        return
                    }
                    DispatchQueue.main.async { [self] in
                        if let data = data, let image = UIImage(data: data) {
                            ImageCacheManager.share.setObject(image, forKey: cacheKey) // 다운로드된 이미지를 캐시에 저장
                            imageView.image = image
                        }
                    }
                }.resume()
            }
        }
    }
    func checkTypeFormDone(customerId: String, vc: UIViewController){
        let params = ["customer_id":customerId]
        self.sendRequest(url: "http://110.165.17.124/sampleroad/db/sr_survey_check.php", method: "post", params: [:], sender: "") { resultJson in
            let resultDic = resultJson as! [String:Any]
            let errCode = resultDic["error"] as! String
            var rootVc = UIViewController()
            if errCode == "1"{
                rootVc = MainContentViewController()
                vc.navigationController!.pushViewController(rootVc, animated: true)
            }else{
                if !UserDefaults.standard.bool(forKey: "PRDC_MODE"){
                    rootVc = MainContentViewController()
                    vc.navigationController?.pushViewController(rootVc, animated: true)
                }else{
                    rootVc = WebViewViewController()
                    vc.navigationController?.pushViewController(rootVc, animated: true)
                }
            }
            print(rootVc)
        }
    }
    
    func checkTypeFormDone2(customerId: String,completion: @escaping(Bool) -> Void){
        let params = ["customer_id":customerId]
        self.sendRequest(url: "http://110.165.17.124/sampleroad/db/sr_survey_check.php", method: "post", params: [:], sender: "") { resultJson in
            let resultDic = resultJson as! [String:Any]
            let errCode = resultDic["error"] as! String
            var rootVc = UIViewController()
            if errCode == "1"{
                completion(true)
            }else{
                completion(false)
            }
            print(rootVc)
        }
    }
    func numberFormatter(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: number))!
    }
    func getCustomerInfo(customerId: String, vc: UIViewController){
        self.sendRequest(url: "https://api.clayful.io/v1/customers/\(customerId)", method: "get", params: [:], sender: "") { resultJson in
            print("결과")
            print(resultJson)
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
            UserDefaults.standard.set(true, forKey: "auto_login")
            UserDefaults.standard.set(customerId, forKey: "customer_id")
            UserDefaults.standard.set(userDic["email"] as! String, forKey: "user_email")
            UserDefaults.standard.set(userDic["mobile"] as! String, forKey: "user_mobile")
            UserDefaults.standard.set(nameDic["full"] as! String, forKey: "user_name")
            UserDefaults.standard.set(convertBirth, forKey: "user_birth")
            UserDefaults.standard.set(String(describing: userDic["gender"]), forKey: "user_gender")
            print("커스터머 로그인")
            self.checkTypeFormDone(customerId: customerId, vc: vc)
        }
    }
    

}
extension UILabel {
    func asFontColor(targetStringList: [String], font: UIFont?, color: UIColor?) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)

        targetStringList.forEach {
            let range = (fullText as NSString).range(of: $0)
            attributedString.addAttributes([.font: font as Any, .foregroundColor: color as Any], range: range)
        }
        attributedText = attributedString
    }
    func asFont(targetStringList: [String], font: UIFont?) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)

        targetStringList.forEach {
            let range = (fullText as NSString).range(of: $0)
            attributedString.addAttributes([.font: font as Any], range: range)
        }
        attributedText = attributedString
    }
    func asColor(targetStringList: [String],color: UIColor?) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)

        targetStringList.forEach {
            let range = (fullText as NSString).range(of: $0)
            attributedString.addAttributes([.foregroundColor: color as Any], range: range)
        }
        attributedText = attributedString
    }

}
