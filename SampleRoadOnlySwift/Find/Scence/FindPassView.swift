//
//  FindPass.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/09/23.
//

import Foundation
import UIKit
class FindPassView: UIView{
    let common = CommonS()
    let screenBounds = UIScreen.main.bounds
    let bottmView = LoginBottomView()
    let topView = LoginTopView()
    lazy var title = UILabel().then{
        $0.text = "비밀번호 찾기"
        $0.font = common.setFont(font: "bold", size: 20)
        $0.textColor = common.pointColor()
    }
    let emailTextField = TextFieldView(frame: .zero, title: "가입 시 입력한 이메일 주소", placeholder: "가입하신 이메일을 입력해주세요.")
    lazy var subLabel = UILabel().then{
        $0.text = "입력해주신 이메일로 인증 문자를 보내드립니다."
        $0.font = common.setFont(font: "semibold", size: 12)
        $0.textColor = common.setColor(hex: "#b1b1b1")
    }
    lazy var sendBtn = UIButton().then{
        $0.backgroundColor = common.lightGray()
        $0.setTitle("발송", for: .normal)
        $0.titleLabel?.font = common.setFont(font: "semibold", size: 15)
        $0.setTitleColor(.white, for: .normal)
        $0.clipsToBounds = true
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        emailTextField.textField.delegate = self
        addSubviewFunc()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init fail")
    }
    func addSubviewFunc(){
        [topView,bottmView,emailTextField,subLabel,title].forEach{
            self.addSubview($0)
        }
        emailTextField.addSubview(sendBtn)
    }
    func setLayout(){
        bottmView.snp.makeConstraints{
            $0.bottom.left.right.equalToSuperview()
        }
        topView.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(self.snp.top).offset(screenBounds.width/4)
        }

        subLabel.snp.makeConstraints{
            $0.top.equalTo(emailTextField.line.snp.bottom).offset(3)
            $0.left.equalToSuperview().offset(30)
        }
        sendBtn.snp.makeConstraints{
            $0.centerY.equalTo(emailTextField.textField.snp.centerY).offset(-3)
            $0.right.equalTo(emailTextField.line.snp.right)
            $0.size.equalTo(CGSize(width: screenBounds.width/7, height: screenBounds.width/14))
            print(screenBounds.width/14)
            sendBtn.layer.cornerRadius =  screenBounds.width/28
        }
        emailTextField.snp.makeConstraints{
            $0.top.equalTo(topView.snp.bottom).offset(screenBounds.height/7)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(70)

        }
        title.snp.makeConstraints{
            $0.centerY.equalTo(topView.snp.bottom).offset(screenBounds.height/14)
            $0.left.equalToSuperview().offset(30)
        }
    }
}
extension FindPassView: UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        common.checkMaxLength(textField: emailTextField.textField, maxLength: 30)
        if common.isValidEmail(testStr: emailTextField.textField.text ?? ""){
            sendBtn.backgroundColor = common.pointColor()
        }else{
            sendBtn.backgroundColor = common.lightGray()
        }
    }
}
