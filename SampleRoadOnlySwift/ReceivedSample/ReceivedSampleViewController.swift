//
//  ReceivedSampleViewController.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/11/04.
//

import UIKit

class ReceivedSampleViewController: UIViewController {
    let receivedSampleView = ReceivedSampleView()
    var sampleInfoArr = [[String:Any]]()
    var sampleIdsArr = [String]()
    override func loadView() {
        view = receivedSampleView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
        setTable()
        getSampleData()
    }
    func setTarget(){
        receivedSampleView.topView.backBtn.addTarget(self, action: #selector(touchBackBtn), for: .touchUpInside)
    }
    func setTable(){
        receivedSampleView.receivedSampleTableView.register(ReceivedSampleTableViewCell.self, forCellReuseIdentifier: ReceivedSampleTableViewCell.cellId)
        receivedSampleView.receivedSampleTableView.delegate = self
        receivedSampleView.receivedSampleTableView.dataSource = self
    }
    
    func getSampleData(){
        guard let customerId = UserDefaults.standard.string(forKey: "customer_id") else { return }
        common2.sendRequest(url: "http://110.165.17.124/sampleroad/v1/sample.php", method: "post", params: ["customer_id":customerId], sender: "") { [self] resultJson in
            guard let recievedSampleDic = resultJson as? [String:Any],
                  let ids = recievedSampleDic["ids"] as? String
            else {return}
            sampleIdsArr = ids.components(separatedBy: ",")
            getProductData(ids: ids)
            print(ids)
            if ids == "" {
                receivedSampleView.noneSampleView.isHidden = false
            }else {
                receivedSampleView.noneSampleView.isHidden = true
            }
           
        }
    }
    func getProductData(ids: String){
       
        common2.sendRequest(url: "https://api.clayful.io/v1/products?ids=\(ids)", method: "get", params: [:], sender: "") {[self] resultJson in
            print("아아아아")
            print(resultJson)
            guard let sampleInfoDicArr = resultJson as? [[String:Any]] else { return }
            self.sampleInfoArr = sampleInfoDicArr
         
            self.receivedSampleView.receivedSampleTableView.reloadData()
        }
    }
    @objc func touchBackBtn(){
        self.navigationController?.popViewController(animated: true)
    }
}
extension ReceivedSampleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        receivedSampleView.countLbl.text = "총 " + String(sampleInfoArr.count) + "개"
        receivedSampleView.countLbl.asColor(targetStringList: ["총","개"], color: common2.setColor(hex: "#b1b1b1"))
        return sampleInfoArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ReceivedSampleTableViewCell(style: ReceivedSampleTableViewCell.CellStyle.default, reuseIdentifier: ReceivedSampleTableViewCell.cellId)
        let sampleInfoDic = sampleInfoArr[indexPath.row]
        guard let brand: [String:Any] = sampleInfoDic["brand"] as? [String:Any] else { return cell }
        guard let brandName: String = brand["name"] as? String else { return cell }
        guard let sampleName: String = sampleInfoDic["name"] as? String else { return cell }
        guard let rating = sampleInfoDic["rating"] as? [String:Any] else { return cell}
        guard let average = rating["average"] as? [String:Any] else { return cell }
        guard let totalReview = sampleInfoDic["totalReview"] as? [String:Any],
              let rawTotalReview = totalReview["raw"] as? Int
        else { return cell }
        let rawAverage = average["raw"] as? Double ?? 0
        let RawRating = String(format: "%.1f", rawAverage)
        let RawReview = String(rawTotalReview)
        guard let thumDic = sampleInfoDic["thumbnail"] as? [String:Any] else { return cell }
        guard let thumbURL = thumDic["url"] as? String else { return cell }
        guard let encoded = thumbURL.description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return cell }
        
        cell.companyNameLbl.text = brandName
        cell.productNameLbl.text = sampleName
        cell.ratingLbl.text =  RawRating + "(\(RawReview))"
        common2.setImageUrl(url: encoded, imageView: cell.productImgView)
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sampleInfoDic = sampleInfoArr[indexPath.row]
        self.navigationController?.pushViewController(DetailProductViewController(productDic: sampleInfoDic), animated: true)
    }
}
