//
//  CertificationEmailViewController.swift
//  sampleroad
//
//  Created by NOTEGG on 2022/08/23.
//  Copyright © 2022 CNKANG. All rights reserved.
//

import UIKit
//bg_intro_btn
@objc class CertificationEmailViewController: UIViewController {
    let screenBounds = UIScreen.main.bounds

    let margin = 27.0
    var bool = Bool()
    let common = CommonS()
    
    let contentView = UIView()
    let titleLbl: UILabel = {
        let titleLbl = UILabel()
        titleLbl.text = "이메일 인증"
        titleLbl.font = Common.kFont(withSize: "bold", 20)
        titleLbl.textAlignment = .center
        titleLbl.textColor = Common.pointColor1()
        return titleLbl
    }()
    let homeBtn: UIButton = {
        let homeBtn = UIButton()
        homeBtn.setImage(UIImage(named: "top_home_btn"), for: .normal)
        homeBtn.addTarget(self, action: #selector(touchHomeBtn), for: .touchUpInside)
        return homeBtn
    }()
     let backgroundImgView: UIImageView = {
        let imgView = UIImageView()
         imgView.image = UIImage(named: "bg_intro_btn")
        return imgView
    }()
    let certificationBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("인증 메일 발송", for: .normal)
        btn.backgroundColor = Common.pointColor1()
        btn.layer.cornerRadius = 3
        btn.addTarget(self, action: #selector(touchCertificationBtn), for: .touchUpInside)
        return btn
    }()
    let failCertificationBtn: UIButton = {
        let failCertificationBtn = UIButton()
        failCertificationBtn.setTitle("메일을 변경하고 싶어요", for: .normal)
        failCertificationBtn.setTitleColor(Common.pointColor1(), for: .normal)
        failCertificationBtn.addTarget(self, action: #selector(touchFailCertificationBtn), for: .touchUpInside)
        return failCertificationBtn
    }()
    let bottomLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "FIND YOUR WAY"
        lbl.textColor = Common.pointColor1()
        lbl.font = Common.kFont(withSize: "bold", 18)
        lbl.textAlignment = .center
        return lbl
    }()
    let copyrightLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "©Tov&Banah"
        lbl.textColor = .lightGray
        lbl.font = Common.kFont(withSize: "light", 10)
        lbl.textAlignment = .center
        return lbl
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        layout()
        contentView.backgroundColor = .white
        
    }
    func addSubView(){
        view.addSubview(contentView)
        contentView.addSubview(copyrightLbl)
        contentView.addSubview(bottomLabel)
        contentView.addSubview(certificationBtn)
        contentView.addSubview(failCertificationBtn)
        contentView.addSubview(backgroundImgView)
        contentView.addSubview(titleLbl)
        contentView.addSubview(homeBtn)
    }
    func layout(){
        contentView.frame = CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.height)
        backgroundImgView.frame = CGRect(x: 0, y: screenBounds.height - (backgroundImgView.image?.size.height)!, width: screenBounds.width, height: (backgroundImgView.image?.size.height)!)
        titleLbl.frame = CGRect(x: 0, y: Common.topHeight() - 35 - titleLbl.font.pointSize/2, width: screenBounds.width, height: titleLbl.font.pointSize)
        homeBtn.frame = CGRect(x: margin, y: Common.topHeight() - 20 - 30, width: 30, height: 30)
        certificationBtn.frame = CGRect(x: screenBounds.width/4, y: (screenBounds.height - Common.topHeight())/2, width: screenBounds.width/2, height: 40)
        failCertificationBtn.frame = CGRect(x: screenBounds.width/4, y: (screenBounds.height - Common.topHeight())/2 + 60, width: screenBounds.width/2, height: 40)
        bottomLabel.frame = CGRect(x: 0, y: screenBounds.height - screenBounds.width/4 + 20, width: screenBounds.width, height: titleLbl.font.pointSize)
        copyrightLbl.frame = CGRect(x: 0, y: screenBounds.height - 20 - copyrightLbl.font.pointSize, width: screenBounds.width, height: copyrightLbl.font.pointSize)
    }
    
    @objc func touchFailCertificationBtn(){
        let FailCerificationEmailViewController = FailCerificationEmailViewController()
        self.navigationController?.pushViewController(FailCerificationEmailViewController, animated: true)
    }
    @objc func touchCertificationBtn(){
        
        if certificationBtn.titleLabel?.text == "인증 메일 발송"{
            selectEmail()
            present(common.alert(title: "", message: "인증 메일이 발송되었습니다"),animated: true)
            certificationBtn.setTitle("인증 확인", for: .normal)
        }else{
            selectUserDefault()
            
            if bool{
                present(common.alert(title: "", message: "인증되었습니다"),animated: true)
                let vc = WebViewViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                
                
            }else{
                present(common.alert(title: "", message: "이메일 인증 후 이용하실 수 있습니다"),animated: true)
            }
           
        }
       
        
       
    }
    @objc func selectEmail() {
        var params:[String:Any] = [:]
 
        
        params.updateValue(UserDefaults.standard.value(forKey: "user_email") as! String, forKey: "email")
        params.updateValue("600", forKey: "expiresIn")
        params.updateValue("verification", forKey: "scope")
        print("파라미터")
        print(params)
        
        COMController.sendRequest("https://api.clayful.io/v1/customers/verifications/emails", params, self, #selector(selectNilCallback))
        
    }
    @objc func selectNilCallback() {
     
    }
    @objc func selectUserDefault() {
        let customerId = UserDefaults.standard.value(forKey: "customer_id") as! String
        COMController.sendRequestGet("https://api.clayful.io/v1/customers/\(customerId)", nil, self, #selector(selectUserDefaultCallback(result: )) )
        
    }
    @objc func selectUserDefaultCallback(result :NSData) {
        let common = CommonSwift()
        print("여기")
        NSLog("selectOrderCallback : %@", result);
        let dict:[String:Any] = common.JsonToDictionary(data: result)!
        print(dict["verified"] as! Bool)
        bool = dict["verified"] as! Bool
    }
    @objc func touchHomeBtn(){
        self.navigationController?.popViewController(animated: false)
    }
    
 
  
    

}
