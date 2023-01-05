//
//  SampleCollectionCell.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/10/14.
//

import Foundation

class SampleCollectionCell: UICollectionViewCell {
    let common = CommonS()
    let margin = 17.0
    let screenBounds = UIScreen.main.bounds
    lazy var screenRatio2 = screenBounds.width/414.0
    let sampleImgView = UIImageView().then{
        $0.backgroundColor = .clear
    }
    lazy var detailBtn = UIButton().then{
        $0.backgroundColor = common.pointColor()
        $0.setTitle("자세히", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.titleLabel?.font = common.setFont(font: "bold", size: 15)
        $0.layer.cornerRadius = 5
    }
    var sampleInfoView = UIView()
    lazy var companyLbl = UILabel().then{
        $0.textAlignment = .center
        $0.textColor = common.setColor(hex: "#6f6f6f")
        $0.font = common.setFont(font: "regular", size: 11)
    }
    lazy var sampleName = UILabel().then{
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.textColor = common.setColor(hex: "#6f6f6f")
        $0.font = common.setFont(font: "regular", size: 13)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = common.lightGray()
        addSubviewFunc()
        setLayout()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addSubviewFunc(){
        [sampleImgView,detailBtn,sampleInfoView].forEach{
            self.addSubview($0)
        }
        [sampleName,companyLbl].forEach{
            sampleInfoView.addSubview($0)
        }
    }
    func setLayout(){
        sampleImgView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(margin)
            $0.bottom.equalTo(self.snp.centerY)
            $0.left.equalToSuperview().offset(margin)
            $0.right.equalToSuperview().offset(-margin)
        }
        detailBtn.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-margin)
            $0.size.equalTo(CGSize(width: screenBounds.width/5 , height: 30 * screenRatio2))
        }
        sampleInfoView.snp.makeConstraints{
            $0.top.equalTo(sampleImgView.snp.bottom)
            $0.bottom.equalTo(detailBtn.snp.top)
            $0.left.right.equalToSuperview()
        }
        companyLbl.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(sampleInfoView.snp.centerY)
        }
        sampleName.snp.makeConstraints{
            $0.left.equalToSuperview().offset(margin)
            $0.right.equalToSuperview().offset(-margin)
            $0.top.equalTo(sampleInfoView.snp.centerY)
        }
        
    }
}
