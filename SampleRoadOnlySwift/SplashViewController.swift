//
//  SplashViewController.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/10/26.
//

import UIKit
import Alamofire

class SplashViewController: UIViewController {
    let common = CommonS()
    let screenBounds = UIScreen.main.bounds
    lazy var lblSize = CGSize(width: screenBounds.size.width/4, height: (screenBounds.size.width/4)*(1/3.6))
    let logoImgView = UIImageView().then{
        $0.image = UIImage(named: "logo_intro_btn")
    }
    let backgroundImgView = UIImageView().then{
        $0.image = UIImage(named: "bg_intro_btn")
    }
    let midView = UIView()
    lazy var titLbl = UILabel().then{
        $0.text = "누적샘플 수"
        $0.font = common.setFont(font: "semibold", size: 16)
        $0.backgroundColor = common.pointColor()
        $0.textAlignment = .center
        $0.layer.cornerRadius = lblSize.height/2
        $0.textColor = .white
        $0.clipsToBounds = true
    }
    lazy var sampleLbl = CountScrollLabel()
    
    lazy var copyRightLbl = UILabel().then{
        $0.text = "ⓒTov&Banah"
        $0.font = common.setFont(font: "light", size: 10)
        $0.textAlignment = .center
        $0.textColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserDefaults.standard.value(forKey: "PRDC_MODE") == nil {
            UserDefaults.standard.set(true, forKey: "PRDC_MODE")
        }
        getSampleCount()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            print("\(key) = \(value) \n")
        }
        addSubviewFunc()
        setLayout()
        loadNextVC()
        
    }
    func addSubviewFunc(){
        [midView,titLbl,sampleLbl,copyRightLbl].forEach{
            view.addSubview($0)
        }
        [backgroundImgView,logoImgView].forEach{
            midView.addSubview($0)
        }
    }
    func setLayout(){
        copyRightLbl.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-20)
            $0.centerX.equalToSuperview()
        }
        //        sampleLbl.snp.makeConstraints{
        //            $0.bottom.equalTo(copyRightLbl.snp.top).offset(-30)
        //            $0.centerX.equalToSuperview()
        //            $0.size.equalTo(CGSize(width: 200.0, height: 60.0))
        //        }
        let countLblSize = CGSize(width: 200.0, height: 60.0)
        sampleLbl.frame  = CGRect(x: screenBounds.width/2 - countLblSize.width/2, y: screenBounds.height - (countLblSize.height + 60.0), width: countLblSize.width, height: countLblSize.height)
        titLbl.snp.makeConstraints{
            $0.bottom.equalTo(sampleLbl.snp.top).offset(-10)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(lblSize)
        }
        midView.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(titLbl.snp.top)
        }
        logoImgView.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
        }
        backgroundImgView.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
        }
    }
    func getSampleCount(){
        let sampleCount = UserDefaults.standard.string(forKey: "setting-count") ?? ""
        print("#####")
        print(sampleCount)
        self.sampleLbl.configure(with:sampleCount, textFont: self.common.setFont(font: "extraBold", size: 29), textColor: self.common.pointColor())
    }
    func loadNextVC() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if UserDefaults.contains("auto_login") {
                if UserDefaults.standard.bool(forKey: "auto_login") {
                    if UserDefaults.contains("naver_token") {
                        if Date().dateCompare(fromDate: UserDefaults.standard.object(forKey: "naver_expireAt") as! Date) != "Future" {
                            self.getRefreshToken()
                        }else {
                            self.loginClayful(platform: "naver")
                        }
                    }else if UserDefaults.contains("kakao_token") {
                        self.loginClayful(platform: "kakao")
                    }else {
                        self.common2.getCustomerInfo2(customerId:  UserDefaults.standard.string(forKey: "customer_id") ?? "", vc: self) { _ in
                            self.common.checkTypeFormDoneWithCompletion(customerId: UserDefaults.standard.string(forKey: "customer_id") ?? "") { [self] result in
                                if result {
                                    self.navigationController?.pushViewController(MainContentViewController(), animated: true)
                                }else{
                                    var vc = UIViewController()
                                    if !UserDefaults.standard.bool(forKey: "PRDC_MODE"){
                                        vc = IntroViewController()
                                    }else{
                                        vc = WebViewViewController()
                                    }
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                            }
                        }
                    }
                }else{
                    self.navigationController?.pushViewController(IntroViewController(), animated: true)
                }
            }else{
                self.navigationController?.pushViewController(IntroViewController(), animated: true)
            }
        }
    }
    func loginClayful(platform: String){
        var token = String()
        if platform == "kakao" {
            token = UserDefaults.standard.string(forKey: "kakao_token") ?? ""
        }else if platform == "naver"{
            token = UserDefaults.standard.string(forKey: "naver_token") ?? ""
        }
        let params = ["token": token]
        common.sendRequest(url: "https://api.clayful.io/v1/customers/auth/\(platform)" , method: "POST", params: params, sender: ""){ resultJson in
            let resultJson = resultJson as! [String:Any]
            print(resultJson)
            if resultJson["error"] == nil {
                let customerId = resultJson["customer"] as! String
                self.common.getCustomerInfo(customerId: customerId,vc: self)
            }else {
                self.navigationController?.pushViewController(IntroViewController(), animated: true)
            }
           
        }
    }
    func getRefreshToken(){
        let urlStr = "https://nid.naver.com/oauth2.0/token?grant_type=refresh_token&client_id=YhdqBjtCMkKxxip6Egxy&client_secret=nMdSqYG_gq&refresh_token=\(UserDefaults.standard.string(forKey: "naver_refreshToken")!)"
        print(urlStr)
        let url = URL(string: urlStr)!
        let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [])
        
        req.responseJSON { [self] response in
            guard let result = response.value as? [String: Any] else { return }
            guard let access_token = result["access_token"] as? String else { return }
            let expireAt = Calendar.current.date(byAdding: .hour, value: 1, to: Date())
            UserDefaults.standard.set(access_token,forKey: "naver_token")
            UserDefaults.standard.set(expireAt,forKey: "naver_expireAt")
            self.loginClayful(platform: "naver")
        }
    }
    func moveVc(vc: UIViewController) {
        self.navigationController!.pushViewController(vc, animated: true)
    }
  
}
