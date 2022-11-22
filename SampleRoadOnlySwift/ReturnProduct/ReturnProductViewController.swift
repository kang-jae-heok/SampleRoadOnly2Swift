//
//  ReturnProductViewController.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/11/22.
//

import UIKit

class ReturnProductViewController: UIViewController {
    let returnProductView = ReturnProductView()
   
    
    override func loadView() {
        super.loadView()
        view = returnProductView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
