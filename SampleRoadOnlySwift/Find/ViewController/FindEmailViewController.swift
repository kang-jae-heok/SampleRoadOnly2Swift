//
//  FindEmailViewController.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/09/22.
//

import UIKit  

class FindEmailViewController: UIViewController {
    let findEmailView = FindEmailView()
    let common = CommonS()
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
            findEmailView.phoneTextField.textField.text = phone
            findEmailView.checkBtn.backgroundColor = common.pointColor()
            view.endEditing(true)
        }
    }
    override func loadView() {
        super.loadView()
        view = findEmailView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
    }
    func setTarget(){
        findEmailView.topView.homeBtn.addTarget(self, action: #selector(touchHomeBtn), for: .touchUpInside)
        findEmailView.certificationBtn.addTarget(self, action: #selector(touchCertificationBtn), for: .touchUpInside)
        findEmailView.checkBtn.addTarget(self, action: #selector(touchCheckBtn), for: .touchUpInside)
        findEmailView.copyEmailBtn.addTarget(self, action: #selector(touchCopyEmailBtn(sender:)), for: .touchUpInside)
    }
    func copyBtnVisible(email: String){
        findEmailView.copyEmailBtn.isHidden = false
        findEmailView.phoneTextField.textField.isHidden = true
        findEmailView.checkBtn.isHidden = true
        findEmailView.phoneTextField.title.text = "회원님의 가입된 이메일은..."
        findEmailView.copyEmailBtn.setTitle(email + "입니다", for: .normal)
    }
    @objc func touchHomeBtn(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func touchCopyEmailBtn(sender: UIButton) {
        UIPasteboard.general.string = sender.titleLabel?.text?.components(separatedBy: "입니다").joined()
        present(common.alert(title: "", message: "복사되었습니다"), animated: true)
    }
    @objc func touchCertificationBtn(){
        var param:[String:Any] = [:]
        param.updateValue("CERT", forKey:"NAVI")
        let a = MainViewSController()
        let convertDic = NSMutableDictionary(dictionary: param)
        let vc = ComWebViewController(dic: convertDic )
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func touchCheckBtn(){
        if findEmailView.checkBtn.backgroundColor == common.pointColor() {
            var stringMobile = String(describing: findEmailView.phoneTextField.textField.text!)
            stringMobile.insert("-", at: stringMobile.index(stringMobile.startIndex, offsetBy: 3))
            stringMobile.insert("-", at: stringMobile.index(stringMobile.endIndex, offsetBy: -4))
            common2.sendRequest(url: "https://api.clayful.io/v1/customers?fields=email,social&mobile=\(stringMobile)", method: "get", params: [:], sender: "") { [self] resultJson in
                guard let resultDicArr = resultJson as? [[String:Any]] else {return}
                if resultDicArr.count > 0 {
                    guard let email = resultDicArr[0]["email"] as? String,
                          let socialArr = resultDicArr[0]["social"] as? [[String:Any]]
                    else {return}
                    if socialArr.count == 0 {
                        copyBtnVisible(email: email)
                    }else {
                        guard let vendor = socialArr[0]["vendor"] as? String else {return}
                        var alertText = String()
                        if vendor == "kakao" {
                            alertText = "카카오"
                        }else {
                            alertText = "네이버"
                        }
                        present(common.alert(title: "", message: "\(alertText) 간편 로그인으로\n가입하셨습니다"), animated: true)
                    }
                } else {
                    present(common.alert(title: "", message: "가입내역이 없습니다\n확인 후 다시 시도해주세요"), animated: true)
                }
               
            }
        }
    }

}
