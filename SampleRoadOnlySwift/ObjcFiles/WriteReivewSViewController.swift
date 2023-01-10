//
//  WriteReivewSViewController.swift
//  sampleroad
//
//  Created by NOTEGG on 2022/07/12.
//  Copyright © 2022 CNKANG. All rights reserved.
//

import UIKit
import PhotosUI



@objc class WriteReivewSViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
    
    let margin = 17.0
    let innerMargin = 22.0
    
    override func viewWillAppear(_ animated: Bool) {
        self.addKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardNotifications()
    }
    
    var dic  = Dictionary<String, Any>()
    
    
    @objc init(dic: Dictionary<String, Any>) {
        self.dic = dic
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var reviewDic  = Dictionary<String, Any>()
    
    
    let screenBounds = UIScreen.main.bounds
    let topView = UIView()
    let titleLabel = UILabel()
    let backBtn = UIButton()
    let registerBtn = UIButton()
    //    var picker = ELCImagePickerController(imagePicker: ()
    let imagePicker = UIImagePickerController()
    let goodView = UIView()
    let badView = UIView()
    
    
    let backgroundView = UIView()
    let scrollView = UIScrollView()
    let imageView = UIImageView()
    let productTit = UILabel()
    let changeBtn = UIButton()
    let topLineView = UIView()
    let starTit = UILabel()
    let botomLineView = UIView()
    let goodSmileImgView = UIImageView()
    let goodTit = UILabel()
    let goodEditText = UITextView()
    let badSmaileImgView = UIImageView()
    let badTit = UILabel()
    let badEditText = UITextView()
    let cameraImgView = UIImageView()
    let pictureTit = UILabel()
    let noticeLabel = UILabel()
    let addGuideBtn = UIButton()
    let addNormalBtn = UIButton()
    let botomEditText = UITextView()
    var scrlY = CGFloat()
    let placeholder1 = UILabel()
    let placeholder2 = UILabel()
    let placeholder3 = UILabel()
    var ratingView = HCSStarRatingView()
    let letterNumLabel = UILabel()
    let letterNumLabel2 = UILabel()
    var keyHeight = NSLayoutConstraint()
    let trashView = UIView()
    var keyboardHeight = CGFloat()
    var imgId = [String]()
    let alertViewController = UIViewController()
    let alertView = UIView()
    let confirmAlertVieController = UIViewController()
    let confirmAlertView = UIView()
    let simpleEditLbl = UILabel().then {
        $0.text = "한줄평"
        $0.font = Common.kFont(withSize: "bold", 13)
    }
    let simpleEditText = UITextField().then {
        $0.backgroundColor = Common.color(withHexString: "#e6e6e6")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reviewDic = dic
        print("여기")
        print(reviewDic)
        [simpleEditLbl,simpleEditText].forEach{
            scrollView.addSubview($0)
        }
        scrollView.addSubview(imageView)
        scrollView.addSubview(productTit)
        scrollView.addSubview(changeBtn)
        scrollView.addSubview(topLineView)
        scrollView.addSubview(starTit)
        scrollView.addSubview(botomLineView)
        scrollView.addSubview(goodSmileImgView)
        scrollView.addSubview(goodTit)
        goodView.addSubview(goodEditText)
        scrollView.addSubview(badSmaileImgView)
        scrollView.addSubview(badTit)
        badView.addSubview(badEditText)
        scrollView.addSubview(cameraImgView)
        scrollView.addSubview(pictureTit)
        scrollView.addSubview(addGuideBtn)
        scrollView.addSubview(addNormalBtn)
        scrollView.addSubview(botomEditText)
        scrollView.addSubview(noticeLabel)
        scrollView.addSubview(goodView)
        scrollView.addSubview(badView)
        scrollView.addSubview(trashView)
        
        
        //
        //        screenBounds = self.screenRect
        
        topView.addSubview(backBtn)
        topView.addSubview(registerBtn)
        topView.addSubview(titleLabel)
        
        
        
        
        
        topView.frame = CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.height/7)
        topView.backgroundColor = UIColor.white
        
        
        
        let backImg = UIImage(named: "back_btn")
        backBtn.setImage(backImg, for: .normal)
        backBtn.frame = CGRect(x: 20, y: topView.frame.height/2.0, width: 50, height: (margin * 2))
        backBtn.contentMode = .scaleAspectFit
        backBtn.addTarget(self, action: #selector(touchBackBtn), for: .touchUpInside)
        
        
        let tLibelHeight = ("1" as! NSString).size(withAttributes: [NSAttributedString.Key.font : titleLabel.font]).height
        let hLabelHeight = ("1" as! NSString).size(withAttributes: [NSAttributedString.Key.font : productTit.font]).height
        let sLabelHeight = ("1" as! NSString).size(withAttributes: [NSAttributedString.Key.font : starTit.font]).height
        let gLabelHeight = ("1" as! NSString).size(withAttributes: [NSAttributedString.Key.font : goodTit.font]).height
        let p1LabelHeight = ("1" as! NSString).size(withAttributes: [NSAttributedString.Key.font : placeholder1.font]).height
        let p2LabelHeight = ("1" as! NSString).size(withAttributes: [NSAttributedString.Key.font : placeholder2.font]).height
        let p3LabelHeight = ("1" as! NSString).size(withAttributes: [NSAttributedString.Key.font : placeholder3.font]).height
        let lLabelHeight = ("1" as! NSString).size(withAttributes: [NSAttributedString.Key.font : letterNumLabel.font]).height
        
        titleLabel.text = "리뷰쓰기"
        titleLabel.textColor = Common.color(withHexString: "#97C5E9")
        titleLabel.font = Common.kFont(withSize: "bold", 20)
        
        titleLabel.frame = CGRect(x: screenBounds.width/2 - 42, y: topView.frame.height/2 - (tLibelHeight/2) + margin, width: 85, height: tLibelHeight + 5)
        
        registerBtn.setTitle("등록", for: .normal)
        registerBtn.setTitleColor(Common.pointColor1(), for: .normal)
        registerBtn.titleLabel?.font = Common.kFont(withSize: "bold", 15)
        registerBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        registerBtn.frame = CGRect(x: screenBounds.width-75, y: topView.frame.height/2.0 , width: 50, height: (margin * 2))
        registerBtn.contentMode = .scaleAspectFit
        registerBtn.addTarget(self, action: #selector(touchRegisterBtn), for: .touchUpInside)
        
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        
        
        
        
        imageView.contentMode = .scaleAspectFit
        let thumbnail = reviewDic["thumbnail"] as! [String:Any]
        let thumbnailUrl = thumbnail["url"] as! String
        let encoded = thumbnailUrl.description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: encoded!)
        
        if url != nil {
            let common = CommonSwift()
            common.getData(from: url!) { [self] data, response, error in
                guard let data = data, error == nil else { return }
                print(response?.suggestedFilename ?? url!.lastPathComponent)
                print("Download Finished")
                // always update the UI from the main thread
                DispatchQueue.main.sync() { [weak self] in
                    imageView.image = UIImage(data: data)
                    
                }
            }
        }
        imageView.frame = CGRect(x: margin, y: 0, width: screenBounds.size.width/4, height:  screenBounds.size.width/3)
        imageView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        
        
        
        
        productTit.text = (reviewDic["name"] as! String)
        productTit.font = Common.kFont(withSize: "bold", 12)
        productTit.frame = CGRect(x: imageView.frame.origin.x + imageView.frame.width + 10, y: imageView.frame.origin.y + imageView.frame.height/2 - productTit.font.pointSize/2, width: screenBounds.width - (imageView.frame.origin.x + screenBounds.size.width/4 + 10), height: hLabelHeight)
        
        scrlY = productTit.frame.origin.y + hLabelHeight
        
        
        
        changeBtn.setTitle("제품변경", for: .normal)
        changeBtn.isHidden = true
        
        changeBtn.layer.borderColor = Common.color(withHexString: "#f0f0f0").cgColor
        changeBtn.layer.borderWidth = 1
        changeBtn.layer.cornerRadius = 2
        changeBtn.setTitleColor(Common.color(withHexString: "#6f6f6f"), for: .normal)
        changeBtn.backgroundColor = UIColor.white
        changeBtn.titleLabel?.font = Common.kFont(withSize: "medium", 12)
        changeBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        changeBtn.frame = CGRect(x: imageView.frame.origin.x + imageView.frame.width + 10, y: scrlY + 10, width: screenBounds.width/5, height: (screenBounds.width/5)/2.5)
        changeBtn.addTarget(self, action: #selector(touchChangeBtn), for: .touchUpInside)
        
        scrlY = imageView.frame.origin.y +  screenBounds.size.width/3
        
        
        topLineView.backgroundColor = Common.color(withHexString: "#e6e6e6")
        topLineView.frame = CGRect(x: margin, y: scrlY, width: screenBounds.width - (margin * 2), height: 3)
        
        
        scrlY = imageView.frame.origin.y +  screenBounds.size.width/3 + 23
        
        starTit.text = "평점을 선택해주세요."
        starTit.font = Common.kFont(withSize: "bold", 13)
        starTit.frame = CGRect(x: screenBounds.width/2  - 50, y: scrlY, width: 120, height: sLabelHeight)
        
        
        scrlY = starTit.frame.origin.y +  sLabelHeight
        
        //        HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(rView.frame.size.width/2 - ratingSize.width/2, lbl.frame.origin.y+lbl.frame.size.height+6.0, ratingSize.width, ratingSize.height)];
        //        [starRatingView setBackgroundColor:[UIColor clearColor]];
        //        starRatingView.maximumValue = 5;
        //        starRatingView.minimumValue = 0;
        //        starRatingView.value = 4;
        //        starRatingView.tintColor = [Common colorWithHexString:@"ffbc00"];
        //        starRatingView.starBorderColor = [UIColor clearColor];
        //        starRatingView.emptyStarColor = [Common lightGray];
        //        starRatingView.allowsHalfStars = YES;
        //        [starRatingView setSpacing:1.0];
        //        [starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
        
        ratingView.frame = CGRect(x: screenBounds.width/2 - (starTit.frame.size.width + 60)/2, y: scrlY  , width: starTit.frame.size.width + 60 , height: 50)
        ratingView.backgroundColor = UIColor.clear
        ratingView.maximumValue = 5
        ratingView.minimumValue = 0
        ratingView.value = 4
        ratingView.tintColor = Common.color(withHexString: "#ffbc00")
        ratingView.starBorderColor = UIColor.clear
        ratingView.emptyStarColor = UIColor.lightGray
        ratingView.allowsHalfStars = false
        //        ratingView.addTarget(Self, action: #selector(didChangeValue(forKey:)), for: UIControlEvent)
        
        
        
        
        
        
        scrollView.addSubview(ratingView)
        scrollView.backgroundColor = .white
        
        botomLineView.backgroundColor = Common.color(withHexString: "#e6e6e6")
        botomLineView.frame = CGRect(x: margin, y: imageView.frame.origin.y +  screenBounds.size.width/3 + 3 + screenBounds.width/4, width: screenBounds.width - (margin * 2), height: 3)
        
        
        scrlY = botomLineView.frame.origin.y + 3  + screenBounds.width/16 - gLabelHeight/2
        
        simpleEditLbl.frame = CGRect(x: margin, y: scrlY, width: screenBounds.width, height: simpleEditLbl.font.pointSize)
        simpleEditText.frame = CGRect(x: margin, y: scrlY + margin, width: screenBounds.width - margin * 2, height: 40)
        simpleEditText.addLeftPadding()
        simpleEditText.font = common2.setFont(font: "bold", size: 13)
        scrlY = simpleEditText.frame.origin.y + 40.0 + margin
        goodSmileImgView.image = UIImage(named: "good_btn")
        goodSmileImgView.frame = CGRect(x: margin, y: scrlY, width: 20, height: 20)
        
        
        
        goodTit.text = "좋았던 점(최소 10자 이상)"
       
        let fullText = goodTit.text ?? ""
        let attribtuedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: "(최소 10자 이상)")
        attribtuedString.addAttribute(.foregroundColor, value: Common.color(withHexString: "#6f6f6f"), range: range)
        attribtuedString.addAttribute(.font, value: Common.kFont(withSize: "normal", 13), range: range)
        goodTit.attributedText = attribtuedString
//        scrlY = goodSmileImgView.frame.origin.y + 20.0 + margin
//        scrlY = goodSmileImgView.frame.origin.y + 20.0 + margin
        goodTit.frame = CGRect(x: 57, y: scrlY, width: screenBounds.width - 57, height: gLabelHeight)
        goodTit.font = Common.kFont(withSize: "bold", 13)
        
        
        scrlY = goodSmileImgView.frame.origin.y + 20.0 + margin
        goodView.frame = CGRect(x: margin, y: scrlY, width: screenBounds.width - (margin * 2), height: screenBounds.width/3)
        goodEditText.frame = CGRect(x: 0, y: 0, width: screenBounds.width - (margin * 2), height: screenBounds.width/3)
        goodEditText.backgroundColor = Common.color(withHexString: "#e6e6e6")
        goodEditText.delegate = self
        goodEditText.showsVerticalScrollIndicator = false
        goodEditText.showsHorizontalScrollIndicator = false
        letterNumLabel.frame = CGRect(x: goodEditText.frame.size.width - 60 , y: goodEditText.frame.height - lLabelHeight , width: 80, height: lLabelHeight)
        placeholderSetting()
        
        scrlY = goodView.frame.origin.y + screenBounds.width/3  + screenBounds.width/16 - gLabelHeight/2
        
        
        
        badSmaileImgView.image = UIImage(named: "bad_btn")
        badSmaileImgView.frame = CGRect(x: margin, y: scrlY, width: 20, height: 20)
        
        
        
        badTit.text = "아쉬운 점(최소 10자 이상)"
        
        let fullText2 = badTit.text ?? ""
        let attribtuedString2 = NSMutableAttributedString(string: fullText2)
        let range2 = (fullText2 as NSString).range(of: "(최소 10자 이상)")
        attribtuedString2.addAttribute(.foregroundColor, value: Common.color(withHexString: "#6f6f6f"), range: range2)
        attribtuedString2.addAttribute(.font, value: Common.kFont(withSize: "normal", 13), range: range2)
        badTit.attributedText = attribtuedString2
        
        
        badTit.frame = CGRect(x: 57, y: scrlY, width: screenBounds.width - 57, height: gLabelHeight)
        badTit.font = Common.kFont(withSize: "bold", 13)
        
        
        scrlY = goodView.frame.origin.y + screenBounds.width/3 + screenBounds.width/8
        
        
        badView.frame = CGRect(x: margin, y: scrlY, width: screenBounds.width - (margin * 2), height: screenBounds.width/3)
        badEditText.frame = CGRect(x: 0, y: 0, width: screenBounds.width - (margin * 2), height: screenBounds.width/3)
        badEditText.backgroundColor = Common.color(withHexString: "#e6e6e6")
        badEditText.showsVerticalScrollIndicator = false
        badEditText.showsHorizontalScrollIndicator = false
        badEditText.delegate = self
        letterNumLabel2.frame = CGRect(x: badEditText.frame.size.width - 60 , y: badEditText.frame.height - lLabelHeight , width: 80, height: lLabelHeight)
        placeholderSetting2()
        
        scrlY = badView.frame.origin.y + screenBounds.width/3 + badView.frame.size.width/9 - gLabelHeight/2
        
        
        cameraImgView.image = UIImage(named: "camera_btn")
        cameraImgView.frame = CGRect(x: margin, y: scrlY, width: 20, height: 20)
        
        
        pictureTit.text = "사진등록(선택)"
        
        let fullText3 = pictureTit.text ?? ""
        let attribtuedString3 = NSMutableAttributedString(string: fullText3)
        let range3 = (fullText3 as NSString).range(of: "(선택)")
        attribtuedString3.addAttribute(.foregroundColor, value: Common.color(withHexString: "#6f6f6f"), range: range3)
        attribtuedString3.addAttribute(.font, value: Common.kFont(withSize: "normal", 13), range: range3)
        pictureTit.attributedText = attribtuedString3
        
        
        pictureTit.frame = CGRect(x: 57, y: scrlY, width: screenBounds.width - 57, height: gLabelHeight)
        pictureTit.font = Common.kFont(withSize: "bold", 13)
        
        //
        //
        noticeLabel.text = "사전등록시 샘플포인트 100P 지급!"
        noticeLabel.textColor = UIColor.white
        noticeLabel.font = Common.kFont(withSize: "bold", 10)
        noticeLabel.backgroundColor = Common.pointColor1()
        noticeLabel.frame = CGRect(x: screenBounds.width/2, y: scrlY , width: (screenBounds.width - (margin * 2))/2, height: 20)
        noticeLabel.textAlignment = .center
        noticeLabel.isHidden = true
        
        
        scrlY = noticeLabel.frame.origin.y + 20 + badView.frame.size.width/9 - (screenBounds.width - 74)/20
        
        addGuideBtn.setTitle("가이드 첨부", for: .normal)
        addGuideBtn.titleLabel?.font = Common.kFont(withSize: "bold", 13)
        addGuideBtn.setTitleColor(UIColor.black, for: .normal)
        addGuideBtn.layer.borderWidth = 1
        addGuideBtn.clipsToBounds = true
        addGuideBtn.frame = CGRect(x: margin, y: scrlY, width: (screenBounds.width - 74)/2, height: (screenBounds.width - 74)/10)
        addGuideBtn.layer.cornerRadius = addGuideBtn.frame.height/2
        addGuideBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        addGuideBtn.addTarget(self, action: #selector(touchGuideBtn), for: .touchUpInside)
        
        
        addNormalBtn.setTitle("일반 첨부", for: .normal)
        addNormalBtn.titleLabel?.font = Common.kFont(withSize: "bold", 13)
        addNormalBtn.setTitleColor(UIColor.black, for: .normal)
        addNormalBtn.layer.borderWidth = 1
        addNormalBtn.clipsToBounds = true
        addNormalBtn.frame = CGRect(x: 47 + addGuideBtn.frame.width , y: scrlY, width: (screenBounds.width - 74)/2, height: (screenBounds.width - 74)/10)
        addNormalBtn.layer.cornerRadius = addGuideBtn.frame.height/2
        addNormalBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        addNormalBtn.addTarget(self, action: #selector(touchNormalBtn), for: .touchUpInside)
        
        
        scrlY = addNormalBtn.frame.origin.y + addNormalBtn.frame.size.height + (screenBounds.width)/9
        
        botomEditText.frame = CGRect(x: margin, y: badView.frame.origin.y + badEditText.frame.size.height + (badEditText.frame.width)/3
                                     , width: screenBounds.width - (margin * 2), height: screenBounds.width/6)
        botomEditText.backgroundColor = Common.color(withHexString: "#e6e6e6")
        botomEditText.delegate = self
        placeholderSetting3()
        
        scrlY = botomEditText.frame.origin.y + screenBounds.width/6 * 3
        
        trashView.frame = CGRect(x: 0, y: scrlY, width: screenBounds.width, height: 1)
        
        
        
        
        
        
        goodView.addSubview(letterNumLabel)
        badView.addSubview(letterNumLabel2)
        scrollView.frame = CGRect(x: 0, y: screenBounds.height/7 , width: view.frame.size.width, height: screenBounds.height)
        scrollView.contentSize = CGSize(width: screenBounds.width, height: scrlY)
        scrollView.keyboardDismissMode = .onDrag
        view.addSubview(topView)
        view.addSubview(scrollView)
        
        
        //        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        //          NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func placeholderSetting(){
        goodEditText.delegate = self
        goodEditText.text = "• 사용하신 제품의 자세한 리뷰를 남겨주세요\n\n세정력, 제형 등의 사용감을 작성해주세요.\n추천하는 피부타입, 구매하신 가격, 용량을 작성해주세요"
        goodEditText.font = Common.kFont(withSize: "bold", 10)
        let fullText = goodEditText.text!
        let attribtuedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: "세정력, 제형 등의 사용감을 작성해주세요.\n추천하는 피부타입, 구매하신 가격, 용량을 작성해주세요")
        attribtuedString.addAttribute(.font, value: Common.kFont(withSize: "bold", 13), range: range)
        goodEditText.attributedText = attribtuedString
        goodEditText.textColor = UIColor.lightGray
        goodEditText.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 20, right: 5)
        
        
        
        
    }
    
    func placeholderSetting2(){
        badEditText.delegate = self
        badEditText.text = "• 사용하신 제품의 자세한 리뷰를 남겨주세요\n\n사용하시면서 아쉬웠던 사용감을 작성해주세요.\n트러블 유무. 추천하지 않는 피부타입을 말씀해주세요."
        badEditText.font = Common.kFont(withSize: "bold", 10)
        
        
        let fullText = badEditText.text!
        let attribtuedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: "사용하시면서 아쉬웠던 사용감을 작성해주세요.\n트러블 유무. 추천하지 않는 피부타입을 말씀해주세요.")
        attribtuedString.addAttribute(.font, value: Common.kFont(withSize: "bold", 13), range: range)
        badEditText.attributedText = attribtuedString
        badEditText.textColor = UIColor.lightGray
        badEditText.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 20, right: 5)
        
        
    }
    func placeholderSetting3(){
        botomEditText.delegate = self
        botomEditText.text = "• 제품과 무관한 사진일 경우 리뷰 수정 요청을 드리게 되며, 다음 영업일 내에 검수하여 포인트가 지급 됩니다. (주말/공휴일 제외)사진 등록에 대한 포인트 지급은 1인당 최대 월 5000P까지 가능합니다"
        botomEditText.font = Common.kFont(withSize: "bold", 10)
        botomEditText.isEditable = false
        botomEditText.textColor = UIColor.lightGray
        botomEditText.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15)
        
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == UIColor.lightGray{
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        /// 글자 수 제한
        if goodEditText.text.count > 500 {
            goodEditText.deleteBackward()
        }else if goodEditText.textColor != UIColor.lightGray{
            letterNumLabel.textColor = UIColor.lightGray
            letterNumLabel.textAlignment = .left
            letterNumLabel.font = Common.kFont(withSize: "regular", 11)
            /// 아래 글자 수 표시되게 하기
            letterNumLabel.text = "\(goodEditText.text.count)/500"
        }
        if badEditText.text.count > 500 {
            badEditText.deleteBackward()
        }else if badEditText.textColor != UIColor.lightGray{
            letterNumLabel2.textColor = UIColor.lightGray
            letterNumLabel2.textAlignment = .left
            letterNumLabel2.font = Common.kFont(withSize: "regular", 11)
            /// 아래 글자 수 표시되게 하기
            letterNumLabel2.text = "\(badEditText.text.count)/500"
        }
        
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if goodEditText.text.isEmpty{
            goodEditText.delegate = self
            goodEditText.text = "• 사용하신 제품의 자세한 리뷰를 남겨주세요\n\n세정력, 제형 등의 사용감을 작성해주세요.\n추천하는 피부타입, 구매하신 가격, 용량을 작성해주세요"
            goodEditText.font = Common.kFont(withSize: "bold", 10)
            let fullText = goodEditText.text!
            let attribtuedString = NSMutableAttributedString(string: fullText)
            let range = (fullText as NSString).range(of: "세정력, 제형 등의 사용감을 작성해주세요.\n추천하는 피부타입, 구매하신 가격, 용량을 작성해주세요")
            attribtuedString.addAttribute(.font, value: Common.kFont(withSize: "bold", 13), range: range)
            goodEditText.attributedText = attribtuedString
            goodEditText.textColor = UIColor.lightGray
            goodEditText.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 0)
        }else if badEditText.text.isEmpty{
            badEditText.delegate = self
            badEditText.text = "• 사용하신 제품의 자세한 리뷰를 남겨주세요\n\n사용하시면서 아쉬웠던 사용감을 작성해주세요.\n트러블 유무. 추천하지 않는 피부타입을 말씀해주세요."
            badEditText.font = Common.kFont(withSize: "bold", 10)
            
            
            let fullText = badEditText.text!
            let attribtuedString = NSMutableAttributedString(string: fullText)
            let range = (fullText as NSString).range(of: "사용하시면서 아쉬웠던 사용감을 작성해주세요.\n트러블 유무. 추천하지 않는 피부타입을 말씀해주세요.")
            attribtuedString.addAttribute(.font, value: Common.kFont(withSize: "bold", 13), range: range)
            badEditText.attributedText = attribtuedString
            badEditText.textColor = UIColor.lightGray
            badEditText.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 0)
        }else if botomEditText.text.isEmpty{
            botomEditText.delegate = self
            botomEditText.text = "• 제품과 무관한 사진일 경우 리뷰 수정 요청을 드리게 되며, 다음 영업일 내에 검수하여 포인트가 지급 됩니다. (주말/공휴일 제외)사진 등록에 대한 포인트 지급은 1인당 최대 월 5000P까지 가능합니다"
            botomEditText.font = Common.kFont(withSize: "bold", 10)
            
            botomEditText.textColor = UIColor.lightGray
            botomEditText.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15)
        }
    }
    
    @objc func touchGuideBtn(){
        if #available(iOS 14.0, *) {
            var configuration = PHPickerConfiguration()
            configuration.filter = .any(of: [.images])
            // 개수
            configuration.selectionLimit = 99
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }else {
            self.present(self.imagePicker, animated: true)
            self.imagePicker.sourceType = .photoLibrary // 앨범에서 가져옴
            self.imagePicker.delegate = self // picker delegate
        }
        Common.vibrate(1)
    }
    @available(iOS 14, *)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        if results.count != 0{
            for i in 0...results.count - 1{
                if results[i].itemProvider.canLoadObject(ofClass: UIImage.self) {
                    results[i].itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                        DispatchQueue.main.sync {
                            self.uploadImage(image: image as! UIImage)
                        }
                    }
                }
            }
        }else{
            dismiss(animated: false)
        }
        
        
        
        
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var newImage: UIImage? = nil // update 할 이미지
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage // 수정된 이미지가 있을 경우
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage // 원본 이미지가 있을 경우
        }
        
        
        uploadImage(image: newImage!)
        picker.dismiss(animated: true, completion: nil) // picker를 닫아줌
    }
    @objc func touchNormalBtn(){
        if #available(iOS 14.0, *) {
            var configuration = PHPickerConfiguration()
            configuration.filter = .any(of: [.images])
            // 개수
            configuration.selectionLimit = 99
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }else {
            print(";;;;")
            self.present(self.imagePicker, animated: true)
            self.imagePicker.sourceType = .photoLibrary // 앨범에서 가져옴
            self.imagePicker.delegate = self // picker delegate
        }
        Common.vibrate(1)
    }
    
    @objc func touchBackBtn(){
        self.navigationController?.popViewController(animated: true)
        Common.vibrate(1)
        
    }
    
    @objc func touchChangeBtn(){
        self.navigationController?.popViewController(animated: true)
        Common.vibrate(1)
    }
    
    
    @objc func selectReview(product: String, title: String, body: String, rating: String, published: String , images: [String]) {
        print("이미지 ")
        print(images)
        let paramImg =  Common.object(toJsonString: images)
        let common = CommonSwift()
        var params:[String:Any] = [:]
        
        //params.updateValue("order.", forKey: "order")
        //        params.updateValue(self.dic["_id"], forKey: "product")
        //        params.updateValue(UserDefaults.value(forKey: "user_id"), forKey: "customer")
        let customerId =  UserDefaults.standard.value(forKey: "customer_id") as! String
        params.updateValue(customerId, forKey: "customer")
        params.updateValue(product, forKey: "product")
        params.updateValue(title, forKey: "title")
        params.updateValue(body, forKey: "body")
        params.updateValue( paramImg, forKey: "images")
        params.updateValue(rating, forKey: "rating")
        params.updateValue(published, forKey: "published")
        print("파라미터")
        print(params)
        
        COMController.sendRequest("https://api.clayful.io/v1/products/reviews", params, self, #selector(selectReviewCallBack(result:)))
        
    }
    @objc func selectReviewCallBack(result :NSData) {
        let common = CommonSwift()
        NSLog("refundOrderCallback : %@", String(describing: common.JsonToDictionary(data: result)));
        var dict = [String:Any]()
        dict =  common.JsonToDictionary(data: result)!
        print("딕셔너리2")
        print(dict)
        
        
        if dict["message"] == nil{
            
            let title = UILabel()
            let firstLabel = UILabel()
            let secondLabel = UILabel()
            let thankLabel = UILabel()
            let okBtn = UIButton()
            
            
            alertViewController.view.layer.backgroundColor = (UIColor.black.cgColor).copy(alpha: 0.3)
            
            //        alertViewController.view.backgroundColor = .lightGray
            
            alertView.frame = CGRect(x: margin, y: screenBounds.height/2 - ((screenBounds.width - (margin * 2)) * 2/6), width: screenBounds.width - (margin * 2), height: (screenBounds.width - (margin * 2)) * 2.0/3.0)
            alertView.backgroundColor = UIColor.white
            title.text = "리뷰 등록 완료!"
            title.font = Common.kFont(withSize: "bold", 19)
            title.textColor = Common.pointColor1()
            title.frame = CGRect(x: margin, y: margin, width: 150, height: title.font.pointSize)
            
            firstLabel.text = "샘플로드는 모든 리뷰를 꼼꼼히 확인하여 보다 신뢰할 수 있는 리뷰 서비스를 제공하고 있어요!"
            firstLabel.font = Common.kFont(withSize: "regular", 13)
            firstLabel.frame = CGRect(x: margin, y: 46.0 + title.font.pointSize, width: alertView.frame.size.width - (margin * 2), height: firstLabel.font.pointSize * 2.0 + 10)
            firstLabel.textColor = UIColor.lightGray
            firstLabel.numberOfLines = 2
            
            secondLabel.text = "리뷰 검수는 다음 영업일(주말/공휴일 제외) 내로 완료되어 수정 요청 및 반려될 수 있는 점 양해 부탁드려요(^.^)"
            
            secondLabel.font = Common.kFont(withSize: "regular", 13)
            secondLabel.frame = CGRect(x: margin, y: 65 + title.font.pointSize  * 2.0 + 10, width: alertView.frame.size.width - (margin * 2), height: firstLabel.font.pointSize * 3.0 + 10)
            secondLabel.textColor = UIColor.lightGray
            let fullText = secondLabel.text ?? ""
            let attribtuedString = NSMutableAttributedString(string: fullText)
            let range = (fullText as NSString).range(of: "리뷰 검수는 다음 영업일(주말/공휴일 제외) 내")
            attribtuedString.addAttribute(.font, value: Common.kFont(withSize: "bold", 13), range: range)
            secondLabel.attributedText = attribtuedString
            secondLabel.numberOfLines = 3
            
            thankLabel.text = "감사드립니다!"
            thankLabel.textColor = UIColor.lightGray
            thankLabel.font = Common.kFont(withSize: "regular", 13)
            
            let thankLabelHeight = 84 + title.font.pointSize  * 2 + 20 + firstLabel.font.pointSize * 3
            thankLabel.frame = CGRect(x: margin, y: thankLabelHeight , width: alertView.frame.size.width - (margin * 2), height: thankLabel.font.pointSize)
            
            
            okBtn.setTitle("확인", for: .normal)
            okBtn.setTitleColor(Common.pointColor1(), for: .normal)
            okBtn.titleLabel?.font = Common.kFont(withSize: "bold", 19)
            okBtn.frame = CGRect(x: alertView.frame.size.width - 77, y: alertView.frame.size.height - 52, width: 50, height: 30)
            okBtn.addTarget(self, action: #selector(touchOkBtn), for: .touchUpInside)
            
            
            alertView.addSubview(title)
            alertView.addSubview(firstLabel)
            alertView.addSubview(secondLabel)
            alertView.addSubview(thankLabel)
            alertView.addSubview(okBtn)
            alertViewController.view.addSubview(alertView)
            
            alertViewController.modalPresentationStyle = .overCurrentContext
            //알림창 화면에 표시
            self.present(alertViewController, animated: false)
        }else{
            let message = dict["message"] as! String
            self.navigationController?.popViewController(animated: false)
            Common.alert("구매하지 않은 상품입니다")
        }
        
    }
    
    @objc func touchRegisterBtn(){
        print("\(ratingView.value)")
        if goodEditText.text.count < 10 || badEditText.text.count < 10{
            present(common2.alert(title: "", message:"좋았던 점과 아쉬운 점을 최소 10자 이상 적어주세요"), animated: true)
            return
        }
        
        
        let title = UILabel()
        let yesBtn = UIButton()
        let noBtn = UIButton()
        confirmAlertVieController.view.layer.backgroundColor = (UIColor.black.cgColor).copy(alpha: 0.3)
        confirmAlertView.backgroundColor = UIColor.white
        confirmAlertView.frame = CGRect(x: margin, y: screenBounds.height/2 - (screenBounds.width - (margin * 2)) * 2/10, width: screenBounds.width - (margin * 2), height: (screenBounds.width - (margin * 2)) * 2.0/5.0)
        
        title.text = "샘플로드에 리뷰를 등록할까요?"
        title.font = Common.kFont(withSize: "regular", 16)
        title.textColor = UIColor.lightGray
        let fullText = title.text ?? ""
        let attribtuedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: "샘플로드")
        attribtuedString.addAttribute(.foregroundColor, value: Common.pointColor1(), range: range)
        attribtuedString.addAttribute(.font, value: Common.kFont(withSize: "bold", 16), range: range)
        title.attributedText = attribtuedString
        title.frame = CGRect(x: margin, y: margin, width: confirmAlertView.frame.width - (margin * 2), height: title.font.pointSize)
        
        yesBtn.setTitle("예", for: .normal)
        yesBtn.setTitleColor(UIColor.lightGray, for: .normal)
        yesBtn.titleLabel?.font = Common.kFont(withSize: "bold", 19)
        yesBtn.frame = CGRect(x: confirmAlertView.frame.size.width - 57, y: confirmAlertView.frame.size.height - margin - (yesBtn.titleLabel?.font.pointSize)!, width: 30, height: (yesBtn.titleLabel?.font.pointSize)!)
        yesBtn.addTarget(self, action: #selector(touchYesBtn), for: .touchUpInside)
        
        
        noBtn.setTitle("아니오", for: .normal)
        noBtn.setTitleColor(UIColor.lightGray, for: .normal)
        noBtn.titleLabel?.font = Common.kFont(withSize: "regular", 19)
        noBtn.frame = CGRect(x: confirmAlertView.frame.size.width - 137, y: confirmAlertView.frame.size.height - margin - (noBtn.titleLabel?.font.pointSize)!, width: 60, height: (noBtn.titleLabel?.font.pointSize)!)
        noBtn.addTarget(self, action: #selector(touchNoBtn), for: .touchUpInside)
        
        
        
        
        confirmAlertView.addSubview(title)
        confirmAlertView.addSubview(yesBtn)
        confirmAlertView.addSubview(noBtn)
        confirmAlertVieController.view.addSubview(confirmAlertView)
        confirmAlertVieController.modalPresentationStyle = .overCurrentContext
        //알림창 화면에 표시
        self.present(confirmAlertVieController, animated: false)
        Common.vibrate(1)
        
        
    }
    @objc func touchYesBtn(){
        checkFirstWrite()
    }
    func checkFirstWrite(){
//        #error("여기")
        guard let productId = reviewDic["_id"] as? String else {return}
        common2.sendRequest(url: "https://api.clayful.io/v1/products/reviews/count?product=\(productId)&customer=\(customerId2)", method: "get", params: [:], sender: "") { resultJson in
            guard let resultDic = resultJson as? [String:Any],
                  let countDic = resultDic["count"] as? [String:Any],
                  let rawValue = countDic["raw"] as? Int
            else {return}
            
            if rawValue == 0 {
                self.insertReview()
            }else {
                self.dismiss(animated: false)
                self.present(self.common2.alert(title: "", message: "이미 리뷰가 작성된 제품입니다"), animated: true)
            }
            print("####result")
            print(resultJson)
        }
    }
    func insertReview(){
        var skinGomin = String()
        guard let skinGominArr = UserDefaults.standard.value(forKey: "user_skin_gomin") as? [String],
              let skinType = UserDefaults.standard.string(forKey: "user_skin_type")
        else {return}
        for i in 0...skinGominArr.count - 1 {
            skinGomin += ","
            skinGomin += skinGominArr[i]
        }
        skinGomin.remove(at: skinGomin.startIndex)
        let body = goodEditText.text + "\nsr_divide_here\n" + badEditText.text + "\nsr_divide_here\n" + skinType + "\nsr_divide_here\n" + skinGomin
        selectReview(product: reviewDic["_id"] as! String , title: simpleEditText.text ?? "", body: body, rating: "\(ratingView.value)", published: "false", images: imgId)
        dismiss(animated: false)
        
        Common.vibrate(1)
    }
    @objc func touchNoBtn(){
        dismiss(animated: false)
        Common.vibrate(1)
    }
    
    @objc func touchOkBtn(){
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: false)
        Common.vibrate(1)
        
    }
    
    @objc func keyboardWillShow(_ noti: NSNotification){
        // 키보드의 높이만큼 화면을 올려준다.
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.keyboardHeight = keyboardRectangle.height
            print("스크롤 y")
            print( self.scrollView.frame.origin.y)
            print("topView.frame.size.height")
            print( topView.frame.height)
            
            //            if self.scrollView.frame.origin.y == topView.frame.size.height {
            //                self.scrollView.frame.origin.y -= keyboardHeight
            //            }
            
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            
            
            
            scrollView.setContentOffset(CGPoint(x: 0, y: botomLineView.frame.origin.y), animated: true)
            
            
            //            self.scrollView.contentSize.height += keyboardHeight
        }
    }
    
    // 키보드가 사라졌다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillHide(_ noti: NSNotification){
        // 키보드의 높이만큼 화면을 내려준다.
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.keyboardHeight = keyboardRectangle.height
            //            self.view.frame.origin.y = 0
            //            self.scrollView.frame.origin.y = topView.frame.size.height
            //            self.scrollView.contentSize.height -= keyboardHeight
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    
    func addKeyboardNotifications(){
        // 키보드가 나타날 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // 노티피케이션을 제거하는 메서드
    func removeKeyboardNotifications(){
        // 키보드가 나타날 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func uploadImage(image :UIImage) {
        print("수 세기")
        var param = [String : Any]()
        param.updateValue("Review", forKey: "model")
        param.updateValue("images", forKey: "application")
        
        let imageName = customerId2 + common2.getTimeIndex()
        COMController.sendRequestMultipartClayFul(param, image, imageName, self, #selector(uploadImageCallback(result:)))
    }
    
    @objc func uploadImageCallback(result :NSData) {
        let common = CommonSwift()
        
        let resultDic:[String:Any] = common.JsonToDictionary(data: result)!
        
        imgId.append(resultDic["_id"] as! String)
        NSLog("uploadImageCallback : %@", resultDic);
        
    }
    
    
    
    
    
    
    
}
