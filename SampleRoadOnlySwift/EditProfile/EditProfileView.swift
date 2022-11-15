//
//  EditProfileView.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/11/15.
//

import Foundation
class EditProfileView: UIView {
    var placeholderStr = String()
    let topView = SimpleTopView().then {
        $0.tit.text = "내 정보 수정"
    }
    lazy var saveBtn = UIButton().then{
        $0.setTitle("저장", for: .normal)
        $0.setTitleColor(common2.gray(), for: .normal)
        $0.titleLabel?.font = common2.setFont(font: "bold", size: 15)
    }
    let originalInfoView = UIView()
    lazy var originalTitBackgroundView = UIView().then {
        $0.backgroundColor = common2.pointColor()
    }
    lazy var originalTit = UILabel().then {
        $0.font = common2.setFont(font: "regular", size: 13)
        $0.text = "\(UserDefaults.standard.string(forKey: "user_name")!) 님의 기본 정보"
        $0.asFontColor(targetStringList: ["\(UserDefaults.standard.string(forKey: "user_name")!)"], font: common2.setFont(font: "bold", size: 13), color: .blue)
    }
    
    lazy var emailLbl = UILabel().then {
        $0.text = "이메일"
        $0.font = common2.setFont(font: "bold", size: 13)
    }
    lazy var email = UILabel().then {
        $0.text = UserDefaults.standard.string(forKey: "user_email")
        $0.font = common2.setFont(font: "regular", size: 13)
    }
    lazy var nameLbl = UILabel().then {
        $0.text = "닉네임"
        $0.font = common2.setFont(font: "bold", size: 13)
    }
    lazy var nameTextField = UITextField().then{
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.5),
            NSAttributedString.Key.font : common2.setFont(font: "medium", size: 18)
        ]
        placeholderStr = UserDefaults.standard.string(forKey: "user_name") ?? "샘플털이범"
        $0.placeholder = placeholderStr
        $0.attributedPlaceholder = NSAttributedString(string: placeholderStr, attributes:attributes)
    }
    lazy var nameDuplicateCheckBtn = UIButton().then{
        $0.backgroundColor = common2.pointColor()
        $0.setTitle("중복검사", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = common2.setFont(font: "bold", size: 10)
        $0.layer.cornerRadius = 5
    }
    lazy var nameTextFieldLineView = UIView().then{
        $0.backgroundColor = common2.pointColor()
    }
    lazy var passwordLbl = UILabel().then {
        $0.text = "비밀번호"
        $0.font = common2.setFont(font: "bold", size: 13)
    }
    lazy var passwordTextField = UITextField().then{
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.5),
            NSAttributedString.Key.font : common2.setFont(font: "medium", size: 18)
        ]
        placeholderStr = "비밀번호를 입력해주세요"
        $0.placeholder = placeholderStr
        $0.attributedPlaceholder = NSAttributedString(string: placeholderStr, attributes:attributes)
        $0.isSecureTextEntry = true
    }
    lazy var passwordTextFieldLineView = UIView().then{
        $0.backgroundColor = common2.pointColor()
    }
    let detailInfoView = UIView()
    lazy var detailTitBackgroundView = UIView().then {
        $0.backgroundColor = common2.pointColor()
    }
    lazy var detailTit = UILabel().then {
        $0.font = common2.setFont(font: "bold", size: 13)
        $0.text = "상세 정보  고객님을 위한 화장품을 추천해드리는데 필요합니다:)"
        $0.asFont(targetStringList: ["고객님을 위한 화장품을 추천해드리는데 필요합니다:)"], font: common2.setFont(font: "regular", size: 10))
    }
    lazy var genderLbl = UILabel().then {
        $0.text = "성별"
        $0.font = common2.setFont(font: "bold", size: 13)
    }
    lazy var womanBtn = UIButton().then {
        $0.setTitle("여성", for: .normal)
        $0.setTitleColor(common2.pointColor(), for: .normal)
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = common2.pointColor().cgColor
        $0.layer.borderWidth = 1
        $0.titleLabel?.font = common2.setFont(font: "bold", size: 13)
    }
    lazy var manBtn = UIButton().then {
        $0.setTitle("남성", for: .normal)
        $0.setTitleColor(common2.pointColor(), for: .normal)
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = common2.pointColor().cgColor
        $0.layer.borderWidth = 1
        $0.titleLabel?.font = common2.setFont(font: "bold", size: 13)
    }
    lazy var subGenderLbl = UILabel().then {
        $0.text = "성별을 입력해주시면 더 정확한 추천이 가능해요!"
        $0.textColor = .red
        $0.font = common2.setFont(font: "regular", size: 10)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubviewFunc()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init fail(EditProfileView)")
    }
    func addSubviewFunc(){
        [topView,originalInfoView,detailInfoView].forEach{
            self.addSubview($0)
        }
        topView.addSubview(saveBtn)
        [originalTitBackgroundView,emailLbl,email,nameLbl,nameTextField,nameDuplicateCheckBtn,nameTextFieldLineView,passwordTextField,passwordTextFieldLineView,passwordLbl].forEach {
            originalInfoView.addSubview($0)
        }
        [detailTitBackgroundView,genderLbl,womanBtn,manBtn,subGenderLbl].forEach {
            detailInfoView.addSubview($0)
        }
        detailTitBackgroundView.addSubview(detailTit)
        originalTitBackgroundView.addSubview(originalTit)
    }
    func setLayout(){
        topView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(screenBounds2.width/4)
        }
        saveBtn.snp.makeConstraints {
            $0.centerY.equalTo(topView.tit.snp.centerY)
            $0.right.equalToSuperview().offset(-margin2)
        }
        originalInfoView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        originalTitBackgroundView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(margin2)
            $0.left.right.equalToSuperview()
            $0.size.height.equalTo(42)
        }
        originalTit.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(margin2)
        }
        emailLbl.snp.makeConstraints {
            $0.left.equalToSuperview().offset(margin2)
            $0.top.equalTo(originalTitBackgroundView.snp.bottom).offset(margin2)
        }
        email.snp.makeConstraints {
            $0.left.equalToSuperview().offset(screenBounds2.width/4)
            $0.centerY.equalTo(emailLbl)
        }
        nameLbl.snp.makeConstraints {
            $0.left.equalTo(emailLbl)
            $0.top.equalTo(email.snp.bottom).offset(margin2)
        }
        nameTextFieldLineView.snp.makeConstraints {
            $0.left.equalTo(email)
            $0.right.equalToSuperview().offset(-margin2 * 2)
            $0.bottom.equalTo(nameLbl).offset(5)
            $0.size.height.equalTo(2)
        }
        nameTextField.snp.makeConstraints {
            $0.left.equalTo(nameTextFieldLineView)
            $0.centerY.equalTo(nameLbl)
        }
        nameDuplicateCheckBtn.snp.makeConstraints {
            $0.right.equalTo(nameTextFieldLineView)
            $0.bottom.equalTo(nameTextFieldLineView.snp.top).offset(-2)
            $0.width.equalTo(50)
        }
        passwordLbl.snp.makeConstraints {
            $0.left.equalTo(emailLbl)
            $0.centerY.equalTo(passwordTextField)
        }
        passwordTextField.snp.makeConstraints {
            $0.left.equalTo(email)
            $0.top.equalTo(nameTextFieldLineView.snp.bottom).offset(margin2)
            $0.right.equalTo(passwordTextFieldLineView)
        }
        passwordTextFieldLineView.snp.makeConstraints {
            $0.left.equalTo(email)
            $0.right.equalToSuperview().offset(-margin2 * 2)
            $0.bottom.equalTo(passwordLbl).offset(5)
            $0.size.height.equalTo(2)
            $0.bottom.equalToSuperview().offset(-margin2 * 2)
        }
        detailInfoView.snp.makeConstraints {
            $0.top.equalTo(originalInfoView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
        detailTitBackgroundView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.size.height.equalTo(42)
        }
        detailTit.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(margin2)
        }
        genderLbl.snp.makeConstraints {
            $0.top.equalTo(detailTitBackgroundView.snp.bottom).offset(margin2)
            $0.left.equalToSuperview().offset(margin2)
        }
        let btnSize = CGSize(width: 40, height: 20)
        womanBtn.snp.makeConstraints {
            $0.left.equalTo(email)
            $0.centerY.equalTo(genderLbl)
            $0.size.equalTo(btnSize)
        }
        manBtn.snp.makeConstraints {
            $0.left.equalTo(womanBtn.snp.right).offset(2)
            $0.centerY.equalTo(genderLbl)
            $0.size.equalTo(btnSize)
        }
        subGenderLbl.snp.makeConstraints {
            $0.top.equalTo(manBtn.snp.bottom).offset(2)
            $0.left.equalTo(email)
        }
        
    }
}
