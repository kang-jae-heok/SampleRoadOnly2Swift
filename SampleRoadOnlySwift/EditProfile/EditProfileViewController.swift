//
//  EditProfileViewController.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/11/15.
//

import UIKit

class EditProfileViewController: UIViewController {
    let editProfileView = EditProfileView()
    
    override func loadView() {
        super.loadView()
        view = editProfileView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
    }
    func setTarget(){
        editProfileView.topView.backBtn.addTarget(self, action: #selector(touchBackBtn), for: .touchUpInside)
        editProfileView.nameDuplicateCheckBtn.addTarget(self, action: #selector(touchNameDuplicateCheckBtn), for: .touchUpInside)
        editProfileView.yesBtn.addTarget(self, action: #selector(touchYesBtn), for: .touchUpInside)
    }
    @objc func touchBackBtn(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func touchNameDuplicateCheckBtn(){
        present(common2.alert(title: "", message: "준비중입니다"), animated: true)
    }
    @objc func touchYesBtn(){
        present(common2.alert(title: "", message: "준비중입니다"), animated: true)
    }
    

}
