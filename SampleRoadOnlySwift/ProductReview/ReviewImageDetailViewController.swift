//
//  ReviewImageDetailViewController.swift
//  SampleRoadOnlySwift
//
//  Created by notegg on 2022/12/08.
//

import Foundation

class ReviewImageDetailViewController: UIViewController {
    let reviewImageDetailView = ReviewImageDetailView()
    
    override func loadView() {
        super.loadView()
        view = reviewImageDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBind()
    }
    func setBind() {
        reviewImageDetailView.backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

