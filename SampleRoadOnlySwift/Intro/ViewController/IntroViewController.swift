//
//  IntroViewController.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/09/20.
//

import UIKit

class IntroViewController: UIViewController {
    let introView = IntroView()
    override func loadView() {
        super.loadView()
        view = introView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        introView.startBtn.addTarget(self, action: #selector(touchStartBtn), for: .touchUpInside)
    }
    

    @objc func touchStartBtn(){
        print("hi")
    }


}
