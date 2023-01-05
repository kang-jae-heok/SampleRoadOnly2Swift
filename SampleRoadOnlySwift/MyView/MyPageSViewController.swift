//
//  MyViewController.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/11/17.
//

import UIKit

class MyPageSViewController: UIViewController {
    var navi: UINavigationController?
    var myPageView = MyPageSView()
    
    var screenRect = CGRect()
    init(screenRect: CGRect) {
        self.screenRect = screenRect
        super.init(nibName: nil, bundle: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        getLikeEventCount()
        getCouponCount()
    }
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        myPageView.layoutIfNeeded()
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
        myPageView.shopBtns[3].addTarget(self, action: #selector(touchLikeEventBtn), for: .touchUpInside)
        myPageView.shopBtns[1].addTarget(self, action: #selector(touchCouponBtn), for: .touchUpInside)
    }
    func getLikeEventCount(){
        var params = [String:Any]()
        params = ["customer_id":customerId2,"count":"1"]
        common2.sendRequest(url: "http://110.165.17.124/sampleroad/v1/event.php", method: "post", params: params, sender: "") { resultJson in
            print(resultJson)
            guard let likeEventCountDic = resultJson as? [String:Any] else {return}
            guard let likeEventCount = likeEventCountDic["count"] as? Int else {return}
            self.myPageView.pickCountLabel?.text = String(likeEventCount) + "개"
            self.myPageView.pickCountLabel?.asColor(targetStringList: [String(likeEventCount)], color: self.common2.pointColor())
        }
    }
    func getCouponCount(){
        common2.sendRequest(url: "https://api.clayful.io/v1/customers/\(customerId2)/coupons/count", method: "get", params: [:], sender: "") { resultJson in
            print(resultJson)
            guard let resultDic = resultJson as? [String:Any] else {return}
            guard let couponCountDic = resultDic["count"] as? [String:Any] else {return}
            guard let rawCount = couponCountDic["raw"] as? Int else {return}
            self.myPageView.couponCountLabel?.text = String(rawCount) + "개"
            self.myPageView.couponCountLabel?.asColor(targetStringList: [String(rawCount)], color: self.common2.pointColor())
        }
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
    @objc func touchLikeEventBtn(){
        navi?.pushViewController(LikeEventViewController(), animated: true)
    }
    @objc func touchCouponBtn(){
        navi?.pushViewController(CouponListViewController(), animated: true)
    }

}
