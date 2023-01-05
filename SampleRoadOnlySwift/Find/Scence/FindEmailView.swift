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
    let phoneTextField = TextFieldView(frame: .zero, title: "가입 시 입력한 전화번호", placeholder: "여기를 클릭해주세요.")
    lazy var checkBtn = UIButton().then{
        $0.backgroundColor = common.lightGray()
        $0.setTitle("확인", for: .normal)
        $0.titleLabel?.font = common.setFont(font: "semibold", size: 15)
        $0.setTitleColor(.white, for: .normal)
        $0.clipsToBounds = true
    }
    let certificationBtn = UIButton()
    lazy var copyEmailBtn = UIButton().then {
        $0.isHidden = true
        $0.setTitleColor(common2.pointColor(), for: .normal)
        $0.titleLabel?.font = common2.setFont(font: "medium", size: 18 * screenRatio)
        $0.contentMode = .left
        $0.contentHorizontalAlignment = .left
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        phoneTextField.textField.delegate = self
        addSubviewFunc()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init fail")
    }
    func addSubviewFunc(){
        [topView,bottmView,phoneTextField,title,certificationBtn,copyEmailBtn].forEach{
            self.addSubview($0)
        }
        phoneTextField.addSubview(checkBtn)
    }
    func setLayout(){
        bottmView.snp.makeConstraints{
            $0.bottom.left.right.equalToSuperview()
        }
        topView.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(self.snp.top).offset(screenBounds.width/4)
        }

        checkBtn.snp.makeConstraints{
            $0.centerY.equalTo(phoneTextField.textField.snp.centerY).offset(-3)
            $0.right.equalTo(phoneTextField.line.snp.right)
            $0.size.equalTo(CGSize(width: screenBounds.width/7, height: screenBounds.width/14))
            print(screenBounds.width/14)
            checkBtn.layer.cornerRadius =  screenBounds.width/28
        }
        phoneTextField.snp.makeConstraints{
            $0.top.equalTo(topView.snp.bottom).offset(screenBounds.height/7)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(70)
        }
        title.snp.makeConstraints{
            $0.centerY.equalTo(topView.snp.bottom).offset(screenBounds.height/14)
            $0.left.equalToSuperview().offset(30)
        }
        certificationBtn.snp.makeConstraints {
            $0.left.top.bottom.equalTo(phoneTextField.textField)
            $0.right.equalTo(checkBtn.snp.left)
        }
        copyEmailBtn.snp.makeConstraints {
            $0.left.top.bottom.right.equalTo(phoneTextField.textField)
        }
    }
}
extension FindEmailView: UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        common.checkMaxLength(textField: phoneTextField.textField, maxLength: 30)
        if common.isValidEmail(testStr: phoneTextField.textField.text ?? ""){
            checkBtn.backgroundColor = common.pointColor()
        }else{
            checkBtn.backgroundColor = common.lightGray()
        }
    }
}
