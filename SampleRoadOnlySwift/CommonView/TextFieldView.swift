//
//  textFieldView.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/09/22.
//

import Foundation
import UIKit
class TextFieldView: UIView{
    let common = CommonS()
    let a = COMController()
    var titleString = String()
    var placeholderStr = String()

    lazy var title = UILabel().then{
        $0.font = common.setFont(font: "semibold", size: 18)
        $0.text = titleString
        $0.textColor = common.pointColor()
    }
    lazy var textField = UITextField().then{
        let attributes = [
            NSAttributedString.Key.foregroundColor: common.pointColor().withAlphaComponent(50),
            NSAttributedString.Key.font : common.setFont(font: "medium", size: 18 * screenRatio)
        ]

        $0.placeholder = placeholderStr
        $0.attributedPlaceholder = NSAttributedString(string: placeholderStr, attributes:attributes)
    }
    lazy var line = UIView().then{
        $0.backgroundColor = common.setColor(hex: "#f0f0f0")
    }
    
     init(frame: CGRect, title:String, placeholder: String) {
        super.init(frame: frame)
        self.titleString = title
        self.placeholderStr = placeholder
         addSubviewFunc()
         setLayout()
    }
    required init(coder: NSCoder) {
        fatalError("fail init")
    }
    @objc func setLayout(){
        title.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().offset(30)

        }
        textField.snp.makeConstraints{
            $0.top.equalTo(title.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(30)
            $0.width.equalTo(UIScreen.main.bounds.width - 60)
        }
        line.snp.makeConstraints{
            $0.top.equalTo(textField.snp.bottom).offset(3)
            $0.left.equalToSuperview().offset(30)
            $0.size.equalTo(CGSize(width: UIScreen.main.bounds.width - 60, height: 2))
        }

    }
    @objc func addSubviewFunc(){
        [title,textField,line].forEach{
            self.addSubview($0)
        }
    }
    
}
