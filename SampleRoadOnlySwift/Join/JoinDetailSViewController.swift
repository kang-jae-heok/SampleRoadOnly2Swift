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
    var checkBool = false
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
        joinDetailView.nickNameTextField.textField.delegate = self
        joinDetailView.topView.homeBtn.addTarget(self, action: #selector(touchHomeBtn), for: .touchUpInside)
        joinDetailView.nextBtn.addTarget(self, action: #selector(touchNextBtn), for: .touchUpInside)
        joinDetailView.manBtn.addTarget(self, action: #selector(touchGenderBtn(sender:)), for: .touchUpInside)
        joinDetailView.womanBtn.addTarget(self, action: #selector(touchGenderBtn(sender:)), for: .touchUpInside)
        joinDetailView.nonCheckBtn.addTarget(self, action: #selector(touchGenderBtn(sender:)), for: .touchUpInside)
        joinDetailView.checkDuplicateBtn.addTarget(self, action: #selector(touchCheckDuplicateBtn), for: .touchUpInside)
        
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
        guard let nickText = joinDetailView.nickNameTextField.textField.text else { return }
        if joinDetailView.nonCheckBtn.tag == 0 && joinDetailView.manBtn.backgroundColor != common.pointColor() && joinDetailView.womanBtn.backgroundColor != common.pointColor(){
            present(common.alert(title: "", message: "성별을 입력해주세요!"), animated: false)
        }else{
            if !(common2.isValidDate(testStr: joinDetailView.birthDateTextField.textField.text ?? "")) {
                present(common2.alert(title: "", message: "생년월일을 형식에 맞춰서 입력해주세요."), animated: true)
                return
            }
            if joinDetailView.nickNameTextField.textField.text == "" {
                present(common.alert(title: "", message: "닉네임을 입력해주세요!"), animated: true)
                return
            }
            if !checkBool {
                present(common2.alert(title: "", message: "닉네임 중복검사를 해주세요."), animated: true)
                return
            }
            else{
                duplicateCheck()
            }
        }
    }
    
    @objc func touchCheckDuplicateBtn(){
        guard let nickText = joinDetailView.nickNameTextField.textField.text else { return }
        if nickText.count < 2 {
            present(common2.alert(title: "", message: "2글자 이상 입력해주세요"), animated: true)
        }else {
            common2.checkDuplicateNick(vc: self, nick: nickText) {[self] result in
                if result {
                    checkBool = true
                }else {
                    checkBool = false
                }
            }
        }
    }
    func duplicateCheck(){
        guard let mobile = infoDic["mobile"] as? String else { return }
        //클레이풀 데이터베이스에서 핸드폰 번호에 해당하는 고객 중복 체크
        common.sendRequest(url: "https://api.clayful.io/v1/customers/count?mobile=\(mobile.phoneNumFormatter())", method: "get", params: [:], sender: "") { [self] resultJson in
         
            guard let resultDic = resultJson as? [String:Any],
                  let countDic = resultDic["count"] as? [String:Any],
                  let count = countDic["raw"] as? Int
            else {return}
            print(resultDic)
            if count == 0 {
                guard let nickText = joinDetailView.nickNameTextField.textField.text else { return }
                self.addUser()
            }else {
                present(common.alert(title: "", message: "이미 가입된 번호입니다!"), animated: false)
            }
        }
    }
    func addNcloud(customerId: String, name: String, birthdate: String){
        guard let email = infoDic["email"] else { return }
        guard let mobile = infoDic["mobile"] else { return }
        var params = [String:Any]()
        params.updateValue(customerId, forKey: "customer_id")
        params.updateValue(name, forKey: "nick")
        params.updateValue(1, forKey: "terms")
        params.updateValue(1, forKey: "insert")
        common.sendRequest(url: "http://110.165.17.124/sampleroad/v1/user.php", method: "post", params: params, sender: ""){ [self] reusultJson in
            print(reusultJson)
            let resultDic = reusultJson as! [String:Any]
            let code = resultDic["error"] as! String
            if code == "1" {
                //nCloud 데이터베이스 유저 추가 성공
                let convertDate = self.common.stringToDate2(string: birthdate)
                let strDate = "\(convertDate)"
                let convertDate2 = strDate.prefix(10)
                UserDefaults.standard.set(customerId, forKey: "customer_id")
                UserDefaults.standard.set(email, forKey: "user_email")
                UserDefaults.standard.set(mobile, forKey: "user_mobile")
                UserDefaults.standard.set(name, forKey: "user_name")
                UserDefaults.standard.set(name, forKey: "user_alias")
                UserDefaults.standard.set(convertDate2, forKey: "user_birth")
                UserDefaults.standard.set(self.gender, forKey: "user_gender")
                let vc = CertificationEmailViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                //nCloud 데이터베이스 유저 추가 실패 -> clayful 유저 삭제
                common2.sendRequest(url: "https://api.clayful.io/v1/customers/\(customerId)", method: "delete", params: [:], sender: "") { resultJson in
                    self.present(common.alert(title: "에러", message: "잠시후 다시 시도해주세요"), animated: true)
                }
            }
        }
    }
    
    func addUser(){
        var params = [String:Any]()
        guard let email = infoDic["email"] else { return }
        guard let pass = infoDic["pass"] else { return }
        guard let mobile = infoDic["mobile"] else { return }
        guard let fullName = joinDetailView.nickNameTextField.textField.text else { return }
        guard let birthdate = joinDetailView.birthDateTextField.textField.text else { return }
        let name = ["full":fullName]
        let jsonData = try! JSONSerialization.data(withJSONObject: name, options: [])
        let decodedName = String(data: jsonData, encoding: .utf8)!
        params.updateValue(email, forKey: "email")
        params.updateValue(pass, forKey: "password")
        params.updateValue(mobile, forKey: "mobile")
        params.updateValue(decodedName, forKey: "name")
        params.updateValue(fullName, forKey: "alias")
        if gender != "none" {
            params.updateValue(gender, forKey: "gender")
        }
        let convertDate = common.stringToDate2(string: birthdate)
        params.updateValue(convertDate, forKey: "birthdate")
        common.sendRequest(url: "https://api.clayful.io/v1/customers", method: "post", params: params, sender: ""){ [self] reusultJson in
            print(reusultJson)
            guard let resultDic = reusultJson as? [String:Any] else {return}
            guard let customerId = resultDic["_id"] as? String else {
                present(common.alert(title: "", message: "이미 가입된 이메일입니다."), animated: true)
                return
            }
            addNcloud(customerId: customerId, name: fullName, birthdate: birthdate)
        }
    }
  
    
    
    
}
extension JoinDetailSViewController:UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        common2.checkMaxLength(textField: joinDetailView.birthDateTextField.textField, maxLength: 12)
        checkBool = false
    }
}
