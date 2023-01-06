//
//  ReviewListViewController.swift
//  SampleLoad
//
//  Created by notegg on 2022/11/23.
//

import UIKit

class ReviewListSViewController: UIViewController {
    let reviewListView = ReviewListView()
    
    override func loadView() {
        super.loadView()
        
        view = reviewListView
    }
}

