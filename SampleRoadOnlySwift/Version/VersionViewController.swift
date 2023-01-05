//
//  VersionViewController.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/12/23.
//

import UIKit

class VersionViewController: UIViewController {
    let versionView = VersionView()
    override func loadView() {
        super.loadView()
        view = versionView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setVersion()
        setTarget()
    }
    func setTarget(){
        versionView.topView.backBtn.addTarget(self, action: #selector(touchBackBtn), for: .touchUpInside)
    }
    func setVersion(){
        guard let currentVersion = UserDefaults.standard.string(forKey: "current_version"),
              let newestVersion = UserDefaults.standard.string(forKey: "newest_version")
        else {return}
        versionView.currentVersionLbl.text = "현재 버전" + " " + currentVersion
        versionView.newestVersionLbl.text = "최신 버전" + " " + newestVersion
        if currentVersion == newestVersion {
            versionView.isCurrentVersionLbl.isHidden = false
        }else {
            versionView.isCurrentVersionLbl.isHidden = true
        }
    }
    @objc func touchBackBtn(){
        self.navigationController?.popViewController(animated: true)
    }
}
