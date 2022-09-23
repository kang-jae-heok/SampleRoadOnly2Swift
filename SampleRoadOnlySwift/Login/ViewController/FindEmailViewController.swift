//
//  FindEmailViewController.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/09/22.
//

import UIKit

class FindEmailViewController: UIViewController {
    let findEmailView = FindEmailView()
    let common = Common()
    override func loadView() {
        super.loadView()
        view = findEmailView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}
