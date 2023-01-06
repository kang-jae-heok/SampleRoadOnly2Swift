
//
//  AllReviewListViewController.swift
//  SampleLoad
//
//  Created by notegg on 2022/11/23.
//

import UIKit
import Alamofire

class AllReviewListViewController: UIViewController {
    let allReviewListView = AllReviewListView()
    var productID: String?
    var productDic: [String:Any]?
    var reviews = [Review]()
    
    override func loadView() {
        super.loadView()
        
        view = allReviewListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindAction()
        setTableView()
        getReviewList()
    }
    func noneReviewHidden(){
        if reviews.count == 0 {
            allReviewListView.noneReviewView.isHidden = false
        }else {
            allReviewListView.noneReviewView.isHidden = true
        }
        
    }
    func bindAction() {
        allReviewListView.backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        allReviewListView.buyButton.addTarget(self, action: #selector(buyButtonTapped(_:)), for: .touchUpInside)
        allReviewListView.writeReviewButton.addTarget(self, action: #selector(writeButtonTapped(_:)), for: .touchUpInside)
    }
    func setTableView() {
        allReviewListView.reviewListTableView.register(
            ReviewListTableViewCell.self,
            forCellReuseIdentifier: ReviewListTableViewCell.identifier
        )
        allReviewListView.reviewListTableView.dataSource = self
    }
    func getReviewList() {
        guard let productID = productID else {
            return
        }
        let url = "https://api.clayful.io/v1/products/reviews/published?product=\(productID)"
        let header: HTTPHeaders = [
            "Content-Type":"application/json",
            "Accept":"application/json",
            "Accept-Encoding":"gzip",
            "Authorization":"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjM4N2NkNjVkZGUxOWExZjdkNGM0NTk2ODhlZTJkNTk1MWZkZjRlYTI5ZWQ1OWE1NTc2MjBlOTI5Y2M4OTNiZTAiLCJyb2xlIjoiY2xpZW50IiwiaWF0IjoxNjU0NTc5NzQ0LCJzdG9yZSI6IlZLS1RZTjIzVEJFUS5GOVg5R0pKQkVFNVEiLCJzdWIiOiJYUzRVRVRCOFNFVkcifQ.G1j5SEaS-sjgRf1dPTr0l7zeIPNVPKVNw2Ga49FfUG0"
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: header
        ).responseDecodable(of: [Review].self) { [weak self] res in
            switch res.result {
            case .failure(let error):
                print(error)
            case .success(let reviews): 
                self?.reviews = reviews
                self?.noneReviewHidden()
                self?.allReviewListView.reviewListTableView.reloadData()
            }
        }
    }
    @objc func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func buyButtonTapped(_ sender: UIButton) {
        guard var productDic = productDic else {
            return
        }
        productDic.updateValue(1, forKey: "quantity")
        self.navigationController?.pushViewController(OrderSViewController(orderListDic:  ["product_list":[productDic]]), animated: true)
    }
    @objc func writeButtonTapped(_ sender: UIButton) {
        self.navigationController?.pushViewController(WriteReivewSViewController(dic: productDic ?? [:]), animated: true)
    }
}
 
extension AllReviewListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: ReviewListTableViewCell.identifier, for: indexPath)
        guard let cell = dequeuedCell as? ReviewListTableViewCell else {
            return dequeuedCell
        }
        cell.selectionStyle = .none
        cell.reviewInfo = reviews[indexPath.row]
        cell.setProperties()
        cell.thumbBtnPressed = {[self] in
               common2.sendRequest(url: "https://api.clayful.io/v1/products/reviews/\(self.reviews[indexPath.row].id)/helped/up", method: "post", params: ["customer":self.customerId2], sender: "") { [self] resultJson in
                   print(resultJson)
                   let resultDic = resultJson as? [String:Any] ?? [:]
                   if let errorCode = resultDic["errorCode"] as? String {
                       if errorCode == "duplicated-vote" {
                           self.present(common2.alert(title: "공지", message: "이미 좋아요를 누른 제품입니다"), animated: true)
                       }
                   }
                   self.getReviewList()
               }
        }
//        let cell =  ReviewListTableViewCell()
//        cell.setReviewImageView()
        
        return cell
    }
    
    
}

