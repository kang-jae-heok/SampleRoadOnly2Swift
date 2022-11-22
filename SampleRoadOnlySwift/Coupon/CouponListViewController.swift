//
//  CouponListViewController.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/11/10.
//

import UIKit

class CouponListViewController: UIViewController {
    let couponListView = CouponListView()
    
    override func loadView() {
        super.loadView()
        view = couponListView
        getCouponInfo()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func getCouponInfo(){
        let params = ["customer_id":UserDefaults.standard.string(forKey: "customer_id")!]
        common2.sendRequest(url: "http://110.165.17.124/sampleroad/db/sr_coupon_select.php", method: "post", params: params, sender: "") { [self] resultJson in
            guard let checkCouponDicArr: [[String:Any]] = resultJson as? [[String:Any]] else { return }
            if checkCouponDicArr.count != 0 {
                for i in 0...checkCouponDicArr.count-1 {
                    let checkCouponDic: [String:Any] = checkCouponDicArr[i]
                    guard let checkCouponId: String = checkCouponDic["coupon_id"] as? String else { return }
                    couponListView.checkCouponArr.append(checkCouponId)
                }
            }
            self.view.layoutIfNeeded()
        }
  
        common2.sendRequest(url: "https://api.clayful.io/v1/coupons", method: "get", params: [:], sender: "") { [self] resultJson in
            guard let getCouponDicArr: [[String:Any]] = resultJson as? [[String:Any]] else { return }
            couponListView.getCouponInfoDicArr = getCouponDicArr
            print(getCouponDicArr)
            self.view.layoutIfNeeded()
        }
        common2.sendRequest(url: "https://api.clayful.io/v1/customers/\(UserDefaults.standard.string(forKey: "customer_id")!)/coupons", method: "get", params: [:], sender: "") { [self] resultJson in
            guard let myCouponDicArr: [[String:Any]] = resultJson as? [[String:Any]] else { return }
            couponListView.myCouponInfoDicArr = myCouponDicArr
            self.view.layoutIfNeeded()
        }
    }

}
