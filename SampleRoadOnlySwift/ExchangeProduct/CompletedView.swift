//
//  CompletedExchangeView.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/11/22.
//

import Foundation
class CompletedView: UIView {
    let completedModel = CompletedModel()
    let topView = SimpleTopView().then {
        $0.tit.text = "반품 신청 완료"
    }
    lazy var contentView = UIView()
    lazy var homeBtn = UIButton().then {
        $0.backgroundColor = common2.pointColor()
        $0.setTitle("홈 가기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = common2.setFont(font: "bold", size: 18)
    }
    let checkImgView = UIImageView().then {
        $0.image = UIImage(named: "")
    }
    lazy var tit = UILabel().then {
        $0.text = completedModel.returnTit
        $0.font = common2.setFont(font: "bold", size: 16)
        $0.textColor = common2.setColor(hex: "#b1b1b1")
        $0.textAlignment = .center
    }
    lazy var subTit = UILabel().then {
        $0.text = completedModel.returnSubTit
        $0.font = common2.setFont(font: "regular", size: 13)
        $0.textColor = common2.setColor(hex: "#b1b1b1")
        $0.numberOfLines = 0
        $0.textAlignment = .center
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
        [topView,contentView,homeBtn].forEach {
            self.addSubview($0)
        }
        [checkImgView,tit,subTit].forEach {
            contentView.addSubview($0)
        }
    }
    func setLayout(){
        topView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(screenBounds2.width/4)
        }
        homeBtn.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(80)
        }
        contentView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(topView.snp.bottom)
            $0.bottom.equalTo(homeBtn.snp.top)
        }
        subTit.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        tit.snp.makeConstraints {
            $0.bottom.equalTo(subTit.snp.top).offset(-margin2)
            $0.left.right.equalToSuperview()
        }
        checkImgView.snp.makeConstraints {
            $0.bottom.equalTo(tit.snp.top).offset(-margin2)
            $0.centerX.equalToSuperview()
        }
    }
    
}
