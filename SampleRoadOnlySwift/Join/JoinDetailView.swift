//
//  JoinDetailView.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/09/30.
//

import Foundation
import UIKit

class JoinDetailView: UIView{
    let common = CommonS()
    let margin = 30.0
    let screenBounds = UIScreen.main.bounds
    let sclView = UIScrollView()
    let bottomView = LoginBottomView()
    let topVc = TopViewViewController()
    lazy var topView = topVc.topView
//    let topView = TopViewViewController.view
    lazy var genderLbl = UILabel().then{
        $0.text = "성별"
        $0.font = common.setFont(font: "semibold", size: 18)
        $0.textColor = common.pointColor()
    }
    let manBtn = UIButton().then{
        $0.setImage(UIImage(named: "man_off_btn"), for: .normal)
        $0.backgroundColor = .white
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.masksToBounds = false
        $0.layer.shadowRadius = 5
        $0.layer.shadowOpacity = 0.1
        $0.layer.shadowOffset = CGSize(width: 0, height: 5)
        $0.addTarget(self, action: #selector(touchManBtn), for: .touchUpInside)
    }
    let womanBtn = UIButton().then{
        $0.setImage(UIImage(named: "woman_off_btn"), for: .normal)
        $0.backgroundColor = .white
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.masksToBounds = false
        $0.layer.shadowRadius = 5
        $0.layer.shadowOpacity = 0.1
        $0.layer.shadowOffset = CGSize(width: 0, height: 5)
        $0.addTarget(self, action: #selector(touchWomanBtn), for: .touchUpInside)
    }
    lazy var manLbl = UILabel().then{
        $0.text = "남성"
        $0.font = common.setFont(font: "semibold", size: 18)
        $0.textColor = common.pointColor()
    }
    lazy var womanLbl = UILabel().then{
        $0.text = "여성"
        $0.font = common.setFont(font: "semibold", size: 18)
        $0.textColor = common.pointColor()
    }
    let nonCheckBtn = UIButton().then{
        $0.setImage(UIImage(named: "login_check_off_btn"), for: .normal)
        $0.addTarget(self, action: #selector(touchNonCheckBtn), for: .touchUpInside)
        $0.tag = 0
    }
    lazy var nonLbl = UILabel().then{
        $0.text = "전 입력하고 싶지 않아요"
        $0.font = common.setFont(font: "semiBold", size: 12)
        $0.textColor = common.pointColor()
    }
    lazy var subNonCheckLbl = UILabel().then{
        $0.text = "성별을 입력해주시면 더 정확한 추천이 가능해요!"
        $0.textColor = .red
        $0.font = common.setFont(font: "semiBold", size: 12)
//        $0.isHidden = true
    }
    let birthDatTextField = TextFieldView(frame: .zero, title: "생년월일(YYYY,MM,DD)", placeholder: "나이가 어떻게 되시죠? 고객님을 좀 더 알고 싶네요:)").then{
        $0.textField.keyboardType = .numberPad
    }
    let nickNameTextField = TextFieldView(frame: .zero, title: "닉네임", placeholder: "나만의 매력적인 닉네임을 정해주세요")
    lazy var nextBtn = UIButton().then{
        $0.setTitle("다음", for: .normal)
        $0.backgroundColor = common.pointColor()
        $0.titleLabel!.font = common.setFont(font: "bold", size: 18)
        $0.layer.cornerRadius = 8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        birthDatTextField.textField.delegate = self
        nickNameTextField.textField.delegate = self
        addSubviewFunc()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("fail init")
    }

    func setLayout(){
//        sclView.contentSize = CGSize(width: screenBounds.width, height: screenBounds.height)
        topView.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(self.snp.top).offset(screenBounds.width/4)
        }
        sclView.snp.makeConstraints{
            $0.top.equalTo(topView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(nextBtn.snp.top)
        }
        genderLbl.snp.makeConstraints{
            $0.top.equalToSuperview().offset(50)
            $0.left.equalToSuperview().offset(margin)
            $0.bottom.equalTo(genderLbl.snp.top).offset(genderLbl.font.pointSize)
//            $0.bottom.equalToSuperview().offset(50 + genderLbl.font.pointSize)
//            $0.size.height.equalTo(genderLbl.font.pointSize)
        }
        manBtn.snp.makeConstraints{
            $0.top.equalTo(genderLbl.snp.bottom).offset(20)
            $0.right.equalTo(super.snp.centerX).offset(-15)
            $0.size.equalTo(CGSize(width: screenBounds.width/4, height: screenBounds.width/4))
//            $0.left.equalTo(manBtn.snp.right).offset(-screenBounds.width/4)
//            $0.bottom.equalTo(manBtn.snp.top).offset(screenBounds.width/4)
        }
        womanBtn.snp.makeConstraints{
            $0.top.equalTo(genderLbl.snp.bottom).offset(20)
            $0.left.equalTo(super.snp.centerX).offset(15)
            $0.size.equalTo(CGSize(width: screenBounds.width/4, height: screenBounds.width/4))
        }
        manLbl.snp.makeConstraints{
            $0.top.equalTo(manBtn.snp.bottom).offset(20)
            $0.centerX.equalTo(manBtn)
        }
        womanLbl.snp.makeConstraints{
            $0.top.equalTo(womanBtn.snp.bottom).offset(20)
            $0.centerX.equalTo(womanBtn)
        }
        nonLbl.snp.makeConstraints{
            $0.top.equalTo(manLbl.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        nonCheckBtn.snp.makeConstraints{
            $0.centerY.equalTo(nonLbl.snp.centerY).offset(-1)
            $0.right.equalTo(nonLbl.snp.left).offset(-5)
        }
        birthDatTextField.snp.makeConstraints{
            $0.top.equalTo(nonLbl.snp.bottom).offset(50)
            $0.left.right.equalToSuperview()
            $0.size.equalTo(CGSize(width: screenBounds.width, height: 70))
        }
        nickNameTextField.snp.makeConstraints{
            $0.top.equalTo(birthDatTextField.snp.bottom).offset(30)
            $0.left.right.equalToSuperview()
            $0.size.equalTo(CGSize(width: screenBounds.width, height: 70))
            $0.bottom.equalToSuperview().offset(-50)
        }
        bottomView.snp.makeConstraints{
            $0.bottom.left.right.equalToSuperview()
            $0.top.equalToSuperview().offset(screenBounds.height - screenBounds.width)
        }
        nextBtn.snp.makeConstraints{
            $0.bottom.equalTo(bottomView.titleLbl.snp.top).offset(-20)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: screenBounds.width - margin * 2, height: screenBounds.width/6))
        }
    }
    func addSubviewFunc(){
        self.addSubview(bottomView)
        self.addSubview(topView)
        self.addSubview(sclView)
        self.addSubview(nextBtn)
        [genderLbl,manBtn,womanBtn,manLbl,womanLbl,nonLbl,nonCheckBtn,subNonCheckLbl,birthDatTextField,nickNameTextField].forEach{
            sclView.addSubview($0)
        }
    
       
        
//        bottomView.addSubview(nextBtn)
    }
    @objc func touchManBtn(){
        if womanBtn.backgroundColor == common.pointColor(){
            womanBtn.setImage(UIImage(named: "woman_off_btn"), for: .normal)
            womanBtn.backgroundColor = .white
        }
        if manBtn.backgroundColor == .white {
            manBtn.setImage(UIImage(named: "man_on_btn"), for: .normal)
            manBtn.backgroundColor = common.pointColor()
        }else{
            manBtn.setImage(UIImage(named: "man_off_btn"), for: .normal)
            manBtn.backgroundColor = .white
        }
        nonCheckBtn.setImage(UIImage(named: "login_check_off_btn"), for: .normal)
        nonCheckBtn.tag = 0
    }
    @objc func touchWomanBtn(){
        if manBtn.backgroundColor == common.pointColor(){
            manBtn.setImage(UIImage(named: "man_off_btn"), for: .normal)
            manBtn.backgroundColor = .white
        }
        if womanBtn.backgroundColor == .white {
            womanBtn.setImage(UIImage(named: "woman_on_btn"), for: .normal)
            womanBtn.backgroundColor = common.pointColor()
        }else{
            womanBtn.setImage(UIImage(named: "woman_off_btn"), for: .normal)
            womanBtn.backgroundColor = .white
        }
        nonCheckBtn.setImage(UIImage(named: "login_check_off_btn"), for: .normal)
        nonCheckBtn.tag = 0
    }
    @objc func touchNonCheckBtn(){
        if nonCheckBtn.tag == 0 {
            manBtn.setImage(UIImage(named: "man_off_btn"), for: .normal)
            manBtn.backgroundColor = .white
            womanBtn.setImage(UIImage(named: "woman_off_btn"), for: .normal)
            womanBtn.backgroundColor = .white
            nonCheckBtn.setImage(UIImage(named: "login_check_on_btn"), for: .normal)
            nonCheckBtn.tag = 1
        }else{
            nonCheckBtn.setImage(UIImage(named: "login_check_off_btn"), for: .normal)
            nonCheckBtn.tag = 0
        }
    }
}
extension JoinDetailView:UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        common.checkMaxLength(textField: birthDatTextField.textField, maxLength: 8)
        common.checkMaxLength(textField: nickNameTextField.textField, maxLength: 12)
    }
}
