//
//  CheckNickView.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/11/18.
//

import Foundation

class CheckNickView: UIView {
    lazy var tit = UILabel().then {
        $0.text = "정보 입력"
        $0.textColor = common2.pointColor()
        $0.font = common2.setFont(font: "bold", size: 23)
        $0.textAlignment = .center
    }
    let bottomView = LoginBottomView()
    let nickTextField = TextFieldView(frame: .zero, title: "닉네임", placeholder: "나만의 매력적인 닉네임을 정해주세요")
    lazy var checkDuplicateBtn = UIButton().then {
        $0.backgroundColor = common2.pointColor()
        $0.setTitle("중복검사", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = common2.setFont(font:"bold", size: 13)
        $0.layer.cornerRadius = 9
    }
    lazy var submitBtn = UIButton().then {
        $0.setTitle("닉네임 설정", for: .normal)
        $0.backgroundColor = common2.pointColor()
        $0.titleLabel!.font = common2.setFont(font: "bold", size: 18)
        $0.layer.cornerRadius = 8
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        addSubviewFunc()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init-fail")
    }
    func addSubviewFunc(){
        [tit,bottomView,nickTextField,submitBtn].forEach {
            self.addSubview($0)
        }
        nickTextField.addSubview(checkDuplicateBtn)
    }
    func setLayout(){
        tit.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(screenBounds2.width/4 - tit.font.pointSize)
        }
        bottomView.snp.makeConstraints{
            $0.bottom.left.right.equalToSuperview()
        }
        nickTextField.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: screenBounds2.width, height: 70))
        }
        checkDuplicateBtn.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-margin2)
            $0.centerY.equalTo(nickTextField.textField.snp.centerY)
            $0.size.equalTo(CGSize(width: 60, height: 25))
        }
        submitBtn.snp.makeConstraints {
            $0.bottom.equalTo(bottomView.titleLbl.snp.top).offset(-margin2)
            $0.left.equalToSuperview().offset(margin2)
            $0.right.equalToSuperview().offset(-margin2)
            $0.height.equalTo(screenBounds2.width/6)
        }
    }
   
}

