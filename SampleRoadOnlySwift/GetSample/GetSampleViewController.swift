//
//  GetSampleViewController.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/10/14.
//

import UIKit

class GetSampleViewController: UIViewController {
    let common = CommonS()
    var typeNum = Int()
    lazy var getSampleView = GetSampleView()
    override func loadView() {
        super.loadView()
        typeNum = 0
        view = getSampleView
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getSampleView.alphaView.isHidden = true
        getSampleView.alphaHiddenBtn.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getSampleView.nextBtn.addTarget(self, action: #selector(touchNextBtn), for: .touchUpInside)
        getSampleView.backBtn.addTarget(self, action: #selector(touchBackBtn), for: .touchUpInside)
        getSampleView.closeBtn.addTarget(self, action: #selector(touchCloseBtn), for: .touchUpInside)
    }
    
    
    @objc func touchNextBtn(){
        if typeNum < 2 {
            typeNum += 1
            getSampleView.nextBtn.isHidden = false
        }
        if typeNum == 0 {
            getSampleView.backBtn.isHidden = true
            getSampleView.typeTit.text = getSampleView.typeTitArr[0]
            getSampleView.getSample(type: "클렌징")
        }else if typeNum == 1 {
            getSampleView.backBtn.isHidden = false
            getSampleView.typeTit.text = getSampleView.typeTitArr[1]
            getSampleView.getSample(type: "모이스처")
        }else if typeNum == 2 {
            getSampleView.nextBtn.isHidden = true
            getSampleView.backBtn.isHidden = false
            getSampleView.typeTit.text = getSampleView.typeTitArr[2]
            getSampleView.getSample(type: "선케어")
        }
        print("타입넘2")
        print(typeNum)
    }
    @objc func touchBackBtn(){
        if typeNum > 0 {
            typeNum -= 1
            getSampleView.nextBtn.isHidden = false
        }
        if typeNum == 0 {
            getSampleView.backBtn.isHidden = true
            getSampleView.typeTit.text = getSampleView.typeTitArr[0]
            getSampleView.getSample(type: "클렌징")
        }else if typeNum == 1 {
            getSampleView.backBtn.isHidden = false
            getSampleView.typeTit.text = getSampleView.typeTitArr[1]
            getSampleView.getSample(type: "모이스처")
        }else if typeNum == 2 {
            getSampleView.backBtn.isHidden = false
            getSampleView.typeTit.text = getSampleView.typeTitArr[2]
            getSampleView.getSample(type: "선케어")
        }
    }
    @objc func touchCloseBtn(){
        self.navigationController?.popViewController(animated: true)
    }
   
}
