//
//  NoticeCell.swift
//  sampleroad
//
//  Created by NOTEGG on 2022/07/19.
//  Copyright © 2022 CNKANG. All rights reserved.
//

import UIKit

class NoticeCell: UITableViewCell {
    
    static let identifier = "NoticeCell"

//    @objc var didDelete: () -> ()  = { }

    
    
    
    
    let eventLabel: UILabel = {
        let label = UILabel()
        
        label.font = Common.kFont(withSize: "bold", 12)
        label.textColor = Common.color(withHexString: "6f6f6f")
        label.layer.cornerRadius = label.layer.frame.size.width / 2
        label.text = "이벤트"
        label.textAlignment = .center
        label.layer.cornerRadius = 15
        label.layer.borderWidth = 2.0
        label.layer.borderColor = Common.pointColor1().cgColor
        //          label.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        label.layer.masksToBounds = true
        return label
    }()
    
    var dataLabel: UILabel = {
        let label = UILabel()
        label.text = "2022년 06월 02일"
        label.font = Common.kFont(withSize: "regular", 10)
        label.textColor = Common.color(withHexString: "b1b1b1")
        return label
    }()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "프리메라 오가니어스 워터리 에센스 체험단 모집!"
        label.font = Common.kFont(withSize: "bold", 14)
        label.textColor = Common.color(withHexString: "6f6f6f")
        return label
    }()
    let xImg: UIButton = {
        let ximg = UIButton()
        ximg.translatesAutoresizingMaskIntoConstraints = false
        ximg.titleLabel?.adjustsFontForContentSizeCategory = true
        ximg.setImage(UIImage(named: "x_btn"), for: .normal)
        ximg.contentMode = .scaleAspectFit
        return ximg
      }()
    
    let underLine: UIView = {
        let underLine = UIView()
        return underLine
      }()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.addSubview(eventLabel)
        self.addSubview(dataLabel)
        self.addSubview(descriptionLabel)
//        self.addSubview(titleBackBtn)
        self.addSubview(xImg)
        self.addSubview(underLine)
        
        // Configure the view for the selected state
    }
}
