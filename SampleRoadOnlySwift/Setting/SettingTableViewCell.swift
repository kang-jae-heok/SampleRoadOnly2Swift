//
//  settingTableViewCell.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/11/17.
//

import UIKit
import Foundation

class SettingTableViewCell: UITableViewCell {
    static let cellId = "settingSampleTableViewCellId"
    lazy var tit = UILabel().then {
        $0.textColor = common2.setColor(hex: "#b1b1b1")
        $0.font = common2.setFont(font: "bold" , size: 13)
    }
    let arrowImgView = UIImageView().then {
        $0.image = UIImage(named: "arrow_btn")
        $0.contentMode = .center
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviewFunc()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addSubviewFunc(){
        [tit,arrowImgView].forEach {
            self.addSubview($0)
        }
    }
    func setLayout(){
        tit.snp.makeConstraints {
            $0.left.equalToSuperview().offset(margin2)
            $0.centerY.equalToSuperview()
        }
        arrowImgView.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-margin2)
            $0.centerY.equalToSuperview()
        }
    }
}
