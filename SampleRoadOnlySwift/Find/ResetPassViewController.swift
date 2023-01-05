//
//  ResetPassViewController.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/12/06.
//

import UIKit

class ResetPassViewController: UIViewController {
    let resetPassView = ResetPassView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = resetPassView
        setTarget()
    }
    func setTarget() {
        resetPassView.resetBtn.addTarget(self, action: #selector(touchResetPassBtn), for: .touchUpInside)
        resetPassView.topView.homeBtn.addTarget(self, action: #selector(touchHomeBtn), for: .touchUpInside)
    }
    func resetPass() {
        if common2.isValidPass(testStr: resetPassView.passTextField.textField.text ?? "") {
            self.present(common2.alert(title: "에러", message: "비밀번호 형식에 맞춰서 입력해주세요(영문+숫자 6~12자"), animated: true)
            return
        }
        var params = [String:Any]()
        params.updateValue(UserDefaults.standard.string(forKey: "reset-secret") ?? "", forKey: "secret")
        params.updateValue(resetPassView.passTextField.textField.text ?? "", forKey: "password")
        common2.sendRequest(url: "https://api.clayful.io/v1/customers/\(UserDefaults.standard.string(forKey: "reset-customer") ?? "")/password", method: "put", params: params, sender: "") { resultJson in
            print(resultJson)
            guard let resultDic = resultJson as? [String:Any] else {return}
            if resultDic["reset"] != nil {
                UserDefaults.standard.removeObject(forKey: "reset-secret")
                UserDefaults.standard.removeObject(forKey: "reset-customer")
                self.navigationController?.pushViewController(MainViewSController(), animated: true)
                self.present(self.common2.alert(title: "", message: "정상적으로 변경 되었습니다"), animated: true)
            }else {
                UserDefaults.standard.removeObject(forKey: "reset-secret")
                UserDefaults.standard.removeObject(forKey: "reset-customer")
                self.navigationController?.pushViewController(FindPassViewController(), animated: true)
                self.present(self.common2.alert(title: "오류", message: "잠시후에 다시 시도해주세요"), animated: true)
            }
        }
    }
    @objc func touchResetPassBtn() {
        if common2.isValidPass(testStr: resetPassView.passTextField.textField.text ?? "") {
            resetPass()
        }else {
            present(common2.alert(title: "", message: "비밀번호 형식에 맞춰서 입력해주세요"), animated: true)
        }
    }
    @objc func touchHomeBtn() {
        UserDefaults.standard.removeObject(forKey: "reset-secret")
        UserDefaults.standard.removeObject(forKey: "reset-customer")
        self.navigationController?.popViewController(animated: true)
    }

}
