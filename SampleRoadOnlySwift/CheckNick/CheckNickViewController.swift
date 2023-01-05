//
//  CheckNickViewController.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/11/18.
//

import UIKit

class CheckNickViewController: UIViewController {
    let checkNickView = CheckNickView()
    var checkBool = false
    override func loadView() {
        super.loadView()
        view = checkNickView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        checkNickView.nickTextField.textField.delegate = self
        setTarget()
    }
    func setTarget(){
        checkNickView.checkDuplicateBtn.addTarget(self, action: #selector(touchCheckDuplicateBtn), for: .touchUpInside)
        checkNickView.submitBtn.addTarget(self, action: #selector(touchSubmitBtn), for: .touchUpInside)
        
    }
    
    @objc func touchCheckDuplicateBtn(){
        guard let nickText = checkNickView.nickTextField.textField.text else { return }
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
    @objc func touchSubmitBtn(){
        guard let nickText = checkNickView.nickTextField.textField.text else { return }
        if checkBool {
            common2.checkDuplicateAndMakeNick(vc: self, nick: nickText)
        } else {
            present(common2.alert(title: "", message: "중복체크 해주세요"), animated: true)
        }
    }
    

}
extension CheckNickViewController:UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        common2.checkMaxLength(textField: checkNickView.nickTextField.textField, maxLength: 12)
        checkBool = false
    }
}
