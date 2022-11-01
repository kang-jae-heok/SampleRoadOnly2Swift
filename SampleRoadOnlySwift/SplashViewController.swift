//
//  SplashViewController.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/10/26.
//

import UIKit

class SplashViewController: UIViewController {
    let common = CommonS()
    let screenBounds = UIScreen.main.bounds
    lazy var lblSize = CGSize(width: screenBounds.size.width/4, height: (screenBounds.size.width/4)*(1/3.6))
    let logoImgView = UIImageView().then{
        $0.image = UIImage(named: "logo_intro_btn")
    }
    let backgroundImgView = UIImageView().then{
        $0.image = UIImage(named: "bg_intro_btn")
    }
    let midView = UIView()
    lazy var titLbl = UILabel().then{
        $0.text = "누적샘플 수"
        $0.font = common.setFont(font: "semibold", size: 16)
        $0.backgroundColor = common.pointColor()
        $0.textAlignment = .center
        $0.layer.cornerRadius = lblSize.height/2
        $0.textColor = .white
        $0.clipsToBounds = true
    }
    lazy var sampleLbl = CountScrollLabel()

    lazy var copyRightLbl = UILabel().then{
        $0.text = "ⓒTov&Banah"
        $0.font = common.setFont(font: "light", size: 10)
        $0.textAlignment = .center
        $0.textColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getSampleCount()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviewFunc()
        setLayout()
        loadNextVC()

    }
    func addSubviewFunc(){
        [midView,titLbl,sampleLbl,copyRightLbl].forEach{
            view.addSubview($0)
        }
        [backgroundImgView,logoImgView].forEach{
            midView.addSubview($0)
        }
    }
    func setLayout(){
        copyRightLbl.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-20)
            $0.centerX.equalToSuperview()
        }
//        sampleLbl.snp.makeConstraints{
//            $0.bottom.equalTo(copyRightLbl.snp.top).offset(-30)
//            $0.centerX.equalToSuperview()
//            $0.size.equalTo(CGSize(width: 200.0, height: 60.0))
//        }
        let countLblSize = CGSize(width: 200.0, height: 60.0)
        sampleLbl.frame  = CGRect(x: screenBounds.width/2 - countLblSize.width/2, y: screenBounds.height - (countLblSize.height + 60.0), width: countLblSize.width, height: countLblSize.height)
        titLbl.snp.makeConstraints{
            $0.bottom.equalTo(sampleLbl.snp.top).offset(-10)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(lblSize)
        }
        midView.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(titLbl.snp.top)
        }
        logoImgView.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
        }
        backgroundImgView.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
        }
    }
    func getSampleCount(){
        
        common.sendRequest(url: "http://110.165.17.124/sampleroad/db/sr_setting_select.php", method: "post", params: [:], sender: "") { resultJson in
            let dicArr = resultJson as! [[String:Any]]
            self.sampleLbl.configure(with: dicArr[1]["count"] as! String, textFont: self.common.setFont(font: "extraBold", size: 29), textColor: self.common.pointColor())
        }
    }
    func loadNextVC() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if UserDefaults.standard.bool(forKey: "auto_login") {
                self.common.checkTypeFormDone2(customerId: UserDefaults.standard.string(forKey: "customer_id") ?? "") { [self] result in
                    if result {
                        self.navigationController?.pushViewController(MainContentViewController(), animated: true)
                    }else{
                        self.navigationController?.pushViewController(WebViewViewController(), animated: true)
                    }
                }
            }else{
                self.navigationController?.pushViewController(IntroViewController(), animated: true)
            }
        }
    }
}
