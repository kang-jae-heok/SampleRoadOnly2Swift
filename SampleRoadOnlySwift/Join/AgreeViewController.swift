//
//  JoinEmailViewController.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/09/29.
//

import UIKit


@objc class AgreeViewController: UIViewController {
    let agreeView = AgreeView()
    let common = CommonS()
    var isSocial = Bool()
    override func loadView() {
        super.loadView()
        view = agreeView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if isSocial {
            agreeView.topView.homeBtn.isHidden = true
        }else {
            agreeView.topView.homeBtn.isHidden = false
        }
        agreeView.nextBtn.addTarget(self, action: #selector(touchNextBtn(sender:)), for: .touchUpInside)
        agreeView.topView.homeBtn.addTarget(self, action: #selector(touchHomeBtn), for: .touchUpInside)
        agreeView.secondRead.addTarget(self, action: #selector(touchReadBtn(sender:)), for: .touchUpInside)
        agreeView.thirdRead.addTarget(self,action: #selector(touchReadBtn(sender:)),for: .touchUpInside)
        agreeView.fourthRead.addTarget(self,action: #selector(touchReadBtn(sender:)),for: .touchUpInside)
    }
    func updateTerms() {
        let params = [
            "customer_id" : customerId2,
            "update" : 1,
            "terms" : 1
        ] as [String : Any]
        common.sendRequest(url: "http://110.165.17.124/sampleroad/v1/user.php", method: "post", params: params, sender: "") { resultJson in
            self.navigationController?.popViewController(animated: true)
        }
    }
    @objc func touchNextBtn(sender: UIButton){
        if sender.backgroundColor == common.pointColor(){
            if isSocial {
            
                updateTerms()
            }else {
                let vc = JoinEmailViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    @objc func touchHomeBtn(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func touchReadBtn(sender: UIButton){
        var dic = [String:Any]()
        print(sender.tag)
        dic.updateValue("\(sender.tag)", forKey: "term_type")
        let vc = TermsViewController(dic: NSMutableDictionary(dictionary: dic))
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
