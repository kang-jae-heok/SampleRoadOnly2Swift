//
//  SimpleTopView.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/11/04.
//

import Foundation
class SimpleTopView: UIView {
    let common = CommonS()
    let backBtn = UIButton().then{
        $0.setImage(UIImage(named: "back_btn"), for: .normal)
    }
    lazy var tit = UILabel().then{
        $0.textColor = common.pointColor()
        $0.font = common.setFont(font: "bold", size: 20)
        $0.textAlignment = .center
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviewFunc()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("initFail")
    }
    func addSubviewFunc(){
        [backBtn,tit].forEach{
            self.addSubview($0)
        }
    }
    func setLayout(){
        backBtn.snp.makeConstraints{
            $0.left.equalToSuperview().offset(margin2)
            $0.bottom.equalToSuperview()
        }
        tit.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(backBtn)
        }
    }
}
