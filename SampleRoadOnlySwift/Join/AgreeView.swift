//
//  JoinEmailView.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/09/29.
//

import Foundation
import UIKit

class AgreeView : UIView {
    let common = CommonS()
    let margin = 30.0
    let screenBounds = UIScreen.main.bounds
    let bottomView = LoginBottomView()
    let topView = LoginTopView()
    lazy var title = UILabel().then{
        $0.text = "약관 동의가 필요합니다"
        $0.textColor = common.pointColor()
        $0.font = common.setFont(font: "bold", size: 20)
    }
    lazy var allCheckBtn = UIButton().then{
        $0.layer.borderWidth = 2
        $0.layer.borderColor = common.gray().cgColor
        $0.addTarget(self, action: #selector(touchAllCheckBtn(sender:)), for: .touchUpInside)
    }
    lazy var allCheckLbl = UILabel().then{
        $0.text = "전체 동의"
        $0.font = common.setFont(font: "bold", size: 16)
        $0.textColor = common.gray()
    }
    lazy var firstCheckBtn = UIButton().then{
        $0.layer.borderWidth = 2
        $0.layer.borderColor = common.gray().cgColor
        $0.addTarget(self, action: #selector(touchCheckBtn(sender:)), for: .touchUpInside)
    }
    lazy var secondCheckBtn = UIButton().then{
        $0.layer.borderWidth = 2
        $0.layer.borderColor = common.gray().cgColor
        $0.addTarget(self, action: #selector(touchCheckBtn(sender:)), for: .touchUpInside)
    }
    lazy var thirdCheckBtn = UIButton().then{
        $0.layer.borderWidth = 2
        $0.layer.borderColor = common.gray().cgColor
        $0.addTarget(self, action: #selector(touchCheckBtn(sender:)), for: .touchUpInside)
    }
    lazy var fourthCheckBtn = UIButton().then{
        $0.layer.borderWidth = 2
        $0.layer.borderColor = common.gray().cgColor
        $0.addTarget(self, action: #selector(touchCheckBtn(sender:)), for: .touchUpInside)
    }
    lazy var firstCheckLbl = UILabel().then{
        $0.text = "[필수] 만 14세 이상입니다"
        $0.font = common.setFont(font: "medium", size: 16)
        $0.textColor = common.gray()
    }
    lazy var secondCheckLbl = UILabel().then{
        $0.text = "[필수] 이용약관 동의"
        $0.font = common.setFont(font: "medium", size: 16)
        $0.textColor = common.gray()
    }
    lazy var thirdCheckLbl = UILabel().then{
        $0.text = "[필수] 개인정보 수집 및 이용 동의"
        $0.font = common.setFont(font: "medium", size: 16)
        $0.textColor = common.gray()
    }
    lazy var fourthCheckLbl = UILabel().then{
        $0.text = "[선택] 선택적 수집 항목 동의"
        $0.font = common.setFont(font: "medium", size: 16)
        $0.textColor = common.gray()
    }

    lazy var secondRead = UIButton().then{
        $0.setTitle("보기", for: .normal)
        $0.setTitleColor(common.gray(), for: .normal)
        $0.titleLabel!.font = common.setFont(font: "medium", size: 16)
        $0.tag = 1
    }
    lazy var thirdRead = UIButton().then{
        $0.setTitle("보기", for: .normal)
        $0.setTitleColor(common.gray(), for: .normal)
        $0.titleLabel!.font = common.setFont(font: "medium", size: 16)
        $0.tag = 2
    }
    lazy var fourthRead = UIButton().then{
        $0.setTitle("보기", for: .normal)
        $0.setTitleColor(common.gray(), for: .normal)
        $0.titleLabel!.font = common.setFont(font: "medium", size: 16)
        $0.tag = 3
    }
    lazy var nextBtn = UIButton().then{
        $0.setTitle("다음", for: .normal)
        $0.backgroundColor = common.gray()
        $0.titleLabel!.font = common.setFont(font: "bold", size: 18)
        $0.layer.cornerRadius = 8
    }




    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubviewFunc()
        setLayout()
    }

    required init(coder: NSCoder) {
        fatalError("init fail")
    }

    func setLayout(){
        topView.titleLbl.text = "이메일 가입하기"
        bottomView.snp.makeConstraints{
            $0.bottom.left.right.equalToSuperview()
        }
        topView.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(self.snp.top).offset(screenBounds.width/4)
        }
        nextBtn.snp.makeConstraints{
            $0.bottom.equalTo(bottomView.titleLbl.snp.top).offset(-20)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: screenBounds.width - margin * 2, height: screenBounds.width/6))
        }
        fourthRead.snp.makeConstraints{
            $0.right.equalToSuperview().offset(-margin)
            $0.bottom.equalToSuperview().offset(-screenBounds.height/2 - 30)
        }
        fourthCheckBtn.snp.makeConstraints{
            $0.left.equalToSuperview().offset(margin)
            $0.centerY.equalTo(fourthRead)
            $0.size.equalTo(CGSize(width: 12, height: 12))
        }
        fourthCheckLbl.snp.makeConstraints{
            $0.left.equalTo(fourthCheckBtn.snp.right).offset(12)
            $0.centerY.equalTo(fourthRead.snp.centerY)
        }
        thirdCheckBtn.snp.makeConstraints{
            $0.centerX.equalTo(fourthCheckBtn)
            $0.bottom.equalTo(fourthCheckBtn.snp.top).offset(-20)
            $0.size.equalTo(CGSize(width: 12, height: 12))
        }
        thirdCheckLbl.snp.makeConstraints{
            $0.left.equalTo(fourthCheckBtn.snp.right).offset(12)
            $0.centerY.equalTo(thirdCheckBtn)
        }
        thirdRead.snp.makeConstraints{
            $0.centerX.equalTo(fourthRead)
            $0.centerY.equalTo(thirdCheckLbl)
        }
        secondCheckBtn.snp.makeConstraints{
            $0.centerX.equalTo(thirdCheckBtn)
            $0.bottom.equalTo(thirdCheckBtn.snp.top).offset(-20)
            $0.size.equalTo(CGSize(width: 12, height: 12))
        }
        secondCheckLbl.snp.makeConstraints{
            $0.left.equalTo(fourthCheckBtn.snp.right).offset(12)
            $0.centerY.equalTo(secondCheckBtn)
        }
        secondRead.snp.makeConstraints{
            $0.centerX.equalTo(thirdRead)
            $0.centerY.equalTo(secondCheckLbl)
        }
        firstCheckBtn.snp.makeConstraints{
            $0.centerX.equalTo(secondCheckBtn)
            $0.bottom.equalTo(secondCheckBtn.snp.top).offset(-20)
            $0.size.equalTo(CGSize(width: 12, height: 12))
        }
        firstCheckLbl.snp.makeConstraints{
            $0.left.equalTo(fourthCheckBtn.snp.right).offset(12)
            $0.centerY.equalTo(firstCheckBtn)
        }
        let betweenY = screenBounds.height/2 - screenBounds.width/4 - (firstCheckLbl.font.pointSize * 4) - 90
        allCheckBtn.snp.makeConstraints{
            $0.centerX.equalTo(fourthCheckBtn)
            $0.centerY.equalTo(firstCheckLbl.snp.top).offset(-(betweenY/3))
            $0.size.equalTo(CGSize(width: 12, height: 12))
        }
        allCheckLbl.snp.makeConstraints{
            $0.left.equalTo(firstCheckLbl.snp.left)
            $0.centerY.equalTo(allCheckBtn)
        }
        title.snp.makeConstraints{
            $0.centerY.equalTo(allCheckLbl.snp.centerY).offset(-(betweenY/3))
            $0.left.equalToSuperview().offset(margin)
        }


    }
    func addSubviewFunc(){
        [bottomView,topView,title,allCheckBtn,allCheckLbl,firstCheckBtn,firstCheckLbl,secondRead,secondCheckBtn,secondCheckBtn,secondCheckLbl,thirdRead,thirdCheckBtn,thirdCheckLbl,fourthRead,fourthCheckBtn,fourthCheckLbl].forEach{
            self.addSubview($0)
        }
        bottomView.addSubview(nextBtn)
    }
    @objc func touchAllCheckBtn(sender: UIButton){
        if sender.backgroundColor == common.pointColor(){
            [sender,firstCheckBtn,secondCheckBtn,thirdCheckBtn,fourthCheckBtn].forEach{
                $0.backgroundColor = .clear
                $0.layer.borderColor = common.gray().cgColor
            }
            [secondRead,thirdRead,fourthRead].forEach{
                $0.setTitleColor(common.gray(), for: .normal)
            }
            [allCheckLbl,firstCheckLbl,secondCheckLbl,thirdCheckLbl,fourthCheckLbl].forEach{
                $0.textColor =  common.gray()
            }
        }else{
            [sender,firstCheckBtn,secondCheckBtn,thirdCheckBtn,fourthCheckBtn].forEach{
                $0.backgroundColor = common.pointColor()
                $0.layer.borderColor = common.pointColor().cgColor
            }
            [secondRead,thirdRead,fourthRead].forEach{
                $0.setTitleColor(common.pointColor(), for: .normal)
            }
            [allCheckLbl,firstCheckLbl,secondCheckLbl,thirdCheckLbl,fourthCheckLbl].forEach{
                $0.textColor =  common.pointColor()
            }
        }
        checkAllCheck()
    }
    @objc func touchCheckBtn(sender: UIButton){
        var checkBtn = UIButton()
        var lbl = UILabel()
        var readBtn = UIButton()
        if sender == firstCheckBtn{
            checkBtn = firstCheckBtn
            lbl = firstCheckLbl
            readBtn = UIButton()

        }else if sender == secondCheckBtn{
            checkBtn = secondCheckBtn
            lbl = secondCheckLbl
            readBtn = secondRead
        }else if sender == thirdCheckBtn{
            checkBtn = thirdCheckBtn
            lbl = thirdCheckLbl
            readBtn = thirdRead
        }else if sender == fourthCheckBtn{
            checkBtn = fourthCheckBtn
            lbl = fourthCheckLbl
            readBtn = fourthRead
        }
        if checkBtn.backgroundColor == common.pointColor(){
            checkBtn.backgroundColor = .clear
            checkBtn.layer.borderColor = common.gray().cgColor
            lbl.textColor =  common.gray()
            readBtn.setTitleColor(common.gray(), for: .normal)
        }else{
            checkBtn.backgroundColor = common.pointColor()
            checkBtn.layer.borderColor = common.pointColor().cgColor
            lbl.textColor =  common.pointColor()
            readBtn.setTitleColor(common.pointColor(), for: .normal)
        }
        checkAllCheck()

    }
    func checkAllCheck(){
        var bool = true
        [firstCheckBtn,secondCheckBtn,thirdCheckBtn,fourthCheckBtn].forEach{
            if $0.backgroundColor != common.pointColor(){
                bool = false
            }
        }
        if bool {
            nextBtn.backgroundColor = common.pointColor()
            allCheckLbl.textColor = common.pointColor()
            allCheckBtn.backgroundColor = common.pointColor()
            allCheckBtn.layer.borderColor = common.pointColor().cgColor

        }else{
            nextBtn.backgroundColor = common.gray()
            allCheckLbl.textColor = common.gray()
            allCheckBtn.layer.borderColor = common.gray().cgColor
            allCheckBtn.backgroundColor = .clear
        }
    }
}

