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
    override func loadView() {
        super.loadView()
        view = agreeView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        agreeView.nextBtn.addTarget(self, action: #selector(touchNextBtn(sender:)), for: .touchUpInside)
        agreeView.topView.homeBtn.addTarget(self, action: #selector(touchHomeBtn), for: .touchUpInside)
        agreeView.secondRead.addTarget(self, action: #selector(touchReadBtn(sender:)), for: .touchUpInside)
        agreeView.thirdRead.addTarget(self,action: #selector(touchReadBtn(sender:)),for: .touchUpInside)
        agreeView.fourthRead.addTarget(self,action: #selector(touchReadBtn(sender:)),for: .touchUpInside)
    }
    @objc func touchNextBtn(sender: UIButton){
        if sender.backgroundColor == common.pointColor(){
            let vc = JoinEmailViewController()
            self.navigationController?.pushViewController(vc, animated: true)
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
