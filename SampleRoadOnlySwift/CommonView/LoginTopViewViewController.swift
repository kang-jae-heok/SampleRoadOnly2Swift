//
//  TopViewViewController.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/10/05.
//

import UIKit
import IQKeyboardManagerSwift

class TopViewViewController: UIViewController {
    let topView = LoginTopView()
    let common = CommonS()
    override func loadView() {
        super.loadView()
        view = topView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        IQKeyboardManager.sharedManager().disabledToolbarClasses = [QuantityPickerDialog.self] //of type UIViewController
    }

}
