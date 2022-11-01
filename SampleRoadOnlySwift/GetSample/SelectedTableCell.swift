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
    lazy var typeTit = UILabel().then{
        $0.backgroundColor = common.pointColor()
        $0.text = "테스트중입니다"
        $0.textColor = .white
        $0.font = common.setFont(font: "bold", size: 15)
    }
    lazy var grayBackgroundView = UIView().then{
        $0.backgroundColor = common.lightGray()
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
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
        $0.font = common.setFont(font: "regular", size: 15)
    }
    lazy var hashtagLbl = UILabel().then{
        $0.textColor = common.pointColor()
        $0.font = common.setFont(font: "bold", size: 15)
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
        [typeTit, grayBackgroundView].forEach{
            self.addSubview($0)
        }
        [sampleInfoView,sampleImgView,hashtagLbl].forEach{
            grayBackgroundView.addSubview($0)
        }
        [companyLbl,sampleName].forEach{
            sampleInfoView.addSubview($0)
        }
    }
    func setLayout(){
        typeTit.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(self.snp.top).offset(50)
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
            $0.bottom.equalTo(self.snp.centerY)
            $0.right.equalTo(grayBackgroundView.snp.left).offset(margin + 50)
        }
        sampleInfoView.snp.makeConstraints{
            $0.top.equalTo(sampleImgView.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.left.equalToSuperview().offset(margin)
            $0.right.equalTo(grayBackgroundView.snp.left).offset(margin * 2 + 50)
        }
        companyLbl.snp.makeConstraints{
            $0.top.equalTo(sampleImgView.snp.bottom).offset(margin)
            $0.centerX.equalTo(sampleImgView.snp.centerX)
        }
        companyLbl.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(sampleInfoView.snp.centerY)
        }
        sampleName.snp.makeConstraints{
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.top.equalTo(sampleInfoView.snp.centerY)
        }
        hashtagLbl.snp.makeConstraints{
            $0.left.equalTo(sampleImgView.snp.right).offset(margin * 2)
            $0.top.bottom.equalToSuperview()
            $0.right.equalTo(sampleImgView.snp.right).offset(margin * 2 + 100)
        }
    }
    
}
