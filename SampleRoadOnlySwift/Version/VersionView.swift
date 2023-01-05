//
//  VersionView.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/12/23.
//

import Foundation

class VersionView: UIView {
    let topView = SimpleTopView().then {
        $0.tit.text = "버전정보"
    }
    let bodyView = UIView()
    
    lazy var newestVersionLbl = UILabel().then {
        $0.textColor = common2.setColor(hex: "#b1b1b1")
        $0.font = common2.setFont(font: "bold", size: 16)
    }
    lazy var currentVersionLbl = UILabel().then {
        $0.textColor = common2.setColor(hex: "#b1b1b1")
        $0.font = common2.setFont(font: "bold", size: 16)
    }
    lazy var isCurrentVersionLbl = UILabel().then {
        $0.text = "최신 버전입니다 :)"
        $0.textColor = common2.setColor(hex: "#b1b1b1")
        $0.font = common2.setFont(font: "bold", size: 16)
        $0.isHidden = true
    }
    lazy var versionStackView = UIStackView(arrangedSubviews: [newestVersionLbl,currentVersionLbl,isCurrentVersionLbl]).then {
        $0.axis = .vertical
        $0.spacing = 10
        $0.alignment = .center
        $0.distribution = .equalSpacing
    }
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubviewFunc()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init-fail")
    }
    
    func addSubviewFunc(){
        [topView,bodyView].forEach {
            self.addSubview($0)
        }
        bodyView.addSubview(versionStackView)
    }
    func setLayout(){
        topView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(screenBounds2.width / 4)
        }
        bodyView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
        versionStackView.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
    }
}
