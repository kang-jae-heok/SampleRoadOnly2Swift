//
//  MainView.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/09/22.
//

import Foundation
import UIKit
class MainViewS: UIView{
    let margin = 60.0
    let screenBounds = UIScreen.main.bounds
    let common = CommonS()
    lazy var  bottomY =  screenBounds.height - (screenBounds.width/6 + screenBounds.height/2 + 30 + 20)
    let vc = IntroViewController()
    lazy var startBtn = UIButton().then{
        $0.setTitle("시작하기", for: .normal)
        $0.titleLabel?.textColor = .white
        $0.backgroundColor = common.pointColor()
        $0.titleLabel!.font = common.setFont(font: "bold", size: 18)
        $0.layer.cornerRadius = 8
    }
    lazy var joinEmail = UIButton().then{
        $0.setTitle("이메일로 가입하기", for: .normal)
        $0.titleLabel!.font = common.setFont(font: "bold", size: 18)
        $0.setTitleColor(common.pointColor(), for: .normal)
    }
    let logoImgView = UIImageView().then{
        $0.image = UIImage(named: "logo_intro_btn")
    }
    let backgroundImg = UIImageView().then{
        $0.image = UIImage(named: "bg_intro_btn")

    }
    lazy var kakaoBtn = UIButton().then{
        $0.backgroundColor = common.setColor(hex: "#fae300")
        $0.setImage(UIImage(named: "login_kakao_btn"), for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        if !UserDefaults.standard.bool(forKey: "PRDC_MODE"){
            $0.isHidden = false
        }else{
            $0.isHidden = false
        }
    }
    lazy var naverBtn = UIButton().then{
        $0.setImage(UIImage(named: "login_naver_btn"), for: .normal)
        $0.backgroundColor = common.setColor(hex: "#06be34")
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        if !UserDefaults.standard.bool(forKey: "PRDC_MODE"){
            $0.isHidden = false
        }else{
            $0.isHidden = false
        }
    }
    lazy var copyRight = UILabel().then{
        $0.text = "ⓒTov&Banah"
        $0.font = common.setFont(font: "light", size: 10)
        $0.textColor = .black
    }



    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubviewFunc()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addSubviewFunc(){
        [backgroundImg,startBtn,logoImgView,kakaoBtn,naverBtn,copyRight,joinEmail].forEach{
            self.addSubview($0)
        }
    }
    func setLayout(){
        startBtn.snp.makeConstraints{
            $0.top.equalTo(self.snp.centerY).offset(30)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: screenBounds.width - margin * 2, height: screenBounds.width/6))
        }
        joinEmail.snp.makeConstraints{
            $0.top.equalTo(startBtn.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        kakaoBtn.snp.makeConstraints{
            $0.centerY.equalTo(self.snp.bottom).offset(-20 - bottomY/2)
            $0.right.equalTo(self.snp.centerX).offset(-3)
            $0.size.equalTo(CGSize(width: 100, height: 50))
        }
        naverBtn.snp.makeConstraints{
            $0.centerY.equalTo(self.snp.bottom).offset(-20 - bottomY/2)
            $0.left.equalTo(self.snp.centerX).offset(3)
            $0.size.equalTo(CGSize(width: 100, height: 50))
        }
        backgroundImg.snp.makeConstraints{
            $0.bottom.equalTo(joinEmail.snp.top).offset(-20)
            $0.left.right.equalToSuperview()
        }
        logoImgView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(startBtn.snp.top).offset(-30)
        }

    }




}
