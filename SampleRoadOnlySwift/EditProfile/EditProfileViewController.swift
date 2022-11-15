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
    }
    

}
