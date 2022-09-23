//
//  FindEmailView.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/09/22.
//

import Foundation
import UIKit
class FindEmailView: UIView{
    let common = Common()
    let screenBounds = UIScreen.main.bounds
    let bottmView = BottomView()
    let topView = TopView()
//    let middleView = UIView().then{
//        $0.backgroundColor = .white
//    }
    let phoneTextField = TextFieldView(frame: .zero, title: "가입 시 입력한 전화번호", placeholder: "-없이 번호만 입력해주세요.")
    let certificationNumTextField = TextFieldView(frame: .zero, title: "인증번호", placeholder: "인증번호 네자리를 입력해주세요.")
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
        
        $0.layer.cornerRadius = screenBounds.width/7
//        $0.clipsToBounds = true
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
        setLayout()
        addSubviewFunc()
    }
    required init(coder: NSCoder) {
        fatalError("init fail")
    }
    func setLayout(){
        [topView,bottmView,phoneTextField,certificationNumTextField,subLabel].forEach{
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
            $0.centerY.equalTo(certificationNumTextField.textField.snp.centerY)
            $0.right.equalTo(certificationNumTextField.line.snp.right)
            $0.size.equalTo(CGSize(width: screenBounds.width/7, height: screenBounds.width/14))
        }
        certificationNumTextField.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-30 - screenBounds.height/2)
        }


    }
}
