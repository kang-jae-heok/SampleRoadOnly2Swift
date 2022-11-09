//
//  JoinDetailViewController.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/09/30.
//

import UIKit

class JoinDetailSViewController: UIViewController {
    let joinDetailView = JoinDetailView()
    let joinEmailView = JoinEmailView()
    let common = CommonS()
    var infoDic = [String:Any]()
    var gender = String()
    
    @objc init(dic: Dictionary<String, String>) {
        infoDic = dic
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        view = joinDetailView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        joinDetailView.topView.homeBtn.addTarget(self, action: #selector(touchHomeBtn), for: .touchUpInside)
        joinDetailView.nextBtn.addTarget(self, action: #selector(touchNextBtn), for: .touchUpInside)
        joinDetailView.manBtn.addTarget(self, action: #selector(touchGenderBtn(sender:)), for: .touchUpInside)
        joinDetailView.womanBtn.addTarget(self, action: #selector(touchGenderBtn(sender:)), for: .touchUpInside)
        joinDetailView.nonCheckBtn.addTarget(self, action: #selector(touchGenderBtn(sender:)), for: .touchUpInside)
        
    }
    @objc func touchHomeBtn(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func touchGenderBtn(sender: UIButton){
        if sender == joinDetailView.manBtn {
            gender = "male"
        }else if sender == joinDetailView.womanBtn{
            gender = "female"
        }else{
            gender = "none"
        }
    }
    @objc func touchNextBtn(){
        if joinDetailView.nonCheckBtn.tag == 0 && joinDetailView.manBtn.backgroundColor != common.pointColor() && joinDetailView.womanBtn.backgroundColor != common.pointColor(){
            present(common.alert(title: "", message: "성별을 입력해주세요!"), animated: false)
        }else{
            if joinDetailView.nickNameTextField.textField.text == "" {
                present(common.alert(title: "", message: "닉네임을 입력해주세요!"), animated: false)
            }else{
                duplicateCheck(customerId: "", name: "", birthdate: "")
            }
        }
      
        
        
        
    }
    func duplicateCheck(customerId: String,name: String, birthdate: String){
        guard let email = infoDic["email"] else { return }
        guard let mobile = infoDic["mobile"] else { return }
        var stringMobile = String(describing: mobile)
        print(stringMobile)
        stringMobile.insert("-", at: stringMobile.index(stringMobile.startIndex, offsetBy: 3))
        stringMobile.insert("-", at: stringMobile.index(stringMobile.endIndex, offsetBy: -4))
        print(stringMobile)
        var params = [String:Any]()
        params = ["email":email , "mobile":stringMobile, "social":"null"]
        if customerId != "" {
            params.updateValue(customerId, forKey: "customer_id")
        }
        //중복 체크
        common.sendRequest(url: "http://110.165.17.124/sampleroad/db/sr_user_insert.php", method: "post", params: params, sender: ""){ [self] reusultJson in
            print(reusultJson)
            let resultDic = reusultJson as! [String:Any]
            let code = resultDic["error"] as! String
            if code == "1" && customerId == ""{
                addUser()
            }else if code == "2"{
                present(common.alert(title: "", message: "중복된 아이디입니다!"), animated: false)
            }else if code == "0" {
                present(common.alert(title: "", message: "오류!!"), animated: false)
            }else if code == "1" && customerId != "" {
                UserDefaults.standard.set(customerId, forKey: "customer_id")
                UserDefaults.standard.set(email, forKey: "user_email")
                UserDefaults.standard.set(mobile, forKey: "user_mobile")
                UserDefaults.standard.set(name, forKey: "user_name")
                UserDefaults.standard.set(birthdate, forKey: "user_birth")
                UserDefaults.standard.set(gender, forKey: "user_gender")
                let vc = CertificationEmailViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func addUser(){
        var params = [String:Any]()
        guard let email = infoDic["email"] else { return }
        guard let pass = infoDic["pass"] else { return }
        guard let mobile = infoDic["mobile"] else { return }
        guard let fullName = joinDetailView.nickNameTextField.textField.text else { return }
        guard let birthdate = joinDetailView.birthDatTextField.textField.text else { return }
        let name = ["full":fullName]
        let jsonData = try! JSONSerialization.data(withJSONObject: name, options: [])
        let decodedName = String(data: jsonData, encoding: .utf8)!
        params.updateValue(email, forKey: "email")
        params.updateValue(pass, forKey: "password")
        params.updateValue(mobile, forKey: "mobile")
        params.updateValue(decodedName, forKey: "name")
        params.updateValue(fullName, forKey: "alias")
        common.sendRequest(url: "https://api.clayful.io/v1/customers", method: "post", params: params, sender: ""){ [self] reusultJson in
            print(reusultJson)
            let resultDic = reusultJson as! [String:Any]
            guard let customerId = resultDic["_id"] else {return}
            if gender != "none" {
                params.updateValue(gender, forKey: "gender")
            }
            let convertDate = common.stringToDate3(string: birthdate)
            params.updateValue(convertDate, forKey: "birthdate")
            common.sendRequest(url: "https://api.clayful.io/v1/customers/\(customerId)", method: "put", params: params, sender: "") { resultJSon2 in
                print("유저 업데이트")
                print(customerId)
                print(params)
                print(resultJSon2)
            }
            duplicateCheck(customerId: customerId as! String, name: fullName, birthdate: birthdate)
        }
    }
  
    
    
    
}
