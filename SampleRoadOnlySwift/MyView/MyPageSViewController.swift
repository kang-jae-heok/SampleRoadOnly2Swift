//
//  MyViewController.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/11/17.
//

import UIKit

class MyPageSViewController: UIViewController {
    var navi: UINavigationController?
    let myPageView = MyPageSView()
    
    var screenRect = CGRect()
    init(screenRect: CGRect) {
        self.screenRect = screenRect
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func loadView() {
        super.loadView()
        view = myPageView
        view.frame = screenRect
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
    }
    func setTarget(){
        myPageView.likeSampleBtn.addTarget(self, action: #selector(touchLikeSampleBtn), for: .touchUpInside)
        myPageView.getSampleBtn.addTarget(self, action: #selector(touchGetSampleBtn), for: .touchUpInside)
        myPageView.deliveryBtn.addTarget(self, action: #selector(touchDeliveryBtn), for: .touchUpInside)
        myPageView.settingBtn.addTarget(self, action: #selector(touchSettingBtn), for: .touchUpInside)
        myPageView.editProfileBtn.addTarget(self, action: #selector(touchEditProfileBtn), for: .touchUpInside)
        myPageView.profileBtn.addTarget(self, action: #selector(touchEditProfileBtn), for: .touchUpInside)
        
    }
    @objc func touchLikeSampleBtn(){
        navi?.pushViewController(LikeProductViewController(), animated: true)
    }
    @objc func touchGetSampleBtn(){
        navi?.pushViewController(ReceivedSampleViewController(), animated: true)
    }
    @objc func touchDeliveryBtn(){
        navi?.pushViewController(DeliveryListViewController(), animated: true)
    }
    @objc func touchSettingBtn(){
        navi?.pushViewController(SettingViewController(), animated: true)
    }
    @objc func touchEditProfileBtn(){
        navi?.pushViewController(EditProfileViewController(), animated: true)
    }

}
