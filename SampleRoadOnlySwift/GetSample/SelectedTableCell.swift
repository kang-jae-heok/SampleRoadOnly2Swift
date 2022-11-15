//
//  SelectedTableCell.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/10/18.
//

import Foundation
import UIKit
class SelectedTableCell: UITableViewCell{
    let common = CommonS()
    let margin = 17.0
    let screenBounds = UIScreen.main.bounds
    lazy var typeTitView = UIView().then {
        $0.backgroundColor = common.pointColor()
    }
    lazy var typeTit = UILabel().then{
        $0.textColor = .white
        $0.font = common.setFont(font: "bold", size: 15)
    }
    lazy var grayBackgroundView = UIView().then{
        $0.backgroundColor = common.lightGray()
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 9
    }
    let sampleImgView = UIImageView()
    lazy var companyLbl = UILabel().then{
        $0.textAlignment = .center
        $0.font = common.setFont(font: "regular", size: 10)
    }
    lazy var sampleName = UILabel().then{
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 2
        $0.textAlignment = .center
        
        $0.font = common.setFont(font: "regular", size: 13)
    }
    lazy var hashtagLbl = UILabel().then{
        $0.textColor = common.pointColor()
        $0.font = common.setFont(font: "bold", size: 15)
        $0.numberOfLines = 0
    }
    let sampleInfoView = UIView()
    static let identifier = "Cell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviewFunc()
        setLayout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func addSubviewFunc(){
        [typeTitView, grayBackgroundView].forEach{
            self.addSubview($0)
        }
        typeTitView.addSubview(typeTit)
        [hashtagLbl,sampleImgView,sampleInfoView].forEach{
            grayBackgroundView.addSubview($0)
        }
        [companyLbl,sampleName].forEach{
            sampleInfoView.addSubview($0)
        }
    }
    func setLayout(){
        typeTitView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(42)
        }
        typeTit.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview()
            $0.left.equalToSuperview().offset(margin)
        }
        grayBackgroundView.snp.makeConstraints{
            $0.left.equalToSuperview().offset(margin)
            $0.right.equalToSuperview().offset(-margin)
            $0.top.equalTo(typeTit.snp.bottom).offset(30)
            $0.bottom.equalToSuperview().offset(-30)
        }
        sampleImgView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(5)
            $0.left.equalToSuperview().offset(margin)
//            $0.bottom.equalTo(self.snp.centerY)
            $0.width.equalTo(50 + margin)
            $0.height.equalTo(80)
        }
        sampleInfoView.snp.makeConstraints{
            $0.top.equalTo(sampleImgView.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.left.equalToSuperview().offset(margin)
            $0.width.equalTo(50 + margin)
        }
        companyLbl.snp.makeConstraints{
            $0.centerX.equalTo(sampleImgView)
            $0.top.equalToSuperview()
        }
        sampleName.snp.makeConstraints{
            $0.centerX.equalTo(sampleImgView)
            $0.top.equalTo(companyLbl.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().offset(-5)
            $0.width.equalTo(sampleInfoView)
        }
        hashtagLbl.snp.makeConstraints{
            $0.left.equalTo(sampleImgView.snp.right).offset(margin * 2)
            $0.top.bottom.equalToSuperview()
            $0.right.equalToSuperview()
        }
    }
    
}
