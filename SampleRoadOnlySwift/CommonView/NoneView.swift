//
//  noneView.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/12/23.
//

import Foundation
class NoneView: UIView {
    let common = CommonS()
    let screenBounds = UIScreen.main.bounds
    
    lazy var tit = UILabel().then{
        $0.text = "데이터가 없습니다"
        $0.textColor = common2.setColor(hex: "#b1b1b1")
        $0.font = common2.setFont(font: "bold", size: 16)
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
        [tit].forEach{
            self.addSubview($0)
        }
    }
    func setLayout(){
        tit.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
