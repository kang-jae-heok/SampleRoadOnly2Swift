//
//  BottomView.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/09/22.
//

import Foundation
import UIKit

class BottomView: UIView{
    let common = Common()
    let screenBounds = UIScreen.main.bounds
    lazy var titleLbl = UILabel().then{
        $0.text = "FIND YOUR WAY"
        $0.textColor = common.pointColor()
        $0.font = common.setFont(font: "bold", size: 18)
    }
    lazy var copyRight = UILabel().then{
        $0.text = "ⓒTov&Banah"
        $0.font = common.setFont(font: "light", size: 10)
        $0.textColor = .black
    }
    let imgView = UIImageView().then{
        $0.image = UIImage(named: "bg_login_btn")
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
        [imgView,titleLbl,copyRight].forEach{
            self.addSubview($0)
        }
    }
    func setLayout(){

        titleLbl.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-screenBounds.width/4 + 20)
            $0.centerX.equalToSuperview()
        }
        copyRight.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-20)
            $0.centerX.equalToSuperview()
        }
        imgView.snp.makeConstraints(){
            $0.top.left.right.bottom.equalToSuperview()

        }
    }

}
