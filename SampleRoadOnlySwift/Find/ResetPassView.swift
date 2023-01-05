//
//  ResetPassVIew.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/12/06.
//

import Foundation
class ResetPassView: UIView{
    let common = CommonS()
    let screenBounds = UIScreen.main.bounds
    let bottmView = LoginBottomView()
    let topView = LoginTopView()
    lazy var title = UILabel().then{
        $0.text = "비밀번호 찾기"
        $0.font = common.setFont(font: "bold", size: 20)
        $0.textColor = common.pointColor()
    }
    let passTextField = TextFieldView(frame: .zero, title: "변경할 비밀번호", placeholder: "변경할 비밀번호를 입력해주세요").then {
        $0.textField.isSecureTextEntry = true
    }
    lazy var resetBtn = UIButton().then{
        $0.backgroundColor = common.lightGray()
        $0.setTitle("변경", for: .normal)
        $0.titleLabel?.font = common.setFont(font: "semibold", size: 15)
        $0.setTitleColor(.white, for: .normal)
        $0.clipsToBounds = true
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        passTextField.textField.delegate = self
        addSubviewFunc()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init fail")
    }
    func addSubviewFunc(){
        [topView,bottmView,passTextField,title].forEach{
            self.addSubview($0)
        }
        passTextField.addSubview(resetBtn)
    }
    func setLayout(){
        bottmView.snp.makeConstraints{
            $0.bottom.left.right.equalToSuperview()
        }
        topView.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(self.snp.top).offset(screenBounds.width/4)
        }
        resetBtn.snp.makeConstraints{
            $0.centerY.equalTo(passTextField.textField.snp.centerY).offset(-3)
            $0.right.equalTo(passTextField.line.snp.right)
            $0.size.equalTo(CGSize(width: screenBounds.width/7, height: screenBounds.width/14))
            print(screenBounds.width/14)
            resetBtn.layer.cornerRadius =  screenBounds.width/28
        }
        passTextField.snp.makeConstraints{
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
extension ResetPassView: UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        common.checkMaxLength(textField:  passTextField.textField, maxLength: 12)
        if passTextField.textField.text?.count ?? 0 > 0 {
            resetBtn.backgroundColor = common.pointColor()
        }else{
            resetBtn.backgroundColor = common.lightGray()
        }
    }
}
