//
//  CompletedViewController.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/11/22.
//

import UIKit

class CompletedViewController: UIViewController {
    var completedView = CompletedView()
    var completedModel = CompletedModel()
    var type = String()
//    var type = String()
    public init(type: String) {
        super.init(nibName: nil, bundle: nil)
        self.type = type
      
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        super.loadView()
        view = completedView
    }
  
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setTarget()
    }
    func setLayout(){
        if type == "exchange" {
            completedView.topView.tit.text = "교환 신청 완료"
            completedView.tit.text = completedModel.exchangeTit
            completedView.subTit.text = completedModel.exchangeSubTit
        }else if type == "return"{
            completedView.topView.tit.text = "반품 신청 완료"
            completedView.tit.text = completedModel.returnTit
            completedView.subTit.text = completedModel.returnSubTit
        }
        self.view.layoutIfNeeded()
    }
    
    func setTarget(){
        completedView.topView.backBtn.addTarget(self, action: #selector(touchBackBtn), for: .touchUpInside)
        completedView.homeBtn.addTarget(self, action: #selector(touchHomeBtn), for: .touchUpInside)
    }
    @objc func touchBackBtn(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func touchHomeBtn() {
        self.navigationController?.pushViewController(MainContentViewController(), animated: true)
    }


}
