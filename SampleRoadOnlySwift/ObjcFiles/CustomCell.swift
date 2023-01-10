//
//  MainTableViewCell.swift
//  TableViewExample
//
//  Created by Fury on 29/05/2019.
//  Copyright © 2019 Fury. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    static let identifier = "Cell"

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
