//
//  MainViewController.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/09/22.
//

import UIKit

class MainViewController: UIViewController {
    let mainView = MainView()

    override func loadView() {
        super.loadView()
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.joinEmail.addTarget(self, action: #selector(touchJoinEmail), for: .touchUpInside)
        mainView.startBtn.addTarget(self, action: #selector(touchStartBtn), for: .touchUpInside)
        mainView.naverBtn.addTarget(self, action: #selector(touchNaverBtn), for: .touchUpInside)
        mainView.kakaoBtn.addTarget(self, action: #selector(touchKakaoBtn), for: .touchUpInside)
    }

    @objc func touchJoinEmail(){

    }
    @objc func touchStartBtn(){
        let vc = LoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)

    }
    @objc func touchNaverBtn(){

    }
    @objc func touchKakaoBtn(){

    }



}
