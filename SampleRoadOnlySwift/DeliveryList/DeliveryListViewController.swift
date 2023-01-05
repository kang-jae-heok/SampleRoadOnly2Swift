//
//  DeliveryHistoryViewController.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/10/28.
//

import UIKit

class DeliveryListViewController: UIViewController {
    let deliveryListView = DeliveryListView()
    let common = CommonS()
    override func loadView() {
        super.loadView()
        view = deliveryListView
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        deliveryListView.getDeliveryList()
        deliveryListView.deliveryListTableView.register(DeliveryListSampleTableViewCell.self, forCellReuseIdentifier: DeliveryListSampleTableViewCell.cellId)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
    
       
    }
    func setTarget(){
        deliveryListView.backBtn.addTarget(self, action: #selector(touchBackBtn), for: .touchUpInside)
    }
  
    @objc func touchBackBtn(){
        self.navigationController?.popViewController(animated: true)
    }


}
