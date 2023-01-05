//
//  MainContentViewController.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/10/12.
//

import UIKit
import Foundation
class MainContentViewController: UIViewController {
    var mainContentView = MainContentView()
    lazy var reviewVc = MyReviewViewController(screenRect:  CGRect(x: 0, y: 0, width: screenBounds2.width, height: screenBounds2.height - screenBounds2.width/4 - 90.0))
    lazy var myVc = MyPageSViewController(screenRect:  CGRect(x: 0, y: 0, width: screenBounds2.width, height: screenBounds2.height - screenBounds2.width/4 - 90.0))
    lazy var eventVc = EventSViewController(screenRect: CGRect(x: 0, y: 0, width: screenBounds2.width, height: screenBounds2.height - screenBounds2.width/4 - 90.0 - 38.0 - ((screenBounds2.width/2.0 - margin2)/6.0)))
    let common = CommonS()
    var moveBool = Bool()
    let screenbounds = UIScreen.main.bounds
    var dataDicArr = [[String:Any]]()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        if UserDefaults.standard.string(forKey: "user_image") ?? "" == ""  ||  !UserDefaults.contains("user_image") ||  UserDefaults.standard.string(forKey: "user_image") == "null"{
            myVc.myPageView.profileBtn.setImage(UIImage(named: "profile_btn"), for: .normal)
        }else {
            common2.setButtonImageUrl(url: UserDefaults.standard.string(forKey: "user_image") ?? "", button:  myVc.myPageView.profileBtn)
        }
        myVc.myPageView.nameLbl.text = UserDefaults.standard.string(forKey: "user_alias") ?? ""
        eventVc.tableView.reloadData()
        reviewVc.viewDidLoad()
    }
    override func loadView() {
        super.loadView()
        view = mainContentView
        mainContentView.rankVc.navi = self.navigationController
        myVc.navi = self.navigationController
        eventVc.navi = self.navigationController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getTopSampleId()
        mainContentView.sampleBtn.addTarget(self, action: #selector(touchSampleBtn), for: .touchUpInside)
        mainContentView.topView.cartBtn.addTarget(self, action: #selector(touchCartBtn), for: .touchUpInside)
        mainContentView.topView.alarmBtn.addTarget(self, action: #selector(touchAlarmBtn), for: .touchUpInside)
        mainContentView.firstViewBtn.addTarget(self, action: #selector(touchArrowBtn(sender:)), for: .touchUpInside)
        mainContentView.secondViewBtn.addTarget(self, action: #selector(touchArrowBtn(sender:)), for: .touchUpInside)
        mainContentView.thirdViewBtn.addTarget(self, action: #selector(touchArrowBtn(sender:)), for: .touchUpInside)
        printAllUserDefaults()
     //카트 전체 삭제
        print("커스터머 아이디")
        print(UserDefaults.standard.string(forKey: "customer_id"))
        addChild(reviewVc)
        addChild(myVc)
        addChild(eventVc)
        print(mainContentView.myView.frame)
        mainContentView.reviewView.addSubview(reviewVc.view)
        mainContentView.eventView.addSubview(eventVc.view)
        mainContentView.myView.addSubview(myVc.view)
        eventVc.view.frame = CGRect(x: 0, y: 0, width: screenBounds2.width, height:   screenBounds2.height - screenBounds2.width/4 - 90.0 - 38.0 - ((screenBounds2.width/2.0 - margin2)/6.0))
              myVc.view.frame = CGRect(x: 0, y: 0, width: screenBounds2.width, height: screenBounds2.height - screenBounds2.width/4)
        mainContentView.layoutIfNeeded()
        printAllUserDefaults()
    }
    func printAllUserDefaults(){
        print("USERDEFUALTS")
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            print("\(key) = \(value) \n")
        }
    }
    func redrawView(){
        mainContentView = MainContentView()
        self.loadView()
        self.viewDidLoad()
    }
  
   
    //배너 이미지 가져오기
  
    //베스트 3
    func getTopSampleId(){
        let cal = Calendar.current
        let componetYear = cal.component(.year, from: Date())
        let componentMonth = cal.component(.month, from: Date())
        print(cal.component(.hour, from: Date()))
        var params = [String:String]()
        params = ["date":"\(componetYear)-\(componentMonth)-01"]
        common.sendRequest(url: "http://110.165.17.124/sampleroad/v1/sample.php", method: "post", params: params, sender: "") { resultJson in
            print("여기")
            print(resultJson)
//            guard let topSampleArr = resultJson as? [[String:Any]] else {return}
//            if topSampleArr.count == 3 {
//                guard let firstProductId = topSampleArr[0]["product_id"] as? String else {return}
//                guard let secondProductId = topSampleArr[1]["product_id"] as? String else {return}
//                guard let thirdProductId = topSampleArr[2]["product_id"] as? String else {return}
//
//            }else {
//                return
//            }
            guard let topSample = resultJson as? [String:Any] else {return}
            guard let ids = topSample["ids"] as? String else {return}
            self.getTopSampleInfo(ids: ids)
           
        }
    }
    func getTopSampleInfo(ids:String){
        common.sendRequest(url: "https://api.clayful.io/v1/products?ids=\(ids)&sort=ids", method: "get", params: [:], sender: "") { resultJson in
            guard let topSampleInfoArr = resultJson as? [[String:Any]] else {
                self.mainContentView.noneView.isHidden = false
                return
            }
            var sortSampleInfoArr = [[String:Any]]()
            sortSampleInfoArr = [[:],[:],[:]]
            //순서대로 정렬
//            for i in 0...topSampleInfoArr.count - 1 {
//                if topSampleInfoArr[i]["_id"] as! String == firstId{
//                    sortSampleInfoArr[0] = topSampleInfoArr[i]
//                }
//                if topSampleInfoArr[i]["_id"] as! String == secondId{
//                    sortSampleInfoArr[1] = topSampleInfoArr[i]
//                }
//                if topSampleInfoArr[i]["_id"] as! String == thirdId{
//                    sortSampleInfoArr[2] = topSampleInfoArr[i]
//                }
//            }
            self.dataDicArr = topSampleInfoArr
            self.setTopSampleInfo(infoArr: topSampleInfoArr)
        }
    }
    
    func setTopSampleInfo(infoArr: [[String:Any]]){
        let firstBrand = infoArr[0]["brand"] as! [String:Any]
        let secondBrand = infoArr[1]["brand"] as! [String:Any]
        let thirdBrand = infoArr[2]["brand"] as! [String:Any]
        var firstRawRating  = String()
        var firstRawReview  = String()
        var secondRawRating = String()
        var secondRawReview = String()
        var thirdRawRating = String()
        var thirdRawReview = String()
        for i in 0...2 {
            let rating = infoArr[i]["rating"] as! [String:Any]
            let average = rating["average"] as! [String:Any]
            let totalReview = infoArr[i]["totalReview"] as! [String:Any]
            if i == 0 {
               
                firstRawRating = String(format: "%.1f", average["raw"] as! Double)
                firstRawReview = String(totalReview["raw"] as! Int)
            }else if i == 1 {
                secondRawRating = String(format: "%.1f", average["raw"] as! Double)
                secondRawReview = String(totalReview["raw"] as! Int)
            }else{
                thirdRawRating = String(format: "%.1f", average["raw"] as! Double)
                thirdRawReview = String(totalReview["raw"] as! Int)
            }
        }
//        String rating = JsonToHash.ToObject(JsonToHash.ToObject(item.get("rating")).get("average")).get("raw");
//        String totalReview = JsonToHash.ToObject(item.get("totalReview")).get("raw");
        var imgUrlArr = [String]()
        for i in 0...2{
            let ThumDic = infoArr[i]["thumbnail"] as! [String:Any]
            let ThumbURL = ThumDic["url"] as! String
            guard let encoded = ThumbURL.description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
            imgUrlArr.append(encoded)
        }
        mainContentView.firstCompanytLbl.text = firstBrand["name"] as? String
        mainContentView.secondCompanytLbl.text = secondBrand["name"] as? String
        mainContentView.thirdCompanytLbl.text = thirdBrand["name"] as? String
        mainContentView.firstProductLbl.text = infoArr[0]["name"] as? String
        mainContentView.secondProductLbl.text = infoArr[1]["name"] as? String
        mainContentView.thirdProductLbl.text = infoArr[2]["name"] as? String
        mainContentView.firstRatingLbl.text =  firstRawRating + "(\(firstRawReview))"
        mainContentView.firstRatingLbl.asColor(targetStringList: [firstRawRating], color: common.setColor(hex: "#ffbc00"))
        mainContentView.secondRatingLbl.text =  secondRawRating + "(\(secondRawReview))"
        mainContentView.secondRatingLbl.asColor(targetStringList: [secondRawRating], color: common.setColor(hex: "#ffbc00"))
        mainContentView.thirdRatingLbl.text =  thirdRawRating + "(\(thirdRawReview))"
        mainContentView.thirdRatingLbl.asColor(targetStringList: [thirdRawRating], color: common.setColor(hex: "#ffbc00"))
        common.setImageUrl(url: imgUrlArr[0], imageView: mainContentView.firstProductImgView)
        common.setImageUrl(url: imgUrlArr[1], imageView: mainContentView.secondProductImgView)
        common.setImageUrl(url: imgUrlArr[2], imageView: mainContentView.thirdProductImgView)
        if firstRawRating == "0.0" {
            mainContentView.firstRateImgView.image = UIImage(named: "rate_empty_btn")
        }
        if secondRawRating == "0.0" {
            mainContentView.secondRateImgView.image = UIImage(named: "rate_empty_btn")
        }
        if thirdRawRating == "0.0" {
            mainContentView.thirdRateImgView.image = UIImage(named: "rate_empty_btn")
        }
    }
    @objc func touchSampleBtn(){
        let vc = GetSampleViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func touchCartBtn(){
        let vc = CartListSViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func touchAlarmBtn(){
        let vc = NoticeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func touchArrowBtn(sender: UIButton){
        var vc = UIViewController()
      
        if sender.tag == 0 {
            let convertDic = NSMutableDictionary(dictionary: dataDicArr[0])
            guard let productId = convertDic["_id"] as? String else {return}
            vc = DetailProductViewController(productDic: dataDicArr[0])
        }else if sender.tag == 1 {
            let convertDic = NSMutableDictionary(dictionary: dataDicArr[1])
            guard let productId = convertDic["_id"] as? String else {return}
            vc = DetailProductViewController(productDic:  dataDicArr[1])
        }else if sender.tag == 2 {
            let convertDic = NSMutableDictionary(dictionary: dataDicArr[2])
            guard let productId = convertDic["_id"] as? String else {return}
            vc = DetailProductViewController(productDic: dataDicArr[2])
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func deleteAllCart(){
//        NSString *url = [NSString stringWithFormat:@"https://api.clayful.io/v1/customers/%@/cart/items"
//        //                     ,[[NSUserDefaults standardUserDefaults] valueForKey:@"customer_id"]];
//        //    [COMController sendRequestWithMethod:@"DELETE" :url :nil :self :@selector(emptyCartCallBack:)];
        print("dddddd")
        common.sendRequest(url: "https://api.clayful.io/v1/customers/\(UserDefaults.standard.string(forKey: "customer_id") ?? "")/cart/items", method: "DELETE", params: [:], sender: "") { result in
            print("dddddd")
        }
    }

    
}
