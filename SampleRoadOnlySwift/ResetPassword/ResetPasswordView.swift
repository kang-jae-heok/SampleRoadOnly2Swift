//
//  ResetPassword.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/12/01.
//

import Foundation

class ResetPasswordView: UIView {
    lazy var tit = UILabel().then {
        $0.text = "비밀번호 변경"
        $0.textColor = common2.pointColor()
        $0.font = common2.setFont(font: "bold", size: 23)
        $0.textAlignment = .center
    }
    let bottomView = LoginBottomView()
    let emailTextField = TextFieldView(frame: .zero, title: "변경한 비밀번호", placeholder: "변경할 비밀번호를 입력해주세요")
    lazy var resetBtn = UIButton().then {
        $0.backgroundColor = common2.lightGray()
        $0.setTitle("변경", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = common2.setFont(font:"bold", size: 13)
        $0.layer.cornerRadius = 9
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
        [tit,bottomView,emailTextField].forEach {
            self.addSubview($0)
        }
        emailTextField.addSubview(resetBtn)
    }
    func setLayout(){
        tit.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(screenBounds2.width/4 - tit.font.pointSize)
        }
        bottomView.snp.makeConstraints{
            $0.bottom.left.right.equalToSuperview()
        }
        emailTextField.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: screenBounds2.width, height: 70))
        }
        resetBtn.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-margin2)
            $0.centerY.equalTo(emailTextField.textField.snp.centerY)
            $0.size.equalTo(CGSize(width: 60, height: 25))
        }
    }
   
}
