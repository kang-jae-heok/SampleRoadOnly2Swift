//
//  ReceivedSampleViewController.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/11/04.
//

import UIKit

class LikeProductViewController: UIViewController {
    let likeProductView = LikeProductView()
    
    var prdcIdArr = [String]()
    var likeProductDicArr = [[String:Any]]()
    override func loadView() {
        view = likeProductView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
        setTable()
        getSampleData()
    }
    func setTable(){
        likeProductView.likeProductTableView.register(LikeProductTableViewCell.self, forCellReuseIdentifier: LikeProductTableViewCell.cellId)
        likeProductView.likeProductTableView.delegate = self
        likeProductView.likeProductTableView.dataSource = self
    }
    func setTarget(){
        likeProductView.allDeleteBtn.addTarget(self, action: #selector(touchAllDeleteBtn), for: .touchUpInside)
        likeProductView.topView.backBtn.addTarget(self, action: #selector(touchBackBtn), for: .touchUpInside)
    }
  
    func getSampleData(){
        guard let customerId = UserDefaults.standard.string(forKey: "customer_id") else { return }
        common2.sendRequest(url: "http://110.165.17.124/sampleroad/v1/product.php", method: "post", params: ["customer_id":customerId], sender: "") { [self] resultJson in
            print(resultJson)
            guard let sampleDic = resultJson as? [String:Any],
                  let ids = sampleDic["ids"] as? String,
                  let count = sampleDic["count"] as? Int
            else {return}
            let idArr = ids.components(separatedBy: ",")
            prdcIdArr = idArr
            if ids == ""  {
                likeProductView.noneView.isHidden = false
            }else {
                likeProductView.noneView.isHidden = true
            }
            likeProductDicArr.removeAll()
            getProductData(prdcIdArr: prdcIdArr)
        }
    }
    func getProductData(prdcIdArr: [String]){
        var queryStr = String()
        if prdcIdArr.count != 0 {
            for i in 0...prdcIdArr.count-1 {
                if i != 0 {
                    queryStr += ","
                }
                queryStr += prdcIdArr[i]
            }
        }
       
        common2.sendRequest(url: "https://api.clayful.io/v1/products?ids=\(queryStr)", method: "get", params: [:], sender: "") { resultJson in
            guard let sampleInfoDicArr = resultJson as? [[String:Any]] else {
                self.likeProductView.likeProductTableView.reloadData()
                self.view.layoutIfNeeded()
                return
            }
            self.likeProductDicArr = sampleInfoDicArr
            self.likeProductView.likeProductTableView.reloadData()
            self.view.layoutIfNeeded()
        }
    }
    @objc func touchAllDeleteBtn(){
        var params = [String:Any]()
        params = ["delete":1, "customer_id": customerId2]
        common2.sendRequest(url: "http://110.165.17.124/sampleroad/v1/product.php", method: "post", params: params, sender: "") { resultJson in
            print(resultJson)
            guard let resultDic = resultJson as? [String:Any],
                  let error = resultDic["error"] as? String
            else {return}
            if error == "1" {
                self.likeProductDicArr.removeAll()
                self.likeProductView.likeProductTableView.reloadData()
                self.view.layoutIfNeeded()
            }
        }
    }
    @objc func touchDeleteBtn(sender: UIButton){
        guard let customerId = UserDefaults.standard.string(forKey: "customer_id") else { return }
        var params = [String:Any]()
        params.updateValue("1", forKey:"update")
        params.updateValue(prdcIdArr[sender.tag], forKey:"product_id")
        params.updateValue(customerId, forKey:"customer_id")
        common2.sendRequest(url: "http://110.165.17.124/sampleroad/v1/product.php", method: "post", params: params, sender: "") { resultJson in
            self.getSampleData()
        }
    }
    @objc func touchBackBtn(){
        self.navigationController?.popViewController(animated: true)
    }
 
}
extension LikeProductViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        likeProductView.countLbl.text = "총 " + String(likeProductDicArr.count) + "개"
        likeProductView.countLbl.asColor(targetStringList: ["총","개"], color: common2.setColor(hex: "#b1b1b1"))
        return likeProductDicArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LikeProductTableViewCell(style: LikeProductTableViewCell.CellStyle.default, reuseIdentifier: LikeProductTableViewCell.cellId)
        let sampleInfoDic = likeProductDicArr[indexPath.row]
       
        guard let brand: [String:Any] = sampleInfoDic["brand"] as? [String:Any] else { return cell }
        guard let brandName: String = brand["name"] as? String else { return cell }
        guard let sampleName: String = sampleInfoDic["name"] as? String else { return cell }
        guard let rating = sampleInfoDic["rating"] as? [String:Any] else { return cell}
        guard let average = rating["average"] as? [String:Any] else { return cell }
        guard let totalReview = sampleInfoDic["totalReview"] as? [String:Any],
              let rawAverage = average["raw"] as? Float,
              let rawTotalReview = totalReview["raw"] as? Int
        else { return cell }
        let RawRating = String(format: "%.1f", rawAverage)
        let RawReview = String(rawTotalReview)
        guard let thumDic = sampleInfoDic["thumbnail"] as? [String:Any] else { return cell }
        guard let thumbURL = thumDic["url"] as? String else { return cell }
        guard let encoded = thumbURL.description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return cell }
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(touchDeleteBtn(sender:)), for: .touchUpInside)
        cell.companyNameLbl.text = brandName
        cell.productNameLbl.text = sampleName
        cell.ratingLbl.text =  RawRating + "(\(RawReview))"
        common2.setImageUrl(url: encoded, imageView: cell.productImgView)
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
}

