//
//  TopNavigationView.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/10/13.
//

import Foundation
class TopNavigationView: UIView {
    let common = CommonS()
    let screenBounds = UIScreen.main.bounds
    let margin = 17.0
    lazy var sampleBtn = UIButton().then{
        $0.setTitle("이 달의 샘플", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.titleLabel?.font = common.setFont(font: "bold", size: 15)
        $0.backgroundColor = common.pointColor()
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = common.lightGray().cgColor
        $0.addTarget(self, action: #selector(touchSampleBtn), for: .touchUpInside)
    }
    lazy var eventBtn = UIButton().then{
        $0.setTitle("이벤트", for: .normal)
        $0.setTitleColor(common.pointColor(), for: .normal)
        $0.titleLabel?.font = common.setFont(font: "bold", size: 15)
        $0.backgroundColor = UIColor.white
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = common.lightGray().cgColor
        $0.addTarget(self, action: #selector(touchEventBtn), for: .touchUpInside)
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
        [sampleBtn,eventBtn].forEach{
            self.addSubview($0)
        }
    }
    func setLayout(){
        let btnSize = CGSize(width: screenBounds.width/2 - margin, height: (screenBounds.width/2 - margin)/6)
        sampleBtn.snp.makeConstraints{
            $0.top.equalToSuperview().offset(26)
            $0.left.equalToSuperview().offset(margin)
            $0.size.equalTo(btnSize)
        }
        eventBtn.snp.makeConstraints{
            $0.top.equalToSuperview().offset(26)
            $0.right.equalToSuperview().offset(-margin)
            $0.size.equalTo(btnSize)
        }
    }
    @objc func touchSampleBtn(){
        if sampleBtn.backgroundColor != common.pointColor() {
            sampleBtn.backgroundColor = common.pointColor()
            sampleBtn.setTitleColor(UIColor.white, for: .normal)
            eventBtn.backgroundColor = .white
            eventBtn.setTitleColor(common.pointColor(), for: .normal)
        }
    }
    @objc func touchEventBtn(){
        if eventBtn.backgroundColor != common.pointColor() {
            eventBtn.backgroundColor = common.pointColor()
            eventBtn.setTitleColor(UIColor.white, for: .normal)
            sampleBtn.backgroundColor = .white
            sampleBtn.setTitleColor(common.pointColor(), for: .normal)
        }
    }
}
