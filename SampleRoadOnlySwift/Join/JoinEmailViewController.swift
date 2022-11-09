//
//  JoinEmailViewController.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/09/30.
//

import UIKit

class JoinEmailViewController: UIViewController {
    let joinEmailView = JoinEmailView()
    let common = CommonS()
    let screenBounds = UIScreen.main.bounds
    //나중에 이메일 작업할때 필요한 소스
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        if UserDefaults.standard.value(forKey: "impId") != nil{
//            UserDefaults.standard.value(forKey: "impId").
//        }
//    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"impId"]) {
//
//        NSString *impId = [[NSUserDefaults standardUserDefaults] valueForKey:@"impId"];
//        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"impId"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        NSLog(@"###imp ID : %@",impId);
//        CertificationViewController *viewController = [[CertificationViewController alloc] initWithImpUid:impId];
//        [self.navigationController pushViewController:viewController animated:NO];
//
//
//    }
//
//    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"phone"]) {
//        NSString *phone = [[NSUserDefaults standardUserDefaults] valueForKey:@"phone"];
//        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"phone"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        NSLog(@"###phone number : %@",phone);
//        [self.phone setText:phone];
//        [self.view endEditing:YES];
//
//
//    }
//    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.value(forKey: "impId") != nil {

            guard let impId = UserDefaults.standard.value(forKey: "impId") else { return }
            UserDefaults.standard.set(nil, forKey: "impId")
            UserDefaults.standard.synchronize()
            print("impId 타입")
            print(impId)
            let viewController = CertificationViewController(impUid: impId as! String)
            navigationController?.pushViewController(viewController, animated: false)
        }
        if UserDefaults.standard.value(forKey: "phone") != nil {
            let phone = UserDefaults.standard.value(forKey: "phone") as? String
            UserDefaults.standard.set(nil, forKey: "phone")
            UserDefaults.standard.synchronize()
            print("###phone number : \(phone ?? "")")
            joinEmailView.phoneTextField.textField.text = phone
            view.endEditing(true)
        }
    }
    override func loadView() {
        super.loadView()
        view = joinEmailView
    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
//          self.view.endEditing(true)
//
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        joinEmailView.nextBtn.addTarget(self, action: #selector(touchNextBtn), for: .touchUpInside)
        joinEmailView.topView.homeBtn.addTarget(self, action: #selector(touchHomeBtn), for: .touchUpInside)
        joinEmailView.phoneBtn.addTarget(self, action: #selector(touchPhoneTextField(textField:)), for: .touchUpInside)
    }
    
    @objc func touchNextBtn(){
        var dic = [String:String]()
        guard let email = joinEmailView.emailTextField.textField.text else { return  }
        guard let pass = joinEmailView.passTextField.textField.text else { return  }
        guard let mobile = joinEmailView.phoneTextField.textField.text else { return  }
        dic.updateValue(email, forKey: "email")
        dic.updateValue(pass, forKey: "pass")
        dic.updateValue(mobile, forKey: "mobile")
        
        if common.checknilTextField(text: joinEmailView.emailTextField.textField.text ?? ""){
            present(common.alert(title: "", message: "이메일을 입력해주세요"), animated: false)
        }else if !(common.isValidEmail(testStr: joinEmailView.emailTextField.textField.text ?? "")){
            present(common.alert(title: "", message: "이메일 다시 확인해주세요"), animated: false)
        }else if common.checknilTextField(text: joinEmailView.passTextField.textField.text ?? ""){
            present(common.alert(title: "", message: "비밀번호를 입력해주세요"), animated: false)
        }else if !(common.isValidPass(testStr: joinEmailView.passTextField.textField.text ?? "")){
            present(common.alert(title: "", message: "비밀번호를 형식에 맞게 작성해주세요"), animated: false)
        }else if joinEmailView.passTextField.textField.text != joinEmailView.checkPassTextField.textField.text{
            present(common.alert(title: "", message: "비밀번호가 맞지 않습니다"), animated: false)
        }else if joinEmailView.phoneTextField.textField.text == "" {
            present(common.alert(title: "", message: "핸드폰 번호를 입력해주세요"), animated: false)
        }else{
            let vc = JoinDetailSViewController(dic: dic)
                self.navigationController?.pushViewController(vc, animated: true)
            }
    }
    @objc func touchHomeBtn(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func touchPhoneTextField(textField: UITextField){
        var param:[String:Any] = [:]
        param.updateValue("CERT", forKey:"NAVI")
        let a = MainViewSController()
        let convertDic = NSMutableDictionary(dictionary: param)
        let vc = ComWebViewController(dic: convertDic )
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}

