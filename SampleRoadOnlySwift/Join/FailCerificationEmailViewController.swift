//
//  FailCerificationEmailViewController.swift
//  sampleroad
//
//  Created by NOTEGG on 2022/08/23.
//  Copyright © 2022 CNKANG. All rights reserved.
//

import UIKit

class FailCerificationEmailViewController: UIViewController, UITextFieldDelegate {
    let screenBounds = UIScreen.main.bounds

    let margin = 27.0
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
    let firsLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "기존 이메일"
        lbl.font = Common.kFont(withSize: "bold", 17)
        lbl.textColor = Common.pointColor1()
        return lbl
    }()
    let secondLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "변경할 이메일"
        lbl.font = Common.kFont(withSize: "bold", 17)
        lbl.textColor = Common.pointColor1()
        return lbl
    }()
    let thirdLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "비밀번호"
        lbl.font = Common.kFont(withSize: "bold", 17)
        lbl.textColor = Common.pointColor1()
        return lbl
    }()
    let firstTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "기존 이메일을 입력해주세요"
        textField.font = Common.kFont(withSize: "bold", 18)
        textField.textColor = .lightGray
       return textField
    }()
    let firstUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let secondTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "변경할 이메일을 입력해주세요"
        textField.font = Common.kFont(withSize: "bold", 18)
        textField.textColor = .lightGray
       return textField
    }()
    let secondUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let thirdTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호를 입력해주세요"
        textField.font = Common.kFont(withSize: "bold", 18)
        textField.isSecureTextEntry = true
        textField.textColor = .lightGray
       return textField
    }()
    let thirdUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    let submitBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("이메일 변경", for: .normal)
        btn.backgroundColor = Common.pointColor1()
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = Common.kFont(withSize: "bold", 18)
        btn.layer.cornerRadius = 3
        btn.addTarget(self, action: #selector(touchSubmitBtn), for: .touchUpInside)
        return btn
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
        thirdTextField.delegate = self
                
    }
    func addSubView(){
        view.addSubview(contentView)
        contentView.addSubview(backgroundImgView)
        contentView.addSubview(copyrightLbl)
        contentView.addSubview(bottomLabel)
        contentView.addSubview(submitBtn)
        contentView.addSubview(firsLabel)
        contentView.addSubview(secondLabel)
        contentView.addSubview(thirdLabel)
        contentView.addSubview(firstUnderLine)
        contentView.addSubview(secondUnderLine)
        contentView.addSubview(thirdUnderLine)
        contentView.addSubview(firstTextField)
        contentView.addSubview(secondTextField)
        contentView.addSubview(thirdTextField)
        contentView.addSubview(titleLbl)
        contentView.addSubview(homeBtn)
        
    }
    func layout(){
        contentView.frame = CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.height)
        backgroundImgView.frame = CGRect(x: 0, y: screenBounds.height - (backgroundImgView.image?.size.height)!, width: screenBounds.width, height: (backgroundImgView.image?.size.height)!)
        titleLbl.frame = CGRect(x: 0, y: Common.topHeight() - 35 - titleLbl.font.pointSize/2, width: screenBounds.width, height: titleLbl.font.pointSize)
        homeBtn.frame = CGRect(x: margin, y: Common.topHeight() - 20 - 30, width: 30, height: 30)
        firsLabel.frame = CGRect(x: margin, y: Common.topHeight() + 20, width: screenBounds.width - margin, height: firsLabel.font.pointSize)
        let scrY = firsLabel.font.pointSize + 15
        firstTextField.frame = CGRect(x: margin, y: firsLabel.frame.origin.y + scrY, width: screenBounds.width - margin * 2, height: firstTextField.font!.pointSize)
        firstUnderLine.frame = CGRect(x: margin, y: firsLabel.frame.origin.y + scrY + firstTextField.font!.pointSize + 5, width: screenBounds.width - margin * 2, height: 1)
        secondLabel.frame = CGRect(x: margin, y: firstUnderLine.frame.origin.y + 1 + 20, width: screenBounds.width - margin, height: firsLabel.font.pointSize)
        secondTextField.frame = CGRect(x: margin, y: secondLabel.frame.origin.y + scrY, width: screenBounds.width - margin * 2, height: firstTextField.font!.pointSize)
        secondUnderLine.frame = CGRect(x: margin, y: secondLabel.frame.origin.y + scrY + firstTextField.font!.pointSize + 5, width: screenBounds.width - margin * 2, height: 1)
        thirdLabel.frame = CGRect(x: margin, y: secondUnderLine.frame.origin.y + 1 + 20, width: screenBounds.width - margin, height: firsLabel.font.pointSize)
        thirdTextField.frame = CGRect(x: margin, y: thirdLabel.frame.origin.y + scrY, width: screenBounds.width - margin * 2, height: firstTextField.font!.pointSize)
        thirdUnderLine.frame = CGRect(x: margin, y: thirdLabel.frame.origin.y + scrY + firstTextField.font!.pointSize + 5, width: screenBounds.width - margin * 2, height: 1)
        submitBtn.frame = CGRect(x: margin, y: thirdUnderLine.frame.origin.y + 1 + 30, width: screenBounds.width - margin * 2, height: 60)
        bottomLabel.frame = CGRect(x: 0, y: screenBounds.height - screenBounds.width/4 + 20, width: screenBounds.width, height: titleLbl.font.pointSize)
        copyrightLbl.frame = CGRect(x: 0, y: screenBounds.height - 20 - copyrightLbl.font.pointSize, width: screenBounds.width, height: copyrightLbl.font.pointSize)
        
    }
    @objc func touchSubmitBtn(){
        if (firstTextField.text == "") {
            present(common.alert(title: "", message: "기존 이메일을 입력해주세요"),animated: true)
        }else if (secondTextField.text == "") {
            present(common.alert(title: "", message: "변경할 이메일을 입력해주세요"),animated: true)
        }else if (thirdTextField.text == "") {
            present(common.alert(title: "", message: "비밀번호를 입력해주세요"),animated: true)
        }else if !checkEmail(str: firstTextField.text!){
            present(common.alert(title: "", message: "이메일 형식이 아닙니다"),animated: true)
        }else if !checkEmail(str: secondTextField.text!){
            present(common.alert(title: "", message: "이메일 형식이 아닙니다"),animated: true)
        }else if firstTextField.text != UserDefaults.standard.string(forKey: "user_email") ?? "" {
            present(common.alert(title: "", message: "기존 이메일이 다릅니다"),animated: true)
        }else{
          checkPass()
        }
    }
    func checkPass(){
        var params = [String:Any]()
        let email = firstTextField.text
        let pass = thirdTextField.text
        params.updateValue(email!, forKey: "email")
        params.updateValue(pass!, forKey: "password")
        common.sendRequest(url: "https://api.clayful.io/v1/customers/auth", method: "post", params: params, sender: ""){[self] resultJson in
            var resultDic = [String:Any]()
            resultDic = resultJson as! [String:Any]
            print(resultDic)
            if ((resultDic["token"] as? String) != nil) {
                changeEmail()
            }else {
                if resultDic["errorCode"] as? String == "not-existing-customer" {
                    present(common.alert(title: "", message: "존재하지 않는 아이디입니다"), animated: true)
                }else if (resultDic["message"] as! String).contains("password") {
                    present(common.alert(title: "", message: "비밀번호가 일치하지 않습니다"), animated: true)
                }
            }
        }
    }
    func changeEmail(){
        UserDefaults.standard.set(secondTextField.text, forKey: "user_email")
        let text: String = "이메일이 변경되었습니다"
        let attributeString = NSMutableAttributedString(string: text)
        let font = Common.kFont(withSize: "regular", 13)
        attributeString.addAttribute(.font, value: font, range: (text as NSString).range(of: "\(text)")) // 폰트 적용.
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.changeClayfulEmail()
                }
        alert.setValue(attributeString, forKey: "attributedTitle")
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
    func changeClayfulEmail(){
        common.sendRequest(url: "https://api.clayful.io/v1/customers/\(customerId2)", method: "put", params: ["email":secondTextField.text!], sender: "") { resultJson in
            print(resultJson)
            self.changeNCloudEamil()
        }
    }
    func changeNCloudEamil(){
        common.sendRequest(url: "https://api.clayful.io/v1/customers/\(customerId2)", method: "put", params: ["email":secondTextField.text!], sender: "") { resultJson in
            print(resultJson)
            self.navigationController?.popViewController(animated: false)
        }
    }
    @objc func touchHomeBtn(){
        self.navigationController?.popViewController(animated: false)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
       }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        checkMaxLength(textField: thirdTextField, maxLength: 13)
    }
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text!.count  > maxLength) {
            textField.deleteBackward()
        }
    }
    func checkEmail(str: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return  NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: str)
    }
   
     
    

}
