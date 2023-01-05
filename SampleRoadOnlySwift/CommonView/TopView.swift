//
//  TopView.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/10/12.
//

import Foundation
import Then
class TopView: UIView {
    let screenbounds = UIScreen.main.bounds
    let margin = 17
    lazy var searchTextHeight = (screenbounds.size.width/5 * 3) * (1/7.5)
    let common = CommonS()
    let mainIconBtn = UIButton().then{
        $0.setImage(UIImage(named: "logo_top_btn"), for: .normal)
    }
    lazy var searchTextField = UITextField().then{
        let attributes = [
            NSAttributedString.Key.foregroundColor: common.lightGray().withAlphaComponent(50),
            NSAttributedString.Key.font : common.setFont(font: "medium", size: 14)
        ]
        $0.placeholder = " 진저민트 원포올 에센스 120ml"
        $0.attributedPlaceholder = NSAttributedString(string: "진저민트 원포올 에센스 120ml", attributes:attributes)
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = common.lightGray().cgColor
        $0.addLeftPadding()
    }
    lazy var topLbl = UILabel().then{
        $0.font = common.setFont(font: "bold", size: 23)
        $0.textColor = common.pointColor()
        $0.isHidden = true
        $0.textAlignment = .center
    }
    let searchBtn = UIButton().then{
        $0.setImage(UIImage(named: "search_btn"), for: .normal)
    }
    let alarmBtn = UIButton().then{
        $0.setImage(UIImage(named: "bell2_btn"), for: .normal)
        $0.isHidden = true
    }
    let cartBtn = UIButton().then{
        $0.setImage(UIImage(named: "cart_btn"), for: .normal)
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
        [mainIconBtn,searchTextField,cartBtn,topLbl,alarmBtn].forEach{
            self.addSubview($0)
        }
        searchTextField.addSubview(searchBtn)
    }
    func setLayout(){
        mainIconBtn.snp.makeConstraints{
            $0.bottom.equalToSuperview()
            $0.left.equalToSuperview().offset(margin)
            $0.size.equalTo(CGSize(width: 36, height: 36))
        }
        cartBtn.snp.makeConstraints{
            $0.centerY.equalTo(mainIconBtn)
            $0.right.equalToSuperview().offset(-margin)
            $0.size.equalTo(CGSize(width: 26, height: 26))
        }
        searchTextField.snp.makeConstraints{
            $0.bottom.equalToSuperview()
            $0.left.equalTo(mainIconBtn.snp.right).offset(margin)
            $0.right.equalTo(cartBtn.snp.left).offset(-margin/2)
            $0.top.equalTo(super.snp.bottom).offset(-36)
//            $0.size.height.equalTo(searchTextHeight)
        }
        topLbl.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(searchTextField)
        }
        alarmBtn.snp.makeConstraints{
            $0.centerY.equalTo(mainIconBtn)
            $0.right.equalTo(cartBtn.snp.left).offset(-5)
            $0.size.equalTo(CGSize(width: 26, height: 26))
        }
        searchBtn.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-margin/2)
        }
    }

}
