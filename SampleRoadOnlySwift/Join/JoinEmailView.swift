//
//  JoinEmail.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/09/30.
//

import Foundation
import UIKit

class JoinEmailView: UIView{
    let common = CommonS()
    let screenBounds = UIScreen.main.bounds
    let margin = 30.0
    let topView = LoginTopView()
    let sclView = UIScrollView()
    let bottomView = LoginBottomView()
    let phoneBtn = UIButton()
    let emailTextField = TextFieldView(frame: .zero, title: "이메일", placeholder: "이메일을 입력하세요")
    let passTextField = TextFieldView(frame: .zero, title: "비밀번호", placeholder: "비밀번호를 입력해주세요 (영문+숫자 8~12자)").then{
        $0.textField.isSecureTextEntry = true
    }
    lazy var subPassTextLbl = UILabel().then{
        $0.text = "영문+숫자 포함 8~12자 입력하셔야 합니다"
        $0.textColor = common.gray()
        $0.font = common.setFont(font: "semiBold", size: 12)
    }
    let checkPassTextField = TextFieldView(frame: .zero, title: "비밀번호 확인", placeholder: "한번 더 입력해주세요").then{
        $0.textField.isSecureTextEntry = true
    }
    lazy var subCheckPassTextLbl = UILabel().then{
        $0.text = "비밀번호가 맞지 않습니다."
        $0.textColor = .red
        $0.font = common.setFont(font: "semiBold", size: 12)
        $0.isHidden = true
    }
    let phoneTextField = TextFieldView(frame: .zero, title: "핸드폰 번호", placeholder: "본인 확인을 위해 번호를 입력해주세요 (-없이)").then{
        $0.isUserInteractionEnabled = true
    }
    lazy var nextBtn = UIButton().then{
        $0.setTitle("다음", for: .normal)
        $0.backgroundColor = common.pointColor()
        $0.titleLabel!.font = common.setFont(font: "bold", size: 18)
        $0.layer.cornerRadius = 8
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        topView.titleLbl.text = "이메일 가입하기"
        self.backgroundColor = .white
        passTextField.textField.delegate = self
        checkPassTextField.textField.delegate = self
        addSubviewFunc()
        setLayout()
    }


    required init?(coder: NSCoder) {
        fatalError("init fail")
    }
    func setLayout(){
        bottomView.snp.makeConstraints{
            $0.bottom.left.right.equalToSuperview()
        }
        topView.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(self.snp.top).offset(screenBounds.width/4)
        }
        nextBtn.snp.makeConstraints{
            $0.bottom.equalTo(bottomView.titleLbl.snp.top).offset(-20)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(bottomView.titleLbl.snp.top).offset(-20 - screenBounds.width/6)
            $0.size.equalTo(CGSize(width: screenBounds.width - margin * 2, height: screenBounds.width/6))
        }
        sclView.snp.makeConstraints{
            $0.top.equalTo(topView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(nextBtn.snp.top)
        }
        emailTextField.snp.makeConstraints{
            $0.top.equalToSuperview().offset(50)
            $0.left.right.equalToSuperview()
            $0.size.equalTo(CGSize(width: screenBounds.width, height: 70))
        }
        passTextField.snp.makeConstraints{
            $0.top.equalTo(emailTextField.snp.bottom).offset(30)
            $0.left.right.equalToSuperview()
            $0.size.equalTo(CGSize(width: screenBounds.width, height: 70))
        }
        checkPassTextField.snp.makeConstraints{
            $0.top.equalTo(passTextField.snp.bottom).offset(30)
            $0.left.right.equalToSuperview()
            $0.size.equalTo(CGSize(width: screenBounds.width, height: 70))
        }
        phoneTextField.snp.makeConstraints{
            $0.top.equalTo(checkPassTextField.snp.bottom).offset(30)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-50)
            $0.size.equalTo(CGSize(width: screenBounds.width, height: 70))
        }
        phoneBtn.snp.makeConstraints{
            $0.edges.equalTo(phoneTextField.textField)
        }
        subPassTextLbl.snp.makeConstraints {
            $0.top.equalTo(passTextField.line.snp.bottom).offset(5)
            $0.left.equalTo(passTextField.line)
        }
        subCheckPassTextLbl.snp.makeConstraints {
            $0.top.equalTo(checkPassTextField.line.snp.bottom).offset(5)
            $0.left.equalTo(checkPassTextField.line)
        }
        sclView.layoutIfNeeded()
//        phoneTextField.layoutIfNeeded()
//        sclView.contentSize = CGSize(width: screenBounds.width, height: phoneTextField.frame.origin.y + phoneTextField.frame.size.height)
        print("스크롤뷰 높이" )
        print(phoneTextField.frame.origin.y)
        print(phoneTextField.frame.origin.y + phoneTextField.frame.height)
        print(sclView.frame.size.height)
        print(sclView.contentSize.height)
        
      
    }
    func addSubviewFunc(){
        [emailTextField,passTextField,checkPassTextField,phoneTextField, phoneBtn].forEach{
            sclView.addSubview($0)
        }
        passTextField.addSubview(subPassTextLbl)
        checkPassTextField.addSubview(subCheckPassTextLbl)
        bottomView.addSubview(nextBtn)
        self.addSubview(topView)
        self.addSubview(bottomView)
        self.addSubview(sclView)
    }
}
extension JoinEmailView:UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        common.checkMaxLength(textField:  passTextField.textField, maxLength: 12)
        common.checkMaxLength(textField: checkPassTextField.textField, maxLength: 12)
    }
    
}
