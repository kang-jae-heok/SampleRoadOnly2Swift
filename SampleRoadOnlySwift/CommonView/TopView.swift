//
//  TopView.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/09/22.
//

import Foundation
import UIKit
class TopView: UIView{
    let common = Common()
    let screenBounds = UIScreen.main.bounds
    let homeBtn = UIButton().then{
        $0.setImage(UIImage(named: "top_home_btn"), for: .normal)
    }
    lazy var titleLbl = UILabel().then{
        $0.text = "시작하기"
        $0.textColor = common.pointColor()
        $0.font = common.setFont(font: "bold", size: 20)
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
        [homeBtn,titleLbl].forEach{
            self.addSubview($0)
        }
    }
    func setLayout(){
        homeBtn.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-20)
            $0.left.equalToSuperview().offset(30)
        }
        titleLbl.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
        }
    }

}
