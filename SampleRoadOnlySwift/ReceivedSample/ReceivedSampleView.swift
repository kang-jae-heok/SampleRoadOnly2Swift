//
//  receivedSampleView.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/11/04.
//

import Foundation

class ReceivedSampleView: UIView {
   
    let common = CommonS()
    let screenBounds = UIScreen.main.bounds
    
    let topView = SimpleTopView().then {
        $0.tit.text = "받아본 샘플"
    }
    lazy var countLbl = UILabel().then{
        $0.textColor = common.pointColor()
        $0.font = common.setFont(font: "bold", size: 15)
        $0.asColor(targetStringList: ["총","개"], color: common.setColor(hex: "#b1b1b1"))
    }
    lazy var topLineView = UIView().then{
        $0.backgroundColor = common.gray()
    }
    let receivedSampleTableView = UITableView()
    let noneSampleView = NoneView().then{
        $0.tit.text = "받아본 샘플이 없습니다"
        $0.isHidden = true
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
       
        addSubviewFunc()
        setLayout()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("initFail")
    }
    func addSubviewFunc(){
        [topView,countLbl,topLineView,receivedSampleTableView,noneSampleView].forEach{
            self.addSubview($0)
        }
    }
    func setLayout(){
        topView.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.size.height.equalTo(screenBounds.width/4)
        }
        countLbl.snp.makeConstraints{
            $0.top.equalTo(topView.snp.bottom).offset(margin2)
            $0.left.equalToSuperview().offset(margin2)
        }
        topLineView.snp.makeConstraints{
            $0.top.equalTo(countLbl.snp.bottom).offset(margin2)
            $0.left.right.equalToSuperview()
            $0.size.height.equalTo(2)
        }
        receivedSampleTableView.snp.makeConstraints{
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(topLineView.snp.bottom)
        }
        noneSampleView.snp.makeConstraints {
            $0.edges.equalTo(receivedSampleTableView)
        }
        
    }
}

