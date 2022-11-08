//
//  LoginView.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/09/22.
//

import Foundation
import UIKit

class LoginView: UIView{
    let screenBounds = UIScreen.main.bounds
    let margin = 60.0
    let common = CommonS()
    let bottmView = LoginBottomView()
    let topView = LoginTopView()
    let emailView = TextFieldView(frame: .zero, title: "이메일", placeholder: "이메일을 입력해주세요.").then{
        $0.textField.text = UserDefaults.standard.string(forKey: "user_email")
    }
    let passView = TextFieldView(frame: .zero, title: "비밀번호", placeholder: "비밀번호를 입력해주세요.").then{
        $0.textField.isSecureTextEntry = true
    }
    var checkCheckBtn = Bool()
    //버튼과 시작하기 사이 길이
    lazy var betweenY = screenBounds.height/2 - screenBounds.width/12 - screenBounds.width/4

    lazy var loginBtn = UIButton().then{
        $0.setTitle("시작하기", for: .normal)
        $0.backgroundColor = common.pointColor()
        $0.titleLabel!.font = common.setFont(font: "bold", size: 18)
        $0.layer.cornerRadius = 8
    }
    lazy var kakaoBtn = UIButton().then{
        $0.backgroundColor = common.setColor(hex: "#fae300")
        $0.setImage(UIImage(named: "login_kakao_btn"), for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        if !UserDefaults.standard.bool(forKey: "PRDC_MODE"){
            $0.isHidden = true
        }
    }
    lazy var naverBtn = UIButton().then{
        $0.setImage(UIImage(named: "login_naver_btn"), for: .normal)
        $0.backgroundColor = common.setColor(hex: "#06be34")
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        if !UserDefaults.standard.bool(forKey: "PRDC_MODE"){
            $0.isHidden = true
        }
    }
    let checkBtn = UIButton().then{
        $0.setImage(UIImage(named: "login_check_off_btn"), for: .normal)
        $0.addTarget(self, action: #selector(touchCheckBtn), for: .touchUpInside)
    }
    lazy var autoLoginLbl = UILabel().then{
        $0.text = "자동 로그인"
        $0.textColor = common.setColor(hex: "#b1b1b1")
        $0.font = common.setFont(font: "semiBold", size: 12)
    }
    lazy var findPassBtn = UIButton().then{
        $0.setTitle("비밀번호 찾기", for: .normal)
        $0.titleLabel?.font = common.setFont(font: "semibold", size: 12)
        $0.setTitleColor(common.pointColor(), for: .normal)
        if !UserDefaults.standard.bool(forKey: "PRDC_MODE"){
            $0.isHidden = true
        }else{
            $0.isHidden = false
        }
    }
    lazy var findEmailBtn = UIButton().then{
        $0.setTitle("이메일 찾기 /", for: .normal)
        $0.titleLabel?.font = common.setFont(font: "semibold", size: 12)
        $0.setTitleColor(common.pointColor(), for: .normal)
        if !UserDefaults.standard.bool(forKey: "PRDC_MODE"){
            $0.isHidden = true
        }else{
            $0.isHidden = false
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        checkCheckBtn = false
        addSubviewFunc()
        setLayout()


    }

    required init(coder: NSCoder) {
        fatalError("init fail")
    }

    func setLayout(){
        bottmView.snp.makeConstraints{
            $0.bottom.left.right.equalToSuperview()
            $0.top.equalToSuperview().offset(screenBounds.height/2)
        }
        topView.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(self.snp.top).offset(screenBounds.width/4)
        }
        loginBtn.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(findEmailBtn.snp.bottom).offset(40)
            $0.size.equalTo(CGSize(width: screenBounds.width - margin * 2, height: screenBounds.width/6))
        }
        kakaoBtn.snp.makeConstraints{
            $0.right.equalTo(self.snp.centerX).offset(-3)
            $0.size.equalTo(CGSize(width: 100, height: 50))
            $0.top.equalTo(loginBtn.snp.bottom).offset(40)
        }
        naverBtn.snp.makeConstraints{
            $0.top.equalTo(loginBtn.snp.bottom).offset(40)
            $0.left.equalTo(self.snp.centerX).offset(3)
            $0.size.equalTo(CGSize(width: 100, height: 50))
        }
        emailView.snp.makeConstraints{
            $0.top.equalTo(topView.snp.bottom).offset(40)
            $0.left.right.equalToSuperview()
            $0.size.equalTo(CGSize(width: screenBounds.width, height: 80))
        }
        passView.snp.makeConstraints{
            $0.top.equalTo(emailView.snp.bottom).offset(40)
            $0.left.right.equalToSuperview()
            $0.size.equalTo(CGSize(width: screenBounds.width, height: 80))
        }
        checkBtn.snp.makeConstraints{
            $0.left.equalToSuperview().offset(30)
            $0.top.equalTo(passView.snp.bottom).offset(20)
        }
        autoLoginLbl.snp.makeConstraints{
            $0.left.equalTo(checkBtn.snp.right).offset(10)
            $0.centerY.equalTo(checkBtn.snp.centerY)
        }
        findPassBtn.snp.makeConstraints{
            $0.right.equalToSuperview().offset(-30)
            $0.centerY.equalTo(autoLoginLbl)
        }
        findEmailBtn.snp.makeConstraints{
            $0.right.equalTo(findPassBtn.snp.left)
            $0.centerY.equalTo(autoLoginLbl)
        }


    }
    func addSubviewFunc(){
        [bottmView,topView,kakaoBtn,naverBtn, emailView,passView,checkBtn,findPassBtn,findEmailBtn,autoLoginLbl,loginBtn].forEach{
            self.addSubview($0)
        }
    }
    @objc func touchCheckBtn(){
        if checkCheckBtn{
            checkBtn.setImage(UIImage(named: "login_check_off_btn"), for: .normal)
            checkCheckBtn = false
        }else{
            checkBtn.setImage(UIImage(named: "login_check_on_btn"), for: .normal)
            checkCheckBtn = true
        }
    }
    
}
