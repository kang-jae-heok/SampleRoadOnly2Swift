//
//  MyPageViewController.swift
//  sampleroad
//
//  Created by NOTEGG on 2022/07/07.
//  Copyright © 2022 CNKANG. All rights reserved.
//
import Foundation
import UIKit
import NaverThirdPartyLogin

@objc class MyPageViewController: UIViewController {
    
    var screenRect  =  CGRect()
    let margin = 27.0
    let common = CommonS()
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    let innerMargin = 22.0
    var navi: UINavigationController?
    @objc init(screenRect: CGRect) {
        self.screenRect = screenRect
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var screenBounds = CGRect()
  
    
    
//    let scrollView = UIScrollView()
    let mainView = UIScrollView()
    let backgroundView = UIView()
    let deliveryView = DeliveryHistoryViewController()
    let thumbProfImgURL = String()
//    UserDefaults.standard.value(forKey: "thumbProfImg") as! String
    let userNick = String()
//    UserDefaults.standard.value(forKey: "user_nick") as! String

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("유저디폴트 여기")
        print(UserDefaults.standard)
        
       screenBounds = self.screenRect
        
        
        let hiLabel = UILabel()
        
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.backgroundColor = .white
        mainView.showsVerticalScrollIndicator = false
        mainView.frame = CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.height)
//        mainView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height )
        mainView.backgroundColor = UIColor.white
   
     
        //main view
        
        let profileBtn = UIButton(type: .custom)
        let NickName = UILabel()
        let editProfileBtn = UIButton().then {
            $0.setTitle("내 정보 수정", for: .normal)
            $0.backgroundColor = common2.lightGray()
            $0.titleLabel?.font = common2.setFont(font: "regular", size: 13)
            $0.setTitleColor(.black, for: .normal)
            $0.addTarget(self, action: #selector(touchEditBtn), for: .touchUpInside)
        }
        let boxBtn1 = UIButton()
        let boxBtn2 = UIButton()
        let boxBtn3 = UIButton()
        let topLineView1 = UIView().then{
            $0.backgroundColor = Common.lightGray()
        }
        let bottomLineView1 = UIView().then{
            $0.backgroundColor = Common.lightGray()
        }
        let notice = UIButton()
        let banner = UIImageView()
        let shoppingTitle = UILabel()
        let shoppingIcon = UIImageView()
        
        let pointBox = UIButton()
        let couponBox = UIButton()
        let orderBox = UIButton()
        let wishBox = UIButton()
        let topLineView = UIView()
        let midLineView = UIView()
        let crossLineView = UIView()
        let bottomLineView = UIView()
        let bannerLabel = UILabel()
        let helpBtn = UIButton()
        let newBtn = UIButton()
        var scrlY = CGFloat()
        
      
       
        
        
        
        
        
        let NLibelHeight = ("1" as! NSString).size(withAttributes: [NSAttributedString.Key.font : NickName.font]).height
        let sLibelHeight = ("1" as! NSString).size(withAttributes: [NSAttributedString.Key.font : shoppingTitle.font]).height
        let blLibeHeight = ("1" as! NSString).size(withAttributes: [NSAttributedString.Key.font : bannerLabel.font]).height
        
        if  UserDefaults.standard.value(forKey: "thumbProfImg") != nil{
            print("프로필")
            if UserDefaults.standard.value(forKey: "thumbProfImg") as! String == "(null)"{
                profileBtn.setImage( UIImage(named: "profile_btn"), for: .normal)
                profileBtn.frame = CGRect(x: 27, y: margin, width: (screenBounds.width - margin * 2.0)/3.0, height: (screenBounds.width - margin * 2.0)/3.0)
                profileBtn.layer.borderWidth = 1
                profileBtn.layer.cornerRadius = profileBtn.frame.height/2
                profileBtn.clipsToBounds = true
                profileBtn.layer.borderColor = UIColor.clear.cgColor
                profileBtn.imageView?.contentMode = .scaleAspectFill
                profileBtn.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            }else{
                let thumbURL = UserDefaults.standard.value(forKey: "thumbProfImg") as! String
                let encoded = thumbURL.description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                let url = URL(string: encoded!)
                
                if url != nil {
                    let common = CommonSwift()
                    common.getData(from: url!) { [self] data, response, error in
                        guard let data = data, error == nil else { return }
                        print(response?.suggestedFilename ?? url!.lastPathComponent)
                        print("Download Finished")
                        // always update the UI from the main thread
                        DispatchQueue.main.sync() { [weak self] in
                            profileBtn.setImage(UIImage(data: data), for: .normal)
                            profileBtn.frame = CGRect(x: 27, y: margin, width: (screenBounds.width - margin * 2.0)/3.0, height: (screenBounds.width - margin * 2.0)/3.0)
                            profileBtn.layer.borderWidth = 1
                            profileBtn.layer.cornerRadius = profileBtn.frame.height/2
                            profileBtn.clipsToBounds = true
                            profileBtn.layer.borderColor = UIColor.clear.cgColor
                            profileBtn.imageView?.contentMode = .scaleAspectFill
                            profileBtn.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
                        }
                    }
                }
                print(UserDefaults.standard.value(forKey: "thumbProfImg") as! String)
            }
        }else{
            profileBtn.setImage( UIImage(named: "profile_btn"), for: .normal)
            profileBtn.frame = CGRect(x: 27, y: margin, width: (screenBounds.width - margin * 2.0)/3.0, height: (screenBounds.width - margin * 2.0)/3.0)
            profileBtn.layer.borderWidth = 1
            profileBtn.layer.cornerRadius = profileBtn.frame.height/2
            profileBtn.clipsToBounds = true
            profileBtn.layer.borderColor = UIColor.clear.cgColor
            profileBtn.imageView?.contentMode = .scaleAspectFill
            profileBtn.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }
        

  
        
    
        profileBtn.addTarget(self, action: #selector(touchProfile), for: .touchUpInside)
        print("유저 디폴트")
        
        if Foundation.UserDefaults.standard.value(forKey: "user_name") != nil{
            if Foundation.UserDefaults.standard.string(forKey: "user_name") != "(null)" {
                NickName.text = Foundation.UserDefaults.standard.value(forKey: "user_name") as? String
            }else{
                NickName.text = "샘플 털이범 님"
            }
        }else{
            NickName.text = "샘플 털이범 님"
        }
    
            
        
        NickName.font = Common.kFont(withSize: "bold", 17)
        NickName.textColor = Common.color(withHexString: "#6f6f6f")
        NickName.frame = CGRect(x: profileBtn.frame.origin.x + profileBtn.frame.size.width + margin, y: 82 - NLibelHeight * 2, width: screenBounds.width - (profileBtn.frame.origin.x + profileBtn.frame.size.width + margin*2), height: NLibelHeight)
        let nTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchNickname))
        NickName.addGestureRecognizer(nTapGestureRecognizer)
        
        
        if !UserDefaults.standard.bool(forKey: "PRDC_MODE"){
            editProfileBtn.frame = CGRect(x: NickName.frame.origin.x, y: 82, width: 80, height: 30)
        }else {
        }
  
  
        topLineView1.frame = CGRect(x: margin, y: 150, width: screenBounds.width - margin * 2, height: 2)
        bottomLineView1.frame = CGRect(x: margin, y: 210, width: screenBounds.width - margin * 2, height: 2)
        boxBtn1.setTitle("받아본 샘플", for: .normal)
        boxBtn1.titleLabel?.textAlignment = .center
        boxBtn1.titleLabel?.font = Common.kFont(withSize: "bold", 13)
        boxBtn1.setTitleColor(Common.pointColor1(), for: .normal)
        boxBtn1.frame = CGRect(x: margin, y: 160, width: (screenBounds.width-(margin * 2))/3.0 , height: 40)
        boxBtn1.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
        boxBtn1.addTarget(self, action: #selector(touchBoxBtn1), for: .touchUpInside)
        
        
        boxBtn2.setTitle("찜", for: .normal)
        boxBtn2.titleLabel?.textAlignment = .center
        boxBtn2.titleLabel?.font = Common.kFont(withSize: "bold", 13)
        boxBtn2.setTitleColor(Common.pointColor1(), for: .normal)
        boxBtn2.frame = CGRect(x: margin + (screenBounds.width-(margin * 2))/3.0, y: 160, width: (screenBounds.width-(margin * 2))/3.0 , height: 40)
        boxBtn2.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
        boxBtn2.addTarget(self, action: #selector(touchBoxBtn2), for: .touchUpInside)
        
        
        boxBtn3.setTitle("주문/배송", for: .normal)
        boxBtn3.titleLabel?.textAlignment = .center
        boxBtn3.titleLabel?.font = Common.kFont(withSize: "bold", 14)
        boxBtn3.setTitleColor(Common.pointColor1(), for: .normal)
        boxBtn3.frame = CGRect(x: margin + (screenBounds.width-(margin * 2))*2.0/3.0, y: 160, width: (screenBounds.width-(margin * 2))/3.0 , height: 40)
        boxBtn3.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
        boxBtn3.addTarget(self, action: #selector(touchBoxBtn3), for: .touchUpInside)
        
        
        notice.setTitle("공지 사장님이 미쳤나봐요 ㅜ.ㅜ...", for: .normal)
        let attributtedString = NSMutableAttributedString(string: (notice.titleLabel?.text)!)
        attributtedString.addAttribute(NSAttributedString.Key.foregroundColor, value: common.pointColor(), range: (notice.titleLabel!.text! as NSString).range(of:"공지"))
        notice.addTarget(self, action: #selector(touchNotice), for: .touchUpInside)
        notice.setAttributedTitle(attributtedString, for: .normal)
        notice.titleLabel?.textAlignment = .center
        notice.titleLabel?.font = Common.kFont(withSize: "bold", 14)
        notice.setTitleColor(Common.color(withHexString: "#000000"), for: .normal)
        notice.frame = CGRect(x: margin, y: 200 + screenBounds.width/9, width: screenBounds.width - (margin * 2), height: screenBounds.width/9)
        notice.layer.borderColor = Common.color(withHexString: "#000000").cgColor
        notice.layer.borderWidth = 1
        notice.setImage(UIImage(named: "notice_btn"), for: .normal)
        notice.semanticContentAttribute = .forceRightToLeft
        notice.imageEdgeInsets = UIEdgeInsets(top: 0,left: screenBounds.width/2 - 80,bottom: 0,right: 0)
        
        
        shoppingIcon.image = UIImage(named: "cart_s")
        shoppingIcon.contentMode = .scaleAspectFit
        shoppingIcon.frame = CGRect(x: margin, y: 250 + screenBounds.width*2/9 - 6.25 , width: 25, height: 25)
        shoppingTitle.text  = "샘플로드 쇼핑"
        shoppingTitle.textColor = Common.color(withHexString: "#000000")
        shoppingTitle.font = Common.kFont(withSize: "bold", 16)
        shoppingTitle.frame = CGRect(x: 67, y: 250 + screenBounds.width*2/9, width: 200, height: sLibelHeight)
        
        
        pointBox.setTitle("샘플 포인트 \n\n0P", for: .normal)
        pointBox.titleLabel?.font = Common.kFont(withSize: "regular", 15)
        pointBox.setTitleColor(Common.color(withHexString: "#000000"), for: .normal)
        pointBox.frame = CGRect(x: margin, y: 275 + screenBounds.width*2/9 + sLibelHeight, width: (screenBounds.width - (margin * 2))/2.0, height: 100)
        pointBox.titleLabel?.textAlignment = .left
        pointBox.titleEdgeInsets = UIEdgeInsets(top: 0,left:-(screenBounds.width - (margin * 2))/4 + 15,bottom: 0,right: 0)
        pointBox.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
        pointBox.setImage(UIImage(named: "notice_btn"), for: .normal)
        pointBox.semanticContentAttribute = .forceRightToLeft
        pointBox.imageEdgeInsets = UIEdgeInsets(top: 50,left: 0,bottom: 15,right: -(screenBounds.width - (margin * 2))/4 + 20)
        pointBox.addTarget(self, action: #selector(touchPointBox), for: .touchUpInside)
        
        
        couponBox.setTitle("쿠폰함 \n\n0개", for: .normal)
        couponBox.titleLabel?.font = Common.kFont(withSize: "regular", 15)
        couponBox.setTitleColor(Common.color(withHexString: "#000000"), for: .normal)
        couponBox.frame = CGRect(x: margin +  (screenBounds.width - (margin * 2))/2.0, y: 275 + screenBounds.width*2/9 + sLibelHeight, width: (screenBounds.width - (margin * 2))/2.0, height: 100)
        couponBox.titleLabel?.textAlignment = .left
        couponBox.titleEdgeInsets = UIEdgeInsets(top: 0,left:-(screenBounds.width - (margin * 2))/4 + 15,bottom: 0,right: 0)
        couponBox.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
        couponBox.setImage(UIImage(named: "notice_btn"), for: .normal)
        couponBox.semanticContentAttribute = .forceRightToLeft
        couponBox.imageEdgeInsets = UIEdgeInsets(top: 50,left: 0,bottom: 15,right: -(screenBounds.width - (margin * 2))/4 - 15)
        couponBox.addTarget(self, action: #selector(touchCouponBox), for: .touchUpInside)
        newBtn.setImage(UIImage(named: "new"), for: .normal )
        newBtn.frame = CGRect(x: couponBox.frame.width/4 + 10, y: couponBox.frame.size.height/4 - 10, width: 30 , height: 30)
        newBtn.contentMode = .scaleAspectFit
        
        
        orderBox.setTitle("주문/배송", for: .normal)
        orderBox.titleLabel?.font = Common.kFont(withSize: "regular", 15)
        orderBox.setTitleColor(Common.color(withHexString: "#000000"), for: .normal)
        orderBox.frame = CGRect(x: margin, y: 375 + screenBounds.width*2/9 + sLibelHeight, width: (screenBounds.width - (margin * 2))/2.0, height: 50)
        orderBox.titleLabel?.textAlignment = .left
        orderBox.titleEdgeInsets = UIEdgeInsets(top: 0,left:-(screenBounds.width - (margin * 2))/4 ,bottom: 0,right: 0)
        orderBox.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
        orderBox.setImage(UIImage(named: "notice_btn"), for: .normal)
        orderBox.semanticContentAttribute = .forceRightToLeft
        orderBox.imageEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: -(screenBounds.width - (margin * 2))/4 + 5)
        orderBox.addTarget(self, action: #selector(touchOrderBox), for: .touchUpInside)
        
        
        wishBox.setTitle("찜한 상품", for: .normal)
        wishBox.titleLabel?.font = Common.kFont(withSize: "regular", 15)
        wishBox.setTitleColor(Common.color(withHexString: "#000000"), for: .normal)
        wishBox.frame = CGRect(x: margin +  (screenBounds.width - (margin * 2))/2.0, y: 375 + screenBounds.width*2/9 + sLibelHeight, width: (screenBounds.width - (margin * 2))/2.0, height: 50)
        wishBox.titleLabel?.textAlignment = .left
        wishBox.titleEdgeInsets = UIEdgeInsets(top: 0,left:-(screenBounds.width - (margin * 2))/4 + 15,bottom: 0,right: 0)
        wishBox.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
        wishBox.setImage(UIImage(named: "notice_btn"), for: .normal)
        wishBox.semanticContentAttribute = .forceRightToLeft
        wishBox.imageEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: -(screenBounds.width - (margin * 2))/4 )
        wishBox.addTarget(self, action: #selector(touchWishBox), for: .touchUpInside)
        
        
        topLineView.backgroundColor = Common.lightGray()
        topLineView.frame = CGRect(x: margin, y: 275 + screenBounds.width*2/9 + sLibelHeight, width: screenBounds.width - (margin * 2), height: 2)
        
        
        midLineView.backgroundColor = Common.lightGray()
        midLineView.frame = CGRect(x: margin, y: 375 + screenBounds.width*2/9 + sLibelHeight, width: screenBounds.width - (margin * 2), height: 2)
        
        crossLineView.backgroundColor = Common.lightGray()
        crossLineView.frame = CGRect(x: (screenBounds.size.width - (margin * 2))/2.0 + margin, y: 275 + screenBounds.width*2/9 + sLibelHeight, width: 2 , height: 150)
        
        
        scrlY = wishBox.frame.origin.y + wishBox.frame.size.height
        bottomLineView.backgroundColor = Common.lightGray()
        bottomLineView.frame = CGRect(x:  0, y: scrlY , width: screenBounds.width, height: 7)
        
        
        
        scrlY = wishBox.frame.origin.y + wishBox.frame.size.height
//        banner.backgroundColor = Common.pointColor1()
//        banner.frame = CGRect(x: 0, y: scrlY + 7, width: screenBounds.size.width, height:  screenBounds.size.width )
//        banner.addSubview(bannerLabel)
//
//
//        bannerLabel.text = "AI 분석결과"
//        bannerLabel.textColor = UIColor.white
//        bannerLabel.font = Common.kFont(withSize: "bold", 30)
//        bannerLabel.frame = CGRect(x: margin, y: margin, width: view.frame.size.width - margin, height: blLibeHeight + 10)
//
//
//
//        scrlY = banner.frame.origin.y + banner.frame.size.height
        backgroundView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: scrlY)
        mainView.contentSize = CGSize(width: view.frame.size.width, height: scrlY)
      
        backgroundView.addSubview(mainView)
        view.addSubview(backgroundView)
//        self.view.addSubview(helpBtn)
        if !UserDefaults.standard.bool(forKey: "PRDC_MODE"){
            [topLineView1,bottomLineView1].forEach{
                mainView.addSubview($0)
            }
            mainView.addSubview(boxBtn1)
            mainView.addSubview(boxBtn2)
            mainView.addSubview(boxBtn3)
            boxBtn1.setTitle("로그아웃", for: .normal)
            boxBtn2.setTitle("탈퇴", for: .normal)
        }else{
            [topLineView1,bottomLineView1].forEach{
                mainView.addSubview($0)
            }
            mainView.addSubview(profileBtn)
            mainView.addSubview(NickName)
            if UserDefaults.standard.bool(forKey: "PRDC_MODE"){
                mainView.addSubview(editProfileBtn)
            }
            mainView.addSubview(boxBtn1)
            mainView.addSubview(boxBtn2)
            mainView.addSubview(boxBtn3)
            mainView.addSubview(notice)
            mainView.addSubview(banner)
            mainView.addSubview(shoppingIcon)
            mainView.addSubview(shoppingTitle)
            mainView.addSubview(pointBox)
            mainView.addSubview(couponBox)
            mainView.addSubview(orderBox)
            mainView.addSubview(wishBox)
            mainView.addSubview(topLineView)
            mainView.addSubview(midLineView)
            mainView.addSubview(crossLineView)
            mainView.addSubview(bottomLineView)
            couponBox.addSubview(newBtn)
        }
    }
    
    @objc func touchEditBtn(){
        navi?.pushViewController(EditProfileViewController(), animated: true)
    }
    
    @objc func touchProfile(){
        let alert = UIAlertController(title: "", message: "준비 중 입니다", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    
                }
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
        Common.vibrate(1)
    }
    
    @objc func touchNickname(){
        let alert = UIAlertController(title: "", message: "준비 중 입니다", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    
                }
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
        Common.vibrate(1)
        
    }
    
    @objc func touchBoxBtn1(){
        if !UserDefaults.standard.bool(forKey: "PRDC_MODE") {
            UserDefaults.standard.set(false, forKey: "auto_login")
            UserDefaults.standard.removeObject(forKey: "kakao_token")
            UserDefaults.standard.removeObject(forKey: "naver_token")
            //네이버 로그아웃
            loginInstance?.requestDeleteToken()
            navi?.pushViewController(SplashViewController(), animated: false)
        }else {
            let alert = UIAlertController(title: "", message: "준비 중 입니다", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in

                    }
            alert.addAction(okAction)
            present(alert, animated: false, completion: nil)
            Common.vibrate(1)
        }
      
    }
    
    @objc func touchBoxBtn2(){
        if !UserDefaults.standard.bool(forKey: "PRDC_MODE") {
            let alert = UIAlertController(title: "회원탈퇴를 하시겠습니까?\n샘플로드의 모든 사용자 데이터가 삭제됩니다", message: "", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "YES", style: .default){ action in
                self.deleteUser()
            }
            let noAction = UIAlertAction(title: "NO", style: .default)
            alert.addAction(okAction)
            alert.addAction(noAction)
            present(alert, animated: false, completion: nil)
            Common.vibrate(1)
      
        }else {
            let alert = UIAlertController(title: "", message: "준비 중 입니다", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "YES", style: .default){ action in
                
            }
            alert.addAction(okAction)
            present(alert, animated: false, completion: nil)
            Common.vibrate(1)
        }
     
    }
    
    @objc func touchBoxBtn3(){
        navi?.pushViewController(DeliveryListViewController(), animated: true)
    }
    @objc func touchNotice(){
        Common.vibrate(1)
    }
    @objc func touchPointBox(){
        let alert = UIAlertController(title: "", message: "준비 중 입니다", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    
                }
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
        Common.vibrate(1)
    }
    @objc func touchCouponBox(){
        let alert = UIAlertController(title: "", message: "준비 중 입니다", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    
                }
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
        Common.vibrate(1)
    }
    
    
    @objc func touchOrderBox(){
        let vc = DeliveryListViewController()
        navi?.pushViewController(vc, animated: true)
    }
    @objc func touchWishBox(){
        
        let alert = UIAlertController(title: "", message: "준비 중 입니다", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    
                }
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
        Common.vibrate(1)
    }
    
    @objc func touchHelpBtn(){
        let alert = UIAlertController(title: "", message: "준비 중 입니다", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    
                }
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
        Common.vibrate(1)
    }
    
     func moveNextVC(_sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier:"deliveryVc")else{return}
         navi?.pushViewController(nextVC, animated: true)
         Common.vibrate(1)
    }
    func deleteUser(){
        self.common.sendRequest(url: "https://api.clayful.io/v1/customers/\(UserDefaults.standard.string(forKey: "customer_id")!)", method: "delete", params: [:], sender: "") { resultJson in
            self.deleteUserDB()
        }
    }
    func deleteUserDB(){
        self.common.sendRequest(url: "http://110.165.17.124/sampleroad/db/user.php", method: "post", params: ["customer_id": customerId2,"delete": 1], sender:"" ) { resultJson in
            print("삭제됨")
            //네이버 로그아웃
            self.loginInstance?.requestDeleteToken()
            for key in UserDefaults.standard.dictionaryRepresentation().keys {
                        UserDefaults.standard.removeObject(forKey: key.description)
                    }
            self.navi?.pushViewController(SplashViewController(), animated: false)
            Common.alert("회원탈퇴가 완료되었습니다")
        }
    }



}
