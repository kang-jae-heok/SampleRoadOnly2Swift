//
//  MainContentViewController.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/10/12.
//

import UIKit

class MainContentViewController: UIViewController {
    let mainContentView = MainContentView()
    let common = CommonS()
    let screenbounds = UIScreen.main.bounds
    var dataDicArr = [[String:Any]]()
    override func loadView() {
        super.loadView()
        view = mainContentView
        
        
        mainContentView.rankVc.navi = self.navigationController
        mainContentView.eventVc.navi = self.navigationController
        mainContentView.myVc.navi = self.navigationController
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
        
//        deleteAllCart()
    }
    //배너 이미지 가져오기
   
    //베스트 3
    func getTopSampleId(){
        let cal = Calendar.current
        let componetYear = cal.component(.year, from: Date())
        let componentMonth = cal.component(.month, from: Date())
        print(cal.component(.hour, from: Date()))
        var params = [String:String]()
        params = ["date":"\(componetYear)-\(componentMonth)"]
        common.sendRequest(url: "http://110.165.17.124/sampleroad/db/sr_top_sample_select.php", method: "post", params: params, sender: "") { resultJson in
            let topSampleArr = resultJson as? [[String:Any]]
            let firstProductId = topSampleArr?[0]["product_id"] as! String
            let secondProductId = topSampleArr?[1]["product_id"] as! String
            let thirdProductId = topSampleArr?[2]["product_id"] as! String
            self.getTopSampleInfo(firstId: firstProductId, secondId: secondProductId, thirdId: thirdProductId)
        }
    }
    func getTopSampleInfo(firstId: String, secondId: String, thirdId: String){
        common.sendRequest(url: "https://api.clayful.io/v1/products?ids=\(firstId),\(secondId),\(thirdId)", method: "get", params: [:], sender: "") { resultJson in
            let topSampleInfoArr = resultJson as! [[String:Any]]
            var sortSampleInfoArr = [[String:Any]]()
            sortSampleInfoArr = [[:],[:],[:]]
            //순서대로 정렬
            for i in 0...topSampleInfoArr.count - 1 {
                if topSampleInfoArr[i]["_id"] as! String == firstId{
                    sortSampleInfoArr[0] = topSampleInfoArr[i]
                }
                if topSampleInfoArr[i]["_id"] as! String == secondId{
                    sortSampleInfoArr[1] = topSampleInfoArr[i]
                }
                if topSampleInfoArr[i]["_id"] as! String == thirdId{
                    sortSampleInfoArr[2] = topSampleInfoArr[i]
                }
            }
            self.dataDicArr = sortSampleInfoArr
            self.setTopSampleInfo(infoArr: sortSampleInfoArr)
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
                print(totalReview["raw"])
                firstRawRating = String(format: "%.1f", average["raw"] as! Float)
                firstRawReview = String(totalReview["raw"] as! Int)
            }else if i == 1 {
                secondRawRating = String(format: "%.1f", average["raw"] as! Float)
                secondRawReview = String(totalReview["raw"] as! Int)
            }else{
                thirdRawRating = String(format: "%.1f", average["raw"] as! Float)
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
        mainContentView.firstRatingLbl.asColor(targetStringList: [firstRawRating], color: .yellow)
        mainContentView.secondRatingLbl.text =  secondRawRating + "(\(secondRawReview))"
        mainContentView.secondRatingLbl.asColor(targetStringList: [secondRawRating], color: .yellow)
        mainContentView.thirdRatingLbl.text =  thirdRawRating + "(\(thirdRawReview))"
        mainContentView.thirdRatingLbl.asColor(targetStringList: [thirdRawRating], color: .yellow)
        common.setImageUrl(url: imgUrlArr[0], imageView: mainContentView.firstProductImgView)
        common.setImageUrl(url: imgUrlArr[1], imageView: mainContentView.secondProductImgView)
        common.setImageUrl(url: imgUrlArr[2], imageView: mainContentView.thirdProductImgView)
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
            vc = ProductDetailViewController(data: convertDic)
        }else if sender.tag == 1 {
            let convertDic = NSMutableDictionary(dictionary: dataDicArr[1])
            vc = ProductDetailViewController(data: convertDic)
        }else if sender.tag == 2 {
            let convertDic = NSMutableDictionary(dictionary: dataDicArr[2])
            vc = ProductDetailViewController(data: convertDic)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func deleteAllCart(){
//        NSString *url = [NSString stringWithFormat:@"https://api.clayful.io/v1/customers/%@/cart/items"
//        //                     ,[[NSUserDefaults standardUserDefaults] valueForKey:@"customer_id"]];
//        //    [COMController sendRequestWithMethod:@"DELETE" :url :nil :self :@selector(emptyCartCallBack:)];
        print("dddddd")
        print(UserDefaults.standard.string(forKey: "customer_id")!)
        common.sendRequest(url: "https://api.clayful.io/v1/customers/\(UserDefaults.standard.string(forKey: "customer_id")!)/cart/items", method: "DELETE", params: [:], sender: "") { result in
            print("dddddd")
        }
    }
    
}
