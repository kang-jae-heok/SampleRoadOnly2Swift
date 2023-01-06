//
//  MyReviewViewController.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/12/01.
//

import UIKit

class MyReviewViewController: UIViewController {
    let myReviewView = MyReviewView()
    var reviewCount: Int?
    var couponCount: Int?
    var stampCount: Int?
    var screenRect = CGRect()
    var reviewInfoArr = [[String:Any]]()
    var isGift = Bool()
    
    init(screenRect: CGRect) {
        self.screenRect = screenRect
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        super.loadView()
        view = myReviewView
        view.frame = screenRect
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
        setTable()
        getReviewList()
        getReviewCount()

    }
    func setTarget(){
        myReviewView.circleViews[9].addTarget(self, action: #selector(touchLastStamp), for: .touchUpInside)
    }
    func setTable(){
        myReviewView.reviewTableView.register(MyReviewTableViewCell.self, forCellReuseIdentifier: MyReviewTableViewCell.cellId)
        myReviewView.reviewTableView.delegate = self
        myReviewView.reviewTableView.dataSource = self
        myReviewView.reviewTableView.reloadData()
    }
    func noneReviewViewVisible(reviewCount: Int){
        if reviewCount == 0 {
            myReviewView.noneReviewView.isHidden = false
        }else {
            myReviewView.noneReviewView.isHidden = true
        }
    }
    func getReviewCount(){
        common2.sendRequest(url: "https://api.clayful.io/v1/products/reviews/count?published=true&customer=\(customerId2)", method: "get", params: [:], sender: "") { resultJson in
            guard let resultDic = resultJson as? [String:Any] else {return}
            guard let countDic = resultDic["count"] as? [String:Any] else {return}
            guard let rawCount = countDic["raw"] as? Int else {return}
            print(rawCount)
            self.myReviewView.countLbl.text = "총 \(String(rawCount))개"
            self.myReviewView.countLbl.asColor(targetStringList: [String(rawCount)], color: self.common2.pointColor())
            self.reviewCount = rawCount
            self.getCouponCount()
            self.noneReviewViewVisible(reviewCount: rawCount)
        }
    }
    func getCouponCount(){
        var parmams = [String:Any]()
        parmams.updateValue(1, forKey: "check")
        parmams.updateValue(customerId2, forKey: "customer_id")
        parmams.updateValue("DH8PZKCGBXCH", forKey: "coupon_id")
        common2.sendRequest(url: "http://110.165.17.124/sampleroad/v1/coupon.php", method: "post", params: parmams, sender: "") { [self] resultJson in
            print(resultJson)
            guard let resultDic = resultJson as? [String:Any] else {return}
            guard let count = resultDic["count"] as? String else {return}
            print(count)
            self.couponCount = Int(count)
            stampCount = (reviewCount ?? 0) - (Int(count) ?? 0) * 10
            if stampCount ?? 0 >= 10 {
                isGift = true
            }else {
                isGift = false
            }
            setStamp()
        }
    }
    func setStamp(){
        for i in 0...9 {
            self.myReviewView.circleViews[i].setImage(UIImage(named: ""), for: .normal)
        }
        if stampCount != 0  && stampCount ?? 0 <= 10{
            for i in 0...(stampCount ?? 0) - 1 {
                if i == 9 {
                    self.myReviewView.circleViews[i].setImage(UIImage(named: "img_stamp_gift"), for: .normal)
                }else {
                    self.myReviewView.circleViews[i].setImage(UIImage(named: "img_stamp_logo"), for: .normal)
                }
            }
        }else if stampCount ?? 0 > 10 && ((stampCount ?? 0) % 10) != 0{
            for i in 0...9 {
                if i == 9 {
                    self.myReviewView.circleViews[i].setImage(UIImage(named: "img_stamp_gift"), for: .normal)
                }else {
                    self.myReviewView.circleViews[i].setImage(UIImage(named: "img_stamp_logo"), for: .normal)
                }
            }
        }else if stampCount ?? 0 > 10 && ((stampCount ?? 0) % 10) == 0{
            for i in 0...9 {
                if i == 9 {
                    self.myReviewView.circleViews[i].setImage(UIImage(named: "img_stamp_gift"), for: .normal)
                }else {
                    self.myReviewView.circleViews[i].setImage(UIImage(named: "img_stamp_logo"), for: .normal)
                }
            }
        }
     
    }
    func getReviewList(){
        common2.sendRequest(url: "https://api.clayful.io/v1/products/reviews/published?customer=\(customerId2)", method: "get", params: [:], sender: "") { resultJson in
            guard let resultDicArr = resultJson as? [[String:Any]] else {return}
            self.reviewInfoArr = resultDicArr
            self.myReviewView.reviewTableView.reloadData()
        }
    }
//    @objc func touchLastStamp(){
//        var parmams = [String:Any]()
//        parmams.updateValue(1, forKey: "insert")
//        parmams.updateValue(customerId2, forKey: "customer_id")
//        parmams.updateValue("DH8PZKCGBXCH", forKey: "coupon_id")
//        if isGift{
//            common2.sendRequest(url: "http://110.165.17.124/sampleroad/v1/coupon.php", method: "post", params: parmams, sender: "") {[self] resultJson in
//                guard let resultDic = resultJson as? [String:Any] else {return}
//                guard let errorCode = resultDic["error"] as? String else {return}
//                if errorCode == "1" {
//                    present(common2.alert(title: "", message: "쿠폰이 정상적으로 발급되었습니다"), animated: true)
//                    isGift = false
//                    getCouponCount()
//                }
//            }
//        }
//    }
    @objc func touchLastStamp(){
        let couponId = "DH8PZKCGBXCH"
        if myReviewView.circleViews[9].imageView?.image == UIImage(named: "img_stamp_gift"){
            common2.sendRequest(url: "https://api.clayful.io/v1/customers/\(customerId2)/coupons", method: "post", params: ["coupon":couponId], sender: "") { resultJson in
                guard let resultDic = resultJson as? [String:Any] else {return}
                print(resultJson)
                print(resultDic["error"])
                if resultDic["error"] == nil {
                    guard let couponId = resultDic["coupon"] as? String else {return}
                    self.common2.sendRequest(url: "http://110.165.17.124/sampleroad/v1/coupon.php", method: "post", params: ["customer_id":UserDefaults.standard.string(forKey: "customer_id") ?? "","coupon_id":couponId,"insert":1], sender: "") {[self] resultJson2 in
                        print(resultJson2)
                        guard let resultDic2 = resultJson2 as? [String:Any] else {return}
                        guard let errorCode = resultDic2["error"] as? String else {return}
                        if errorCode == "1" {
                            addMyCoupon(couponId: couponId)
                        }else {
                            self.present(self.common2.alert(title: "에러", message: "잠시 후에 다시 시도해주세요"), animated: true)
                        }
                    }
                }else {
                    self.present(self.common2.alert(title: "에러", message: "이미 발급된 쿠폰이 있습니다 \n확인해주세요"), animated: true)
                }
            }
        }
    }
    func addMyCoupon(couponId: String){
        self.common2.sendRequest(url: "https://api.clayful.io/v1/coupons/\(couponId)", method: "get", params: [:], sender: "") {[self] resultJson in
            print(resultJson)
            guard let reusltDic = resultJson as? [String:Any] else {return}
            present(common2.alert(title: "", message: "쿠폰이 정상적으로 발급되었습니다"), animated: true)
            isGift = false
            getCouponCount()
        }
    }
    
}
extension MyReviewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewInfoArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyReviewTableViewCell(style: MyReviewTableViewCell.CellStyle.default, reuseIdentifier: MyReviewTableViewCell.cellId)
        let reviewInfoDic = reviewInfoArr[indexPath.row]
        guard let ratingDic = reviewInfoDic["rating"] as? [String:Any] else {return cell}
        guard let productDic = reviewInfoDic["product"] as? [String:Any] else {return cell}
        guard let productName = productDic["name"] as? String else {return cell}
        guard let rawRate = ratingDic["raw"] as? Int else {return cell}
        guard let createDateDic = reviewInfoDic["createdAt"] as? [String:Any] else {return cell}
        guard let createDateRaw = createDateDic["raw"] as? String else {return cell}
        guard let body = reviewInfoDic["body"] as? String else {return cell}
        let bodyArr = body.components(separatedBy: "\nsr_divide_here\n")
        if bodyArr.count < 2 {
            return cell
        }else {
            cell.goodContent.text = bodyArr[0]
            cell.badContent.text = bodyArr[1]
        }
        var convertDate = createDateRaw.components(separatedBy: "T")[0]
        convertDate = convertDate.replacingOccurrences(of: "-", with: ".")
        cell.tit.text = productName
        cell.ratingView.value = CGFloat(rawRate)
        cell.dateLbl.text = convertDate
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableView.automaticDimension
    }
    
    
}
