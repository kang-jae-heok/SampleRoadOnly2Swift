//
//  FindEmailView.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/09/22.
//

import Foundation
import UIKit
class FindEmailView: UIView{
    let common = CommonS()
    let screenBounds = UIScreen.main.bounds
    let bottmView = LoginBottomView()
    let topView = LoginTopView()
    lazy var title = UILabel().then{
        $0.text = "이메일 찾기"
        $0.font = common.setFont(font: "bold", size: 20)
        $0.textColor = common.pointColor()
    }
    let phoneTextField = TextFieldView(frame: .zero, title: "가입 시 입력한 전화번호", placeholder: "-없이 번호만 입력해주세요.").then{
        $0.textField.keyboardType = .numberPad
    }
    let certificationNumTextField = TextFieldView(frame: .zero, title: "인증번호", placeholder: "인증번호 네자리를 입력해주세요.").then{
        $0.textField.keyboardType = .numberPad
        $0.textField.isSecureTextEntry = true
    }
    lazy var subLabel = UILabel().then{
        $0.text = "입력해주신 휴대전화 번호로 인증 문자를 보내드립니다."
        $0.font = common.setFont(font: "semibold", size: 12)
        $0.textColor = common.setColor(hex: "#b1b1b1")
    }
    lazy var certificationBtn = UIButton().then{
        $0.backgroundColor = common.lightGray()
        $0.setTitle("인증", for: .normal)
        $0.titleLabel?.font = common.setFont(font: "semibold", size: 15)
        $0.setTitleColor(.white, for: .normal)
        $0.clipsToBounds = true
    }
    lazy var checkBtn = UIButton().then{
        $0.backgroundColor = common.lightGray()
        $0.setTitle("확인", for: .normal)
        $0.titleLabel?.font = common.setFont(font: "semibold", size: 15)
        $0.setTitleColor(.white, for: .normal)
        $0.clipsToBounds = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        phoneTextField.textField.delegate = self
        certificationNumTextField.textField.delegate = self
        setLayout()
        addSubviewFunc()
    }
    required init(coder: NSCoder) {
        fatalError("init fail")
    }
    func setLayout(){
        [topView,bottmView,phoneTextField,certificationNumTextField,subLabel,title].forEach{
            self.addSubview($0)
        }
        certificationNumTextField.addSubview(certificationBtn)
        phoneTextField.addSubview(checkBtn)
    }
    func addSubviewFunc(){
        bottmView.snp.makeConstraints{
            $0.bottom.left.right.equalToSuperview()
        }
        topView.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(self.snp.top).offset(screenBounds.width/4)
        }

        certificationBtn.snp.makeConstraints{
            $0.centerY.equalTo(phoneTextField.textField.snp.centerY).offset(-3)
            $0.right.equalTo(phoneTextField.line.snp.right)
            $0.size.equalTo(CGSize(width: screenBounds.width/7, height: screenBounds.width/14))
            checkBtn.layer.cornerRadius =  screenBounds.width/28
        }
        certificationNumTextField.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-30 - screenBounds.height/2)
        }
        subLabel.snp.makeConstraints{
            $0.bottom.equalTo(certificationNumTextField.snp.top).offset(-30)
            $0.left.equalToSuperview().offset(30)
        }
        checkBtn.snp.makeConstraints{
            $0.centerY.equalTo(certificationNumTextField.textField.snp.centerY).offset(-3)
            $0.right.equalTo(certificationNumTextField.line.snp.right)
            $0.size.equalTo(CGSize(width: screenBounds.width/7, height: screenBounds.width/14))
            certificationBtn.layer.cornerRadius =  screenBounds.width/28
        }
        phoneTextField.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(subLabel.snp.top).offset(-3)

        }
        title.snp.makeConstraints{
            $0.centerY.equalTo(topView.snp.bottom).offset(screenBounds.height/14)
            $0.left.equalToSuperview().offset(30)
        }


    }
}
extension FindEmailView: UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        common.checkMaxLength(textField: phoneTextField.textField, maxLength: 11)
        common.checkMaxLength(textField: certificationNumTextField.textField, maxLength: 4)
        
        if certificationNumTextField.textField.text?.count == 4{
            checkBtn.backgroundColor = common.pointColor()
        }else{
            checkBtn.backgroundColor = common.lightGray()
        }
        if phoneTextField.textField.text?.count == 11{
            certificationBtn.backgroundColor = common.pointColor()
        }else{
            certificationBtn.backgroundColor = common.lightGray()
        }
        
    }
}
