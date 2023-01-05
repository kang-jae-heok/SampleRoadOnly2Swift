//
//  BannerCollectionCell.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/10/20.
//

import Foundation
class BannerCollectionCell: UICollectionViewCell {
    let common = CommonS()
    let margin = 17.0
    let screenBounds = UIScreen.main.bounds
    let bannerImgView = UIImageView().then{
        $0.backgroundColor = .white
        $0.contentMode = .scaleAspectFit
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubviewFunc()
        setLayout()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addSubviewFunc(){
        [bannerImgView].forEach{
            self.addSubview($0)
        }
      
    }
    func setLayout(){
        bannerImgView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.size.equalToSuperview()
        }
    }

}
