//
//  FindPassViewController.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/09/23.
//

import UIKit

class FindPassViewController: UIViewController {
    let findEmailView = FindPassView()
    override func loadView() {
        super.loadView()
        view = findEmailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        findEmailView.topView.homeBtn.addTarget(self, action: #selector(touchHomeBtn), for: .touchUpInside)
    }
    @objc func touchHomeBtn(){
        self.navigationController?.popViewController(animated: true)
    }

}
