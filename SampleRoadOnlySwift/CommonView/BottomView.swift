//
//  BottomView.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/10/12.
//

import Foundation
import Then
class BottomView: UIView{
    let screenbounds = UIScreen.main.bounds
    let margin = 17
    let common = CommonS()
    lazy var background = UIView().then{
        $0.backgroundColor = common.setColor(hex: "cecece")
    }
    let homeMenuBtn = UIButton()
    let homeMenuImgView = UIImageView().then{
        $0.image = UIImage(named: "home_btn")
    }
    lazy var homeMenuLbl = UILabel().then{
        $0.text = "홈"
        $0.textColor = common.lightGray()
        $0.font = common.setFont(font: "bold", size: 9)
    }
    let rankMenuBtn = UIButton()
    let rankMenuImgView = UIImageView().then{
        $0.image = UIImage(named: "rank_btn")
    }
    lazy var rankMenuLbl = UILabel().then{
        $0.text = "랭킹"
        $0.textColor = common.lightGray()
        $0.font = common.setFont(font: "bold", size: 9)
    }
    let reviewMenuBtn = UIButton()
    let reviewMenuImgView = UIImageView().then{
        $0.image = UIImage(named: "review_btn")
    }
    lazy var reviewMenuLbl = UILabel().then{
        $0.text = "리뷰"
        $0.textColor = common.lightGray()
        $0.font = common.setFont(font: "bold", size: 9)
    }
    let myMenuBtn = UIButton()
    let myMenuImgView = UIImageView().then{
        $0.image = UIImage(named: "my_btn")
    }
    lazy var myMenuLbl = UILabel().then{
        $0.text = "마이"
        $0.textColor = common.lightGray()
        $0.font = common.setFont(font: "bold", size: 9)
    }
    lazy var sampleBtn = UIButton().then{
        $0.backgroundColor = common.pointColor()
    }
    let plusImgView = UIImageView().then{
        $0.image = UIImage(named: "plus_btn")
    }
    lazy var sampleLbl = UILabel().then{
        $0.text = "샘플받기"
        $0.textColor = common.setColor(hex: "#ffffff")
        $0.font = common.setFont(font: "bold", size: 9)
    }
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviewFunc()
        setLayout()
       
    }
    required init(coder: NSCoder) {
        fatalError("init fail")
    }
    func addSubviewFunc(){
        [background,sampleBtn].forEach{
            self.addSubview($0)
        }
        [homeMenuBtn,rankMenuBtn,reviewMenuBtn,myMenuBtn].forEach{
            background.addSubview($0)
        }
        [homeMenuLbl,homeMenuImgView].forEach{
            homeMenuBtn.addSubview($0)
        }
        [rankMenuLbl,rankMenuImgView].forEach{
            rankMenuBtn.addSubview($0)
        }
        [reviewMenuLbl,reviewMenuImgView].forEach{
            reviewMenuBtn.addSubview($0)
        }
        [myMenuLbl,myMenuImgView].forEach{
            myMenuBtn.addSubview($0)
        }
        [sampleLbl,plusImgView].forEach{
            sampleBtn.addSubview($0)
        }
        
    }
    func setLayout(){
        let btnSize = CGSize(width: screenbounds.width/5, height: 90)
        background.snp.makeConstraints{
            $0.bottom.left.right.equalToSuperview()
            $0.size.height.equalTo(90)
        }
        sampleBtn.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(homeMenuLbl.snp.bottom)
            $0.size.equalTo(CGSize(width: screenbounds.width/5, height: screenbounds.width/5))
        }
        homeMenuBtn.snp.makeConstraints{
            $0.left.right.top.equalToSuperview()
            $0.size.equalTo(btnSize)
        }
        rankMenuBtn.snp.makeConstraints{
            $0.left.equalTo(homeMenuBtn.snp.right)
            $0.top.bottom.equalToSuperview()
            $0.size.equalTo(btnSize)
        }
        myMenuBtn.snp.makeConstraints{
            $0.right.top.bottom.equalToSuperview()
            $0.left.equalToSuperview().offset(-btnSize.width)
            $0.size.equalTo(btnSize)
        }
        reviewMenuBtn.snp.makeConstraints{
            $0.right.equalTo(myMenuBtn.snp.left)
            $0.top.bottom.equalToSuperview()
            $0.size.equalTo(btnSize)
        }
        [homeMenuLbl,reviewMenuLbl,rankMenuLbl,myMenuLbl,sampleLbl].forEach{
            $0.snp.makeConstraints{
                $0.centerX.equalToSuperview()
                $0.top.equalTo(super.snp.centerY).offset(5)
            }
        }
        [homeMenuImgView,reviewMenuImgView,rankMenuImgView,myMenuImgView,plusImgView].forEach{
            $0.snp.makeConstraints{
                $0.centerX.equalToSuperview()
                $0.bottom.equalTo(super.snp.centerY).offset(-5)
            }
        }
    }
}
