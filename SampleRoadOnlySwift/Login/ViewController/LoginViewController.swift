//
//  LoginViewController.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/09/22.
//

import UIKit

class LoginViewController: UIViewController {
    let loginView = LoginView()
    let common = Common()
    override func loadView() {
        super.loadView()
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.loginBtn.addTarget(self, action: #selector(touchLoginBtn), for: .touchUpInside)
        
    }
    @objc func touchLoginBtn(){
        if loginView.emailView.textField.text! != ""{
            if common.isValidEmail(testStr: loginView.emailView.textField.text!){
            }else{
                present(common.alert(title: "", message: "이메일을 확인해주세요."),animated: true)
            }
        }else{
            present(common.alert(title: "", message: "이메일을 입력해주세요."),animated: true)
        }
        if loginView.passView.textField.text! == ""{
            present(common.alert(title: "", message: "비밀번호를 입력해주세요."),animated: true)
        }


    }


}
