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
        let RegEx = "^(?=.*[A-Za-z])(?=.*[0-9]).{8,12}"
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
    func isValidDate(testStr: String) -> Bool{
        //문자와 숫자 무조건 포함
        let RegEx = "^([12]\\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\\d|3[01]))$"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: testStr)
    }
    func isValidDate2(testStr: String) -> Bool{
        //문자와 숫자 무조건 포함
        let RegEx = "^([12]\\d{3}(0[1-9]|1[0-2])(0[1-9]|[12]\\d|3[01]))$"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: testStr)
    }
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text?.count ??  "".count > maxLength) {
            textField.deleteBackward()
        }
    }
    
    func addGrayAlertView(view: UIView, alertView: UIView){
        let grayBackgroundView = UIButton().then{
            $0.backgroundColor =  .black.withAlphaComponent(0.8)
        }
        grayBackgroundView.tag = 100
        view.addSubview(grayBackgroundView)
        grayBackgroundView.addSubview(alertView)
        grayBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        alertView.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
        print(self)
        grayBackgroundView.addTarget(self, action: #selector(view.touchGrayView), for: .touchUpInside)
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
    func removeSpecialCharsFromString(text: String) -> String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-=().!_")
        return text.filter {okayChars.contains($0) }
    }
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
            case .failure(let error):
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
    func iamportSendRequest(url: String, method: String, params: Dictionary<String, Any>, sender: String,  completion:@escaping (Any) -> Void) {
        AF.request(url,
                   method: HTTPMethod(rawValue: method),
                   parameters: params,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/x-www-form-urlencoded",
                             "Accept":"application/json",
                             "Accept-Encoding":"gzip",
                             "Authorization": sender ])
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
                print(error)
            }
        }
    }
    func getCurrentDateTime() -> String{
        let formatter = DateFormatter() //객체 생성
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        formatter.dateFormat = "yyyy-MM-dd" //데이터 포멧 설정
        let str = formatter.string(from: Date()) //문자열로 바꾸기
        return "\(str)"   //라벨에 출력
    }
    func getTimeIndex() -> String{
        let formatter = DateFormatter() //객체 생성
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        formatter.dateFormat = "yyyyMMddHHmmss" //데이터 포멧 설정
        let str = formatter.string(from: Date()) //문자열로 바꾸기
        return "\(str)"   //라벨에 출력
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
    func stringToDate4(string: String) -> Date {
        var returnDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMdd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: string) {
            let date2 = Calendar.current.date(byAdding: .hour, value: 9, to: Date())
            print(String(describing: date))
            print(String(describing: date2))
            returnDate = date
        }
        return returnDate
    }
    func DateToDate(date: Date) -> Date {
        var returnDate = Date()
        let dateFormatter = DateFormatter()
        let strDate = String(describing: date)
        print("strDate -> " + strDate)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        //        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let date2 = dateFormatter.date(from: strDate)
        
        returnDate = date2!
        return returnDate
    }
    func nowDate() -> String{
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let str = dateFormatter.string(from: nowDate)
        return str
    }
    
    func userUpdateWithAddNcloud(customerId: String, params: [String:Any], sender: UIViewController, completion: @escaping ([String:Any]) -> Void){
        print(#function)
        self.sendRequest(url: "https://api.clayful.io/v1/customers/\(customerId)", method: "put", params: params, sender: ""){ resultJson in
            print("성공")
            print(resultJson)
            var imgUrl = String()
            var gender = String()
            guard let userDic = resultJson as? [String:Any] else {return}
            guard let nameDic = userDic["name"] as? [String:Any] else {return}
            guard let rawBirth = userDic["birthdate"] as? String else {return}
            let convertBirth = rawBirth.prefix(10)
            
            if let avartarDic = userDic["avatar"] as? [String:Any] {
                guard let imgUrl2 = avartarDic["url"] as? String else {return}
                imgUrl = imgUrl2
            }else {
                imgUrl = "null"
            }
            if let genderCheck = userDic["gender"] as? String {
                gender = genderCheck
            }else {
                gender = ""
            }
            guard let email = userDic["email"] as? String else {return}
            guard let mobile = userDic["mobile"] as? String else {return}
            guard let fullName = nameDic["full"] as? String else {return}
            UserDefaults.standard.set(true, forKey: "auto_login")
            UserDefaults.standard.set(customerId, forKey: "customer_id")
            UserDefaults.standard.set(email, forKey: "user_email")
            UserDefaults.standard.set(mobile, forKey: "user_mobile")
            UserDefaults.standard.set(fullName, forKey: "user_name")
            UserDefaults.standard.set(convertBirth, forKey: "user_birth")
            UserDefaults.standard.set(gender, forKey: "user_gender")
            UserDefaults.standard.set(imgUrl, forKey: "user_image")
            self.addUserNcloud(customerId: customerId, vc: sender) {
                completion(userDic)
            }
        }
    }
    func userUpdate(customerId: String, params: [String:Any], sender: UIViewController, completion: @escaping ([String:Any]) -> Void){
        print(#function)
        self.sendRequest(url: "https://api.clayful.io/v1/customers/\(customerId)", method: "put", params: params, sender: ""){ resultJson in
            print("성공")
            print(resultJson)
            var imgUrl = String()
            var gender = String()
            guard let userDic = resultJson as? [String:Any] else {return}
            guard let nameDic = userDic["name"] as? [String:Any] else {return}
            guard let rawBirth = userDic["birthdate"] as? String else {return}
            let convertBirth = rawBirth.prefix(10)
            
            if let avartarDic = userDic["avatar"] as? [String:Any] {
                guard let imgUrl2 = avartarDic["url"] as? String else {return}
                imgUrl = imgUrl2
            }else {
                imgUrl = "null"
            }
            if let genderCheck = userDic["gender"] as? String {
                gender = genderCheck
            }else {
                gender = ""
            }
            guard let email = userDic["email"] as? String else {return}
            guard let mobile = userDic["mobile"] as? String else {return}
            guard let fullName = nameDic["full"] as? String else {return}
            UserDefaults.standard.set(true, forKey: "auto_login")
            UserDefaults.standard.set(customerId, forKey: "customer_id")
            UserDefaults.standard.set(email, forKey: "user_email")
            UserDefaults.standard.set(mobile, forKey: "user_mobile")
            UserDefaults.standard.set(fullName, forKey: "user_name")
            UserDefaults.standard.set(convertBirth, forKey: "user_birth")
            UserDefaults.standard.set(gender, forKey: "user_gender")
            UserDefaults.standard.set(imgUrl, forKey: "user_image")
            completion(userDic)
            
        }
    }
    func userUpdateWithNull(customerId: String, params: [String:Any], sender: UIViewController, completion: @escaping ([String:Any]) -> Void){
        let url = "https://api.clayful.io/v1/customers/\(customerId)"
        var a = [String : Any?]()
        if params["gender"] as? String ?? "" == "null" {
            a = ["gender":nil] as [String : Any?]
        }
        let b = a.merging(params, uniquingKeysWith: { (current, _) in current })
        let header: HTTPHeaders = [
            "Content-Type":"application/json",
            "Accept":"application/json",
            "Accept-Encoding":"gzip",
            "Authorization":"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjM4N2NkNjVkZGUxOWExZjdkNGM0NTk2ODhlZTJkNTk1MWZkZjRlYTI5ZWQ1OWE1NTc2MjBlOTI5Y2M4OTNiZTAiLCJyb2xlIjoiY2xpZW50IiwiaWF0IjoxNjU0NTc5NzQ0LCJzdG9yZSI6IlZLS1RZTjIzVEJFUS5GOVg5R0pKQkVFNVEiLCJzdWIiOiJYUzRVRVRCOFNFVkcifQ.G1j5SEaS-sjgRf1dPTr0l7zeIPNVPKVNw2Ga49FfUG0"
        ]

        let parameters: Parameters = b
        print("####cartAddParams")
        print(parameters)
        AF.request(url,
                   method: .put,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: header
        ).responseData(completionHandler: { [self] res in
            switch res.result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                print("성공")
                guard let json = try? JSONSerialization.jsonObject(with: data),
                      let dictionary = json as? [String: Any] else {
                    return
                }
                print("###responseData")
                print(dictionary)
                completion(dictionary)
            }
        })
    }
    func addUserNcloud(customerId: String, vc: UIViewController, completion: @escaping () -> Void){
        var params = [String:Any]()
        params.updateValue(customerId, forKey: "customer_id")
        params.updateValue(1, forKey: "insert")
        sendRequest(url: "http://110.165.17.124/sampleroad/v1/user.php", method: "post", params: params, sender: ""){ [self] reusultJson in
            print(reusultJson)
            guard let resultDic = reusultJson as? [String:Any],
                  let code = resultDic["error"] as? String
            else {return}
            if code == "1" {
                completion()
            }else{
                //클레이풀 유저 삭제
//                self.sendRequest(url: "https://api.clayful.io/v1/customers/\(customerId)", method: "delete", params: [:], sender: "") { resultJson in
//                    self.deleteUserDefaults()
//                    vc.present(self.alert(title: "에러", message: "잠시후 다시 시도해주세요"), animated: true)
//                }
            }
        }
    }

    func checkDuplicateNick(vc: UIViewController, nick: String, completion: @escaping(Bool) -> Void) {
        var params = [String:Any]()
        params.updateValue(nick, forKey: "nick")
        params.updateValue("1", forKey: "check")
        self.sendRequest(url: "http://110.165.17.124/sampleroad/v1/user.php", method: "post", params: params, sender: "") { resultJson in
            print(resultJson)
            guard let errorDic = resultJson as? [String:Any] else { return }
            guard let errorCode = errorDic["error"] as? String else { return }
            if errorCode == "1" {
                vc.present(self.alert(title: "", message: "사용 가능한 닉네임입니다"), animated: true)
                completion(true)
            } else if errorCode == "2" {
                vc.present(self.alert(title: "", message: "중복된 닉네임입니다"), animated: true)
                completion(false)
            }
        }
    }
    func checkNcloudExist(vc: UIViewController, customerId: String, nick: String, completion: @escaping(Bool) -> Void) {
        var params = [String:Any]()
        params.updateValue(customerId, forKey: "customer_id")
        params.updateValue(nick, forKey: "nick")
        params.updateValue("1", forKey: "check")
        self.sendRequest(url: "http://110.165.17.124/sampleroad/v1/user.php", method: "post", params: params, sender: "") { resultJson in
            print(resultJson)
            guard let errorDic = resultJson as? [String:Any] else { return }
            guard let errorCode = errorDic["error"] as? String else { return }
            if errorCode == "1" {
                completion(true)
            }else {
                completion(false)
            }
        }
    }
    func checkDuplicateAndMakeNick(vc: UIViewController,nick: String ) {
        let customerId = UserDefaults.standard.string(forKey: "customer_id") ?? ""
        var params2 = [String:Any]()
        params2.updateValue(nick, forKey: "nick")
        params2.updateValue(customerId, forKey: "customer_id")
        params2.updateValue(1, forKey: "update")
        self.sendRequest(url: "http://110.165.17.124/sampleroad/v1/user.php", method: "post", params: params2, sender: "") { resultJson2 in
            guard let errorDic = resultJson2 as? [String:Any] else { return }
            guard let errorCode = errorDic["error"] as? String else { return }
            if errorCode == "1" {
                var params = [String:Any]()
                params.updateValue(nick, forKey: "alias")
                let nameDic = ["full": nick]
                let jsonData = try! JSONSerialization.data(withJSONObject: nameDic, options: [])
                let decodedName = String(data: jsonData, encoding: .utf8)!
                params.updateValue(decodedName, forKey: "name")
                self.userUpdate(customerId: customerId, params: params, sender: vc) {_ in
                    UserDefaults.standard.set(nick, forKey: "user_alias")
                    self.checkTypeFormDone(customerId: customerId, vc: vc)
                }
            } else if errorCode == "2" {
                vc.present(self.alert(title: "", message: "중복된 닉네임입니다"), animated: true)
            }
        }
    }
    func deleteUserDefaults(){
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
    }
    func addUser(vc: UIViewController, customerId: String, infoParams: [String:Any], social: String){
        print("customerID" + customerId)
        var params = infoParams
        params.updateValue(customerId, forKey: "alias")
        self.userUpdateWithAddNcloud(customerId: customerId, params: params, sender: vc) { _ in
            vc.navigationController?.pushViewController(CheckNickViewController(), animated: true)
        }
    }
    func checkAgree(vc: UIViewController,customerId: String) {
       
    }
    func deleteUserClayfulAndNcloud(customerId: String){
        self.sendRequest(url: "https://api.clayful.io/v1/customers/\(customerId)", method: "delete", params: [:], sender: "") { resultJson in
            self.deleteUserDB(customerId: customerId)
        }
    }
    func deleteUserDB(customerId: String){
        self.sendRequest(url: "http://110.165.17.124/sampleroad/v1/user.php", method: "post", params: ["customer_id": customerId, "delete": 1 ], sender:"" ) { [self] resultJson in
            print("삭제됨")
            for key in UserDefaults.standard.dictionaryRepresentation().keys {
                UserDefaults.standard.removeObject(forKey: key.description)
            }
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                exit(0)
            }
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
    func setButtonImageUrl(url: String, button: UIButton){
        let cacheKey = NSString(string: url) // 캐시에 사용될 Key 값
        
        if let cachedImage = ImageCacheManager.share.object(forKey: cacheKey) { // 해당 Key 에 캐시이미지가 저장되어 있으면 이미지를 사용
            print("cachedImage")
            button.setImage(cachedImage, for: .normal)
            button.layer.cornerRadius = button.frame.height/2
            button.clipsToBounds = true
            button.imageView?.contentMode = .scaleAspectFill
            return
        }
        print("not")
        DispatchQueue.global(qos: .background).async {
            if let imageUrl = URL(string: url) {
                URLSession.shared.dataTask(with: imageUrl) { (data, res, err) in
                    if let _ = err {
                        DispatchQueue.main.async { [self] in
                            button.setImage(UIImage(named: ""), for: .normal)
                            button.layer.cornerRadius = button.frame.height/2
                            button.clipsToBounds = true
                            button.imageView?.contentMode = .scaleAspectFill
                        }
                        return
                    }
                    DispatchQueue.main.async { [self] in
                        if let data = data, let image = UIImage(data: data) {
                            ImageCacheManager.share.setObject(image, forKey: cacheKey) // 다운로드된 이미지를 캐시에 저장
                            button.setImage(image, for: .normal)
                            button.layer.cornerRadius = button.frame.height/2
                            button.clipsToBounds = true
                            button.imageView?.contentMode = .scaleAspectFill
                        }
                    }
                }.resume()
            }
        }
    }
    func checkTypeFormDone(customerId: String, vc: UIViewController){
        self.sendRequest(url: "http://110.165.17.124/sampleroad/v1/survey.php", method: "post", params: ["customer_id":customerId, "check": 1], sender: "") { resultJson in
            print("스킨타입")
            print(resultJson)
            guard let skinInfoDic = resultJson as? [String:Any],
                  let error = skinInfoDic["error"] as? String
            else {return}
            if error == "1" {
                guard let skinType = skinInfoDic["skin_type"] as? String else {return}
                guard let skinGomin = skinInfoDic["skin_gomin"] as? String else {return}
                let skinTypeArr = skinType.components(separatedBy: " ")
                let convertSkinType = skinTypeArr[0]
                let skinGominArr = skinGomin.components(separatedBy: ",")
                UserDefaults.standard.set(convertSkinType, forKey: "user_skin_type")
                UserDefaults.standard.set(skinGominArr, forKey: "user_skin_gomin")
                let rootVc = MainContentViewController()
                vc.navigationController?.pushViewController(rootVc, animated: true)
            }else {
                if !UserDefaults.standard.bool(forKey: "PRDC_MODE"){
                    let rootVc = MainContentViewController()
                    vc.navigationController?.pushViewController(rootVc, animated: true)
                }else{
                    vc.navigationController?.pushViewController(WebViewViewController(), animated: true)
                }
               
            }
          
        }
    }
    
    func checkTypeFormDoneWithCompletion(customerId: String,completion: @escaping(Bool) -> Void){
        let params = [
            "customer_id": customerId,
            "check": 1
        ] as [String : Any]
        self.sendRequest(url: "http://110.165.17.124/sampleroad/v1/survey.php", method: "post", params: params, sender: "") { resultJson in
            guard let resultDic = resultJson as? [String:Any],
                  let errCode = resultDic["error"] as? String
            else {return}
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
            var imgUrl = String()
            guard let userDic = resultJson as? [String:Any] else {return}
            guard let nameDic = userDic["name"] as? [String:Any] else {return}
            guard let birthDic = userDic["birthdate"] as? [String:Any] else {return}
            guard let rawBirth =  birthDic["raw"] as? String else {return}
            let convertBirth = rawBirth.prefix(10)
            
            if let avartarDic = userDic["avatar"] as? [String:Any] {
                guard let imgUrl2 = avartarDic["url"] as? String else {return}
                imgUrl = imgUrl2
            }else {
                imgUrl = "null"
            }
            if let gender = userDic["gender"] as? String{
                UserDefaults.standard.set(gender, forKey: "user_gender")
            } else {
                UserDefaults.standard.set("null", forKey: "user_gender")
            }
            if let alias = userDic["alias"] as? String,
               let email = userDic["email"] as? String,
               let fullName = nameDic["full"] as? String,
               let mobile = userDic["mobile"] as? String {
                UserDefaults.standard.set(true, forKey: "auto_login")
                UserDefaults.standard.set(customerId, forKey: "customer_id")
                UserDefaults.standard.set(email, forKey: "user_email")
                UserDefaults.standard.set(mobile, forKey: "user_mobile")
                UserDefaults.standard.set(fullName, forKey: "user_name")
                UserDefaults.standard.set(convertBirth, forKey: "user_birth")
                UserDefaults.standard.set(imgUrl, forKey: "user_image")
                print("커스터머 로그인")
                if customerId == alias {
                    vc.navigationController?.pushViewController(CheckNickViewController(), animated: true)
                }else {
                    self.checkTypeFormDone(customerId: customerId, vc: vc)
                }
            } else {
                let alert = UIAlertController(title: "재가입 안내", message: "고객 정보 개편으로 일부 계정의 주문이 불가능한 점 양해 부탁드립니다.\n탈퇴 및 재가입 이후 정상 이용 가능합니다.", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "확인", style: .default) { [self] (action) in
                    deleteUserClayfulAndNcloud(customerId: customerId)
                }
                let noAction = UIAlertAction(title: "취소", style: .default) { [self] (action) in
                }
                alert.addAction(noAction)
                alert.addAction(okAction)
                vc.present(alert, animated: true, completion: nil)
            }
     
        }
    }
    func getCustomerInfo2(customerId: String, vc: UIViewController,completion: @escaping(Bool) -> Void){
        print("결과")
        print(customerId)
        self.sendRequest(url: "https://api.clayful.io/v1/customers/\(customerId)", method: "get", params: [:], sender: "") { resultJson in
            var gender = String()
            var email = String()
            var mobile = String()
            var name = String()
            var alias = String()
            var imgUrl = String()
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
                    convertBirth = self.getCurrentDateTime()
                }
                if let alias2 = userDic["alias"] as? String {
                    alias = alias2
                }else {
                    alias = customerId
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
                if let avartarDic = userDic["avatar"] as? [String:Any] {
                    guard let imgUrl2 = avartarDic["url"] as? String else {return}
                    imgUrl = imgUrl2
                }else {
                    imgUrl = "null"
                }
                UserDefaults.standard.set(true, forKey: "auto_login")
                UserDefaults.standard.set(customerId, forKey: "customer_id")
                UserDefaults.standard.set(email, forKey: "user_email")
                UserDefaults.standard.set(mobile, forKey: "user_mobile")
                UserDefaults.standard.set(name, forKey: "user_name")
                UserDefaults.standard.set(alias, forKey: "user_alias")
                UserDefaults.standard.set(convertBirth, forKey: "user_birth")
                UserDefaults.standard.set(String(describing: userDic["gender"]), forKey: "user_gender")
                UserDefaults.standard.set(imgUrl, forKey: "user_image")
                if customerId == alias {
                    completion(false)
                }else {
                    completion(true)
                }
            }
           
        }
      
    }
    func objectTojsonString(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    func dicToJsonString(dic: [String:Any]) -> String{
        var jsonObj : String = ""
        do {
            let jsonCreate = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
            
            // json 데이터를 변수에 삽입 실시
            jsonObj = String(data: jsonCreate, encoding: .utf8) ?? ""
            return jsonObj
        } catch {
            print(error.localizedDescription)
            return jsonObj
        }
     
    }
    func JsonToDictionary(data: NSData) -> [String: Any]? {
        let dataString = String(decoding: data, as: UTF8.self)
        if let result = dataString.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: result, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    func JsonToDictionary2(data: Data) -> [String: Any]? {
        let dataString = String(decoding: data, as: UTF8.self)
        if let result = dataString.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: result, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    func makeShortUrl(url: String, completion: @escaping(String) -> Void){
        print(url)
        let url2 = "https://naveropenapi.apigw.ntruss.com/util/v1/shorturl?url=\(url)"
        AF.request(url2,
                   method: .get,
                   encoding: URLEncoding.default,
                   headers: ["X-NCP-APIGW-API-KEY-ID" : "pigmldt25l",
                             "X-NCP-APIGW-API-KEY" : "qFtYI0FzrXFS1Muh50cscBJCf1D424bM1fnT2Bi1"
                            ]
        ).responseData { [weak self] res in
            switch res.result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                guard let json = try? JSONSerialization.jsonObject(with: data),
                      let dictionary = json as? [String: Any],
                      let result = dictionary["result"] as? [String:Any],
                      let convertUrl = result["url"] as? String
                else {
                    return
                }
                completion(convertUrl)
            }
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
