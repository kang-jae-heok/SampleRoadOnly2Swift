//
//  ReceivedSampleTableViewCell.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/11/04.
//

import Foundation
import UIKit

class LikeProductTableViewCell: UITableViewCell {
    static let cellId = "LikeProductTableViewCellId"
    let common = CommonS()
    let screenBounds = UIScreen.main.bounds
    let productImgView = UIImageView().then{
        $0.backgroundColor = .clear
    }
    lazy var companyNameLbl = UILabel().then{
        $0.font = common.setFont(font: "regular", size: 10)
    }
    lazy var productNameLbl = UILabel().then{
        $0.font = common.setFont(font: "bold", size: 12)
    }
    let rateImgView = UIImageView().then{
        $0.image = UIImage(named: "rate_btn")
    }
    lazy var ratingLbl = UILabel().then{
        $0.font = common.setFont(font: "bold", size: 10)
    }
    let deleteBtn = UIButton().then{
        $0.setImage(UIImage(named: "x_btn"), for: .normal)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
        addSubviewFunc()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("initFail")
    }
    func addSubviewFunc(){
        [productImgView,productNameLbl,companyNameLbl,rateImgView,ratingLbl,deleteBtn].forEach{
            self.addSubview($0)
        }
    }
    func setLayout(){
        productImgView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(margin2)
            $0.size.equalTo(CGSize(width: margin2 * 3, height: 70))
        }
        companyNameLbl.snp.makeConstraints{
            $0.left.equalTo(productImgView.snp.right).offset(6)
            $0.bottom.equalTo(productNameLbl.snp.top).offset(-6)
        }
        productNameLbl.snp.makeConstraints{
            $0.left.equalTo(companyNameLbl)
            $0.centerY.equalToSuperview()
        }
        rateImgView.snp.makeConstraints{
            $0.left.equalTo(companyNameLbl)
            $0.centerY.equalTo(ratingLbl)
            $0.size.equalTo(CGSize(width: 15, height: 15))
        }
        ratingLbl.snp.makeConstraints{
            $0.left.equalTo(rateImgView.snp.right).offset(5)
            $0.top.equalTo(productNameLbl.snp.bottom).offset(6)
        }
        deleteBtn.snp.makeConstraints{
            $0.top.equalTo(productImgView)
            $0.right.equalToSuperview().offset(-margin2)
        }
    }
}

