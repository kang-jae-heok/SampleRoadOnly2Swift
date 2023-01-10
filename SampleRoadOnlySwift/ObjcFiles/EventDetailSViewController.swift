//
//  HomeWork2ViewController.swift
//  sampleroad
//
//  Created by NOTEGG on 2022/07/04.
//  Copyright © 2022 CNKANG. All rights reserved.
//

import UIKit

@objc class EventDetailSViewController: UIViewController {
    
    let screenBounds = UIScreen.main.bounds
    let margin = 17.0
    let innerMargin = 22.0
    var eventId = String()
    var eventTitle = String()
    var eventRegist = String()
    var actionUrl = String()
    var index = 0
    let customerId =  UserDefaults.standard.string(forKey: "customer_id") ?? ""
    @objc init(initDic: [String:Any]) {
        print("EventDetailSViewController  dic")
        print(initDic)
        self.eventId = initDic["event_id"] as! String
        self.eventTitle = initDic["event_title"] as! String
        self.eventRegist = initDic["event_regist"] as! String
        self.actionUrl = initDic["event_action"] as? String ?? ""
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    let backBtn = UIButton()
    let titleLabel = UILabel()
    let bookMarkBtn = UIButton()
    let shareBtn = UIButton()
    let subTitleLabel = UILabel()
    let bannerImg = UIImageView()
    let bannerImg2 = UIImageView()
    let warningLabel = UILabel()
    let submitBtn = UIButton()
    let helpBtn = UIButton()
    let topView = UIView()
    let bottomView = UIView()
    let scrollView = UIScrollView()
    let timeLabel = UILabel()
    var bannerArr = [String]()
    var scrollViewY = CGFloat()
    var height = 0.0
    
    
    //    override func viewWillAppear(_ animated: Bool) {
    //
    //        print("왜안됨")
    //        selectImg()
    //        super.viewWillAppear(animated)
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(topView)
        view.addSubview(bottomView)
        getEventInfo()
        view.backgroundColor = UIColor.white
        topView.addSubview(backBtn)
        topView.addSubview(titleLabel)
        topView.addSubview(bookMarkBtn)
        topView.addSubview(shareBtn)
        
        bottomView.addSubview(subTitleLabel)
        //        scrollView.addSubview(bannerImg)
        bottomView.addSubview(scrollView)
        bottomView.addSubview(warningLabel)
        bottomView.addSubview(submitBtn)
        bottomView.addSubview(timeLabel)
        
        
        let backImage = UIImage(named: "back_btn")
       
//        UIImage(named: "bookmark_on_btn")
//        UIImage(named: "bookmark_off_btn")
        let bannerImage = UIImage(named: "event1")
        
        let hImage = UIImage(named: "help_btn")
        topView.frame = CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.width/4)
        bottomView.frame = CGRect(x: 0, y: screenBounds.width/4, width: screenBounds.width, height: screenBounds.height - screenBounds.width/4)
        
        
        
        
        backBtn.setImage(backImage, for: .normal)
        backBtn.frame = CGRect(x: margin, y: screenBounds.width/6 , width: (backImage?.size.width)!, height: (backImage?.size.height)!)
        backBtn.contentMode = .scaleAspectFit
        backBtn.tintColor = Common.color(withHexString: "#97C5E9")
        backBtn.addTarget(self, action: #selector(touchBackBtn), for: .touchUpInside)
        titleLabel.text = "이벤트"
        titleLabel.font = Common.kFont(withSize: "bold", 20)
        titleLabel.textColor = Common.color(withHexString: "#97C5E9")
        titleLabel.frame = CGRect(x: screenBounds.width/2 - 30, y: screenBounds.width/6, width: 80, height: titleLabel.font.pointSize)
        timeLabel.sizeToFit()
        timeLabel.textAlignment = .left
     
        bookMarkBtn.contentMode = .scaleAspectFit
        bookMarkBtn.addTarget(self, action: #selector(touchBookMark), for: .touchUpInside)
        shareBtn.setImage(UIImage(named: "share_btn"), for: .normal)
        shareBtn.contentMode = .scaleAspectFit
        shareBtn.isHidden = false
      
        shareBtn.tintColor = Common.color(withHexString: "#97C5E9")
        shareBtn.addTarget(self, action: #selector(touchShareBtn), for: .touchUpInside)
        subTitleLabel.text = eventTitle
        subTitleLabel.textColor = Common.color(withHexString: "6f6f6f")
        subTitleLabel.font = Common.kFont(withSize: "bold", 16)
        subTitleLabel.frame = CGRect(x: margin, y: margin, width: screenBounds.width, height: subTitleLabel.font.pointSize)
        
        let toDate = toDate(stringDate: eventRegist)
        
        
        timeLabel.text = toDate
        timeLabel.textColor = Common.color(withHexString: "9f9f9f")
        timeLabel.font = Common.kFont(withSize: "regular", 12)
        timeLabel.frame = CGRect(x: margin, y: margin + 20 + subTitleLabel.font.pointSize, width: screenBounds.width, height: titleLabel.font.pointSize)
        warningLabel.text = "본 컨텐츠에는 간접광고가 포함되어 있습니다"
        warningLabel.textColor = Common.color(withHexString: "9f9f9f")
        warningLabel.font = Common.kFont(withSize: "regular", 10)
        
        warningLabel.frame = CGRect(x: screenBounds.width/2 - 110, y: 67+subTitleLabel.font.pointSize + timeLabel.font.pointSize, width: 200, height: warningLabel.font.pointSize)
        warningLabel.center.x = self.bottomView.center.x
        
        bannerImg.backgroundColor = UIColor.lightGray
        
        
        
        
        bannerImg.contentMode = .scaleToFill
        submitBtn.backgroundColor = Common.color(withHexString: "#97C5E9")
        submitBtn.setTitle("신청하기", for: .normal)
        
        submitBtn.frame = CGRect(x: margin, y: bottomView.frame.height - screenBounds.width/4, width: screenBounds.width - (margin * 2), height: screenBounds.width/8)
        submitBtn.layer.cornerRadius = 8
        submitBtn.titleLabel?.font = Common.kFont(withSize: "medium", 16)
        submitBtn.titleLabel?.textColor = UIColor.white
        submitBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        submitBtn.addTarget(self, action: #selector(touchSubmitBtn), for: .touchUpInside)
        helpBtn.setImage(hImage, for: .normal)
        helpBtn.frame = CGRect(x: screenBounds.width - margin - 72, y: bottomView.frame.height - screenBounds.width/4 - 72, width: 72, height: 72)
        helpBtn.addTarget(self, action: #selector(touchHelpBtn), for: .touchUpInside)
        helpBtn.contentMode = .scaleAspectFit
        helpBtn.isHidden = true
        //
        //        let testLabel = UILabel()
        //
        //        scrollView.addSubview(testLabel)
        //        testLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        //        testLabel.text = "테스트입니다"
        //        testLabel.textColor = .yellow
        //        testLabel.font = Common.kFont(withSize: "bold", 20)
        
        //
        print("배열")
        print(bannerArr)
        
        
        
        
        bottomView.addSubview(helpBtn)
        
        scrollView.frame = CGRect(x:margin, y: warningLabel.frame.origin.y + warningLabel.font.pointSize + 20.0, width: screenBounds.width - (margin * 2), height: bottomView.frame.size.height - warningLabel.frame.origin.y - warningLabel.font.pointSize - screenBounds.width/4)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        
        
//        getEventDic()
        
        // Do any additional setup after loading the view.
    }
//    func getEventDic() {
//        var params = [String:Any]()
//        params.updateValue(customerId2, forKey: "customer_id")
//        params.updateValue(eventId, forKey: "event_id")
//        common2.sendRequest(url: "http://110.165.17.124/sampleroad/v1/event.php", method: "post", params: params, sender: "") { resultJson in
//            print("###resultJson")
//            guard let resultDic = resultJson as? [String:Any],
//                  let eventDic = resultDic["event"] as? [String:Any],
//                  let eventTitle = eventDic["event_title"] as? String,
//                  let eventRegister = eventDic["event_register"] as? String,
//                  let eventLimit = eventDic["event_limit"] as? Int,
//                  let eventImage = eventDic["event_image"] as? String,
//                  let eventAction = eventDic["event_action"] as? String
//            else {return}
//            self.eventTitle = eventTitle + "test"
//            self.eventRegist = eventRegister
//            self.actionUrl = eventAction
//            self.setData()
//        }
//    }
//    func setData(){
//        subTitleLabel.text = "아아아ㅏ"
//    }
    func getEventInfo(){
        var params = [String:Any]()
        params = ["customer_id":customerId,"event_id":eventId]
        common2.sendRequest(url: "http://110.165.17.124/sampleroad/v1/event.php", method: "post", params: params, sender: "") { [self] resultJson in
            guard let result = resultJson as? [String:Any] else {return}
            guard let errorCode = result["pick"] as? String,
                  let image = result["image"] as? String
            else {return}
            setImageUrl(urlArrStr: image)
            if errorCode == "0" {
                self.bookMarkBtn.setImage(UIImage(named: "bookmark_off_btn"), for: .normal)
            }else if errorCode == "1" {
                self.bookMarkBtn.setImage(UIImage(named: "bookmark_on_btn"), for: .normal)
            }
            let shareImage = UIImage(named: "share_btn")
            bookMarkBtn.frame = CGRect(x: screenBounds.width-margin - (bookMarkBtn.imageView?.image?.size.width)!, y: screenBounds.width/6, width: (bookMarkBtn.imageView?.image!.size.width)!, height:  (bookMarkBtn.imageView?.image!.size.height)!)
            shareBtn.frame = CGRect(x: bookMarkBtn.frame.origin.x - ((shareImage?.size.width)!) - 20, y: screenBounds.width/6, width: (shareImage?.size.width)!, height: (shareImage?.size.height)!)
        }
    }
    func setImageUrl(urlArrStr: String){
        bannerArr = urlArrStr.components(separatedBy: ",")
        let imgUrl = "http://110.165.17.124/sampleroad/images/\(eventId)/\(bannerArr[index])"
        let encoded = imgUrl.description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        downloadImage(from: encoded!, tag: index)
    }
    func downloadImage(from url: String, tag: Int) {
        print("Download Started")
        let common = CommonSwift()
        let imageView = UIImageView()
        
        let cacheKey = NSString(string: url) // 캐시에 사용될 Key 값
        
        
        print("not")
        DispatchQueue.global(qos: .background).async {
            if let imageUrl = URL(string: url) {
                URLSession.shared.dataTask(with: imageUrl) { (data, res, err) in
                    if let _ = err {
                        DispatchQueue.main.sync { [self] in
                            imageView.image = UIImage()
                        }
                        return
                    }
                    DispatchQueue.main.async { [self] in
                        if let data = data, let image = UIImage(data: data) {
                            imageView.image = image
                            let imgRatio = (imageView.image?.size.width)!/(screenBounds.width - (margin * 2))
                            let imgHeight = (imageView.image?.size.height)! / imgRatio
                            
                            imageView.tag = tag
                            scrollView.addSubview(imageView)
                            
                            imageView.frame = CGRect(x: 0, y: height, width: screenBounds.width - (margin * 2), height: imgHeight)
                            
                            scrollView.contentSize = CGSize(width: screenBounds.width - (margin * 2) , height: imgHeight + height + 50)
                            //                if tag == self!.bannerArr.count - 1{
                            //
                            //
                            //                    let sub = self!.scrollView.subviews
                            //                }
                            height += imgHeight
                            index += 1
                            if index <= bannerArr.count - 1 {
                                let imgUrl = "http://110.165.17.124/sampleroad/images/\(eventId)/\(bannerArr[index])"
                                let encoded = imgUrl.description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                                downloadImage(from: encoded!, tag: index)
                            }
                        }
                    }
                }.resume()
            }
        }
        
        
        
        
        
        
        
        
        
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    @objc func touchSubmitBtn(){
        if let url = URL(string: actionUrl) {
            UIApplication.shared.open(url)
        }else{
            let commonS = CommonS()
            present(commonS.alert(title: "", message: "no URl"), animated: true)
            
        }
        
        
    }
    
    @objc func touchBookMark(){
//        if bookMarkBtn.imageView?.image == UIImage(named: "bookmark_off_btn") {
//            bookMarkBtn.setImage(UIImage(named: "bookmark_on_btn"), for: .normal)
//        }else {
//            bookMarkBtn.setImage(UIImage(named: "bookmark_off_btn"), for: .normal)
//        }
        var params = [String:Any]()
        params = [
            "customer_id":customerId,
            "event_id":eventId,
            "update":"1"
        ]
        common2.sendRequest(url: "http://110.165.17.124/sampleroad/v1/event.php", method: "post", params: params, sender: "") { resultJson in
            print(resultJson)
            guard let result = resultJson as? [String:Any] else {return}
            print(result)
            guard let errorCode = result["error"] as? String else {return}
            if errorCode == "1" {
                self.bookMarkBtn.setImage(UIImage(named: "bookmark_on_btn"), for: .normal)
            }else if errorCode == "2" {
                self.bookMarkBtn.setImage(UIImage(named: "bookmark_off_btn"), for: .normal)
            }
        }
    }
    @objc func touchBackBtn(){
        self.navigationController?.popViewController(animated: true)
        Common.vibrate(1)
    }
    @objc func touchShareBtn(){
       
        let shareText: String = "http://110.165.17.124/event.html?event=\(eventId)"
        common2.makeShortUrl(url: shareText) { URL in
            var shareObject = [Any]()
            
            shareObject.append(URL)
            
            let activityViewController = UIActivityViewController(activityItems : shareObject, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            
            //activityViewController.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook,UIActivity.ActivityType.postToTwitter,UIActivity.ActivityType.mail]
            
            self.present(activityViewController, animated: true, completion: nil)
        }

        
    }
    
    @objc func toDate(stringDate: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let convertDate = dateFormatter.date(from: stringDate)
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyy MM dd"
        let convertStr = myDateFormatter.string(from: convertDate!)
        return convertStr
        
    }
    @objc func touchHelpBtn(){
        Common.safariOpenURL("http://pf.kakao.com/_TKqIxj/chat")
        Common.vibrate(1)
    }
    
}
