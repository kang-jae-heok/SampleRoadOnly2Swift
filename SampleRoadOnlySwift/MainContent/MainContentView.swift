//
//  MainContentView.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/10/12.
//

import Foundation

class MainContentView: UIView {
    let screenBounds = UIScreen.main.bounds
    let margin = 17.0
    let common = CommonS()
    let maincontentModel = MainContentModel()
    var viewOpen = Bool()
    lazy var sclView = UIScrollView().then{
        $0.isHidden = false
        $0.bounces = false
    }
    let middleView = UIView()
    //바텀 네비게이션 뷰
    lazy var background = UIView().then{
        $0.backgroundColor = common.setColor(hex: "#f5f5f5")
    }
    let homeMenuBtn = UIButton().then{
        $0.addTarget(self, action: #selector(touchHomeBtn), for: .touchUpInside)
    }
    let homeMenuImgView = UIImageView().then{
        $0.image = UIImage(named: "home_on_btn")
    }
    lazy var homeMenuLbl = UILabel().then{
        $0.text = "홈"
        $0.textColor = common.setColor(hex: "#cecece")
        $0.font = common.setFont(font: "bold", size: 11)
    }
    let rankMenuBtn = UIButton().then{
        $0.addTarget(self, action: #selector(touchRankBtn), for: .touchUpInside)
    }
    let rankMenuImgView = UIImageView().then{
        $0.image = UIImage(named: "rank_off_btn")
    }
    lazy var rankMenuLbl = UILabel().then{
        $0.text = "랭킹"
        $0.textColor = common.setColor(hex: "#cecece")
        $0.font = common.setFont(font: "bold", size: 11)
    }
    let reviewMenuBtn = UIButton().then{
        $0.addTarget(self, action: #selector(touchReviewBtn), for: .touchUpInside)
    }
    let reviewMenuImgView = UIImageView().then{
        $0.image = UIImage(named: "review_off_btn")
    }
    lazy var reviewMenuLbl = UILabel().then{
        $0.text = "리뷰"
        $0.textColor = common.setColor(hex: "#cecece")
        $0.font = common.setFont(font: "bold", size: 11)
    }
    let myMenuBtn = UIButton().then{
        $0.addTarget(self, action: #selector(touchMyBtn), for: .touchUpInside)
    }
    let myMenuImgView = UIImageView().then{
        $0.image = UIImage(named: "my_off_btn")
    }
    lazy var myMenuLbl = UILabel().then{
        $0.text = "마이"
        $0.textColor = common.setColor(hex: "#cecece")
        $0.font = common.setFont(font: "bold", size: 11)
    }
    lazy var sampleBtn = UIButton().then{
        $0.backgroundColor = common.pointColor()
        $0.layer.cornerRadius = 0.5 * screenBounds.width/5
        $0.clipsToBounds = true
    }
    let plusImgView = UIImageView().then{
        $0.image = UIImage(named: "plus_btn")
    }
    lazy var sampleLbl = UILabel().then{
        $0.text = "샘플받기"
        $0.textColor = common.setColor(hex: "#ffffff")
        $0.font = common.setFont(font: "bold", size: 11)
    }
    //탑뷰
    let topView = TopView().then{
        $0.mainIconBtn.addTarget(self, action: #selector(touchTopLogoBtn), for: .touchUpInside)
    }
    //이벤트 or 샘플 버튼
    let topNavigationView = TopNavigationView().then{
        $0.eventBtn.addTarget(self, action: #selector(touchNavigateEventBtn), for: .touchUpInside)
        $0.sampleBtn.addTarget(self, action: #selector(touchNavigateSampleBtn), for: .touchUpInside)
    }
    //메인 컨텐츠 - 배너
    //    let bannerImgView = UIImageView().then{
    //        $0.contentMode = .scaleAspectFit
    //    }
    lazy var bannerCollectionView = BannerCollectionView()
    //메인 컨텐츠 - 베스트 3
    lazy var bestTitleLbl = UILabel().then{
        $0.backgroundColor = common.pointColor()
        $0.text = "샘플로드 이달의 샘플! BEST 3"
        $0.textAlignment = .center
        $0.textColor = .white
        $0.font = common.setFont(font: "bold", size: 14)
    }
    let noneView = NoneView().then {
        $0.tit.text = "이달의 샘플이 없습니다."
        $0.isHidden = true
    }
    lazy var firstView = UIView().then{
        $0.backgroundColor = common.setColor(hex: "#f5f5f5")
        $0.layer.cornerRadius = 5
    }
    let firstViewBtn = UIButton().then{
        $0.tag = 0
    }
    let secondViewBtn = UIButton().then{
        $0.tag = 1
    }
    let thirdViewBtn = UIButton().then{
        $0.tag = 2
    }
    let firstCrownImgView = UIImageView().then{
        $0.image = UIImage(named: "goldcrown")
    }
    let firstProductImgView = UIImageView()
    lazy var firstCompanytLbl = UILabel().then{
        $0.font = common.setFont(font: "regular", size: 10)
    }
    lazy var firstProductLbl = UILabel().then{
        $0.font = common.setFont(font: "bold", size: 12)
    }
    let firstArrowButton = UIButton().then{
        $0.setImage(UIImage(named: "rightarrow_btn"), for: .normal)
        $0.tag = 0
    }
    let firstRateImgView = UIImageView().then{
        $0.image = UIImage(named: "rate_btn")
    }
    lazy var firstRatingLbl = UILabel().then{
        $0.font = common.setFont(font: "bold", size: 10)
    }
    lazy var secondView = UIView().then{
        $0.backgroundColor = common.setColor(hex: "#f5f5f5")
        $0.layer.cornerRadius = 5
    }
    let secondCrownImgView = UIImageView().then{
        $0.image = UIImage(named: "silvercrown")
    }
    let secondProductImgView = UIImageView()
    lazy var secondCompanytLbl = UILabel().then{
        $0.font = common.setFont(font: "regular", size: 10)
    }
    lazy var secondProductLbl = UILabel().then{
        $0.font = common.setFont(font: "bold", size: 12)
    }
    let secondArrowButton = UIButton().then{
        $0.setImage(UIImage(named: "rightarrow_btn"), for: .normal)
        $0.tag = 1
    }
    let secondRateImgView = UIImageView().then{
        $0.image = UIImage(named: "rate_btn")
    }
    lazy var secondRatingLbl = UILabel().then{
        $0.font = common.setFont(font: "bold", size: 10)
    }
    lazy var thirdView = UIView().then{
        $0.backgroundColor = common.setColor(hex: "#f5f5f5")
        $0.layer.cornerRadius = 5
    }
    let thirdCrownImgView = UIImageView().then{
        $0.image = UIImage(named: "bronzecrown")
    }
    let thirdProductImgView = UIImageView()
    lazy var thirdCompanytLbl = UILabel().then{
        $0.font = common.setFont(font: "regular", size: 10)
    }
    lazy var thirdProductLbl = UILabel().then{
        $0.font = common.setFont(font: "bold", size: 12)
    }
    let thirdArrowButton = UIButton().then{
        $0.setImage(UIImage(named: "rightarrow_btn"), for: .normal)
        $0.tag = 2
    }
    let thirdRateImgView = UIImageView().then{
        $0.image = UIImage(named: "rate_btn")
    }
    lazy var thirdRatingLbl = UILabel().then{
        $0.font = common.setFont(font: "bold", size: 10)
    }
    //     사업자 정보
    let busisneesInfoView = UIView()
    let smallLogoImgView = UIImageView().then{
        $0.image = UIImage(named: "logo_s_btn")
        $0.contentMode = .center
    }
    lazy var grayBackgroundView = UIView().then {
        $0.backgroundColor = common.setColor(hex: "#f5f5f5")
    }
    lazy var busisnessLbl = UILabel().then{
        $0.text = "사업자 정보"
        $0.textColor = .black
        $0.font = common.setFont(font: "bold", size: 14)
    }
    lazy var businessBtn = UIButton().then {
        $0.addTarget(self, action: #selector(touchBusinessBtn), for: .touchUpInside)
    }
    lazy var businessInfoText: [UIView] = {
        var infoViews = [UIView]()
        for i in 0...8 {
            let infoView = UIView()
            let tit = UILabel().then {
                $0.text = maincontentModel.busisneesInfo[i][0]
                $0.textColor = common2.gray()
                $0.font = common2.setFont(font: "regular", size: 12)
            }
            let content = UILabel().then {
                $0.text = maincontentModel.busisneesInfo[i][1]
                $0.textColor = .black
                $0.font = common2.setFont(font: "regular", size: 12)
                $0.numberOfLines = 0
            }
            [tit,content].forEach {
                infoView.addSubview($0)
            }
            tit.snp.makeConstraints {
                $0.left.equalToSuperview().offset(margin2)
                $0.top.equalToSuperview()
            }
            content.snp.makeConstraints {
                $0.left.equalToSuperview().offset(screenBounds.width/3)
                $0.top.equalToSuperview()
                $0.bottom.equalToSuperview()
            }
            infoViews.append(infoView)
        }
        return infoViews
    }()
    let toggleBtn = UIButton().then {
        $0.setImage(UIImage(named: "toggle_down_btn"), for: .normal)
    }
    //이벤트 뷰
//    lazy var eventVc = EventSViewController(screenRect: CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.height - screenBounds.width/4 - 90.0 - 38.0 - ((screenBounds.width/2.0 - margin)/6.0)))
    let eventView = UIView().then{
        $0.isHidden = true
    }
    //랭크 뷰
    lazy var rankVc = RankSViewController(screenRect: CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.height - screenBounds.width/4 - 90.0))
    let rankView = UIView().then{
        $0.isHidden = true
    }
    // 리뷰 뷰
    let reviewDic = NSMutableDictionary(dictionary: ["review_type": 1])
    lazy var rect = CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.height - screenBounds.width/4 - 90.0)
    let reviewView = UIView().then{
        $0.isHidden = true
    }
    //마이 뷰
    
    
    //    lazy var myVc = MyPageViewController(screenRect:  CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.height - screenBounds.width/4 - 90.0))
    
    let myView = UIView().then{
        $0.isHidden = true
    }
    // help 버튼
    lazy var helpBtn = helpBtnS(frame: CGRect(x: margin, y: screenBounds.height - screenBounds.width/4 - 90 - 72, width: 72, height: 72))
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubviewFunc()
        setLayout()
        viewOpen = false
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setLayout(){
        topView.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(super.snp.top).offset(screenBounds.width/4)
        }
        middleView.snp.makeConstraints{
            $0.top.equalTo(topView.snp.bottom)
            $0.bottom.equalTo(background.snp.top)
            $0.left.right.equalToSuperview()
        }
        // 바텀 네비게이션 뷰
        let btnSize = CGSize(width: screenBounds.width/5, height: 90)
        background.snp.makeConstraints{
            $0.bottom.left.right.equalToSuperview()
            $0.size.height.equalTo(90)
        }
        sampleBtn.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(homeMenuLbl.snp.bottom)
            $0.size.equalTo(CGSize(width: screenBounds.width/5, height: screenBounds.width/5))
        }
        homeMenuBtn.snp.makeConstraints{
            $0.left.bottom.top.equalToSuperview()
            $0.size.equalTo(btnSize)
        }
        rankMenuBtn.snp.makeConstraints{
            $0.left.equalTo(homeMenuBtn.snp.right)
            $0.top.bottom.equalToSuperview()
            $0.size.equalTo(btnSize)
        }
        myMenuBtn.snp.makeConstraints{
            $0.right.top.bottom.equalToSuperview()
            $0.left.equalTo(super.snp.right).offset(-btnSize.width)
            $0.size.equalTo(btnSize)
        }
        reviewMenuBtn.snp.makeConstraints{
            $0.right.equalTo(myMenuBtn.snp.left)
            $0.top.bottom.equalToSuperview()
            $0.size.equalTo(btnSize)
        }
        [homeMenuLbl,reviewMenuLbl,rankMenuLbl,myMenuLbl].forEach{
            let superView = $0.superview as! UIButton
            $0.snp.makeConstraints{
                $0.centerX.equalToSuperview()
                $0.top.equalTo(superView.snp.centerY).offset(1.5)
            }
        }
        [homeMenuImgView,reviewMenuImgView,rankMenuImgView,myMenuImgView].forEach{
            let superView = $0.superview as! UIButton
            $0.snp.makeConstraints{
                $0.centerX.equalToSuperview()
                $0.bottom.equalTo(superView.snp.centerY).offset(-1.5)
            }
        }
        sampleLbl.snp.makeConstraints{
            $0.centerX.equalTo(sampleBtn.snp.centerX)
            $0.top.equalTo(sampleBtn.snp.centerY).offset(6)
        }
        plusImgView.snp.makeConstraints{
            $0.centerX.equalTo(sampleBtn.snp.centerX)
            $0.bottom.equalTo(sampleBtn.snp.centerY)
        }
        //탑 네비게이션 버튼
        topNavigationView.snp.makeConstraints{
            $0.top.equalTo(topView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.size.equalTo(CGSize(width: screenBounds.width, height: (screenBounds.width/2 - margin)/6 + 38))
        }
        //스크롤뷰
        sclView.snp.makeConstraints{
            $0.top.equalTo(topNavigationView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(background.snp.top)
        }
        //        sclView.contentSize = CGSize(width: screenBounds.width, height: screenBounds.height - 100)
        // 배너
        bannerCollectionView.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.size.equalTo(CGSize(width: screenBounds.width, height: screenBounds.width/1.6))
        }
        //베스트 3 뷰
        bestTitleLbl.snp.makeConstraints{
            $0.top.equalTo(bannerCollectionView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.size.equalTo(CGSize(width: screenBounds.width, height: screenBounds.width/9.5))
        }
        firstView.snp.makeConstraints{
            $0.top.equalTo(bestTitleLbl.snp.bottom).offset(22)
            $0.left.equalToSuperview().offset(margin)
            $0.right.equalToSuperview().offset(-margin)
        }
        secondView.snp.makeConstraints{
            $0.top.equalTo(firstView.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(margin)
            $0.right.equalToSuperview().offset(-margin)
        }
        thirdView.snp.makeConstraints{
            $0.top.equalTo(secondView.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(margin)
            $0.right.equalToSuperview().offset(-margin)
        }
        [firstCrownImgView,secondCrownImgView,thirdCrownImgView].forEach{
            $0.snp.makeConstraints{
                $0.left.equalToSuperview().offset(margin)
                $0.centerY.equalToSuperview()
                $0.size.equalTo(CGSize(width: 25, height: 25))
            }
        }
        [firstProductImgView,secondProductImgView,thirdProductImgView].forEach{
            $0.snp.makeConstraints{
                $0.centerY.equalToSuperview()
                $0.left.equalTo(firstCrownImgView.snp.right).offset(6)
                $0.size.equalTo(CGSize(width: 50, height: firstCompanytLbl.font.pointSize + firstProductLbl.font.pointSize + firstRatingLbl.font.pointSize + 15))
                $0.top.equalToSuperview().offset(15)
                $0.bottom.equalToSuperview().offset(-15)
            }
        }
        [firstCompanytLbl,secondCompanytLbl,thirdCompanytLbl].forEach{
            $0.snp.makeConstraints{
                $0.left.equalTo(firstProductImgView.snp.right).offset(6)
                $0.top.equalToSuperview().offset(15)
            }
        }
        [firstProductLbl,secondProductLbl,thirdProductLbl].forEach{
            let superView = $0.superview!
            $0.snp.makeConstraints{
                $0.left.equalTo(firstCompanytLbl)
                $0.centerY.equalTo(superView.snp.centerY)
            }
        }
        [firstArrowButton,secondArrowButton,thirdArrowButton].forEach{
            $0.snp.makeConstraints{
                $0.right.equalTo(firstView.snp.right).offset(-margin)
                $0.centerY.equalToSuperview()
                $0.size.equalTo(CGSize(width: 15, height: 15))
            }
        }
        
        [firstRateImgView,secondRateImgView,thirdRateImgView].forEach{
            let superView = $0.superview!
            $0.snp.makeConstraints{
                $0.left.equalTo(firstCompanytLbl)
                $0.centerY.equalTo(superView.snp.bottom).offset(-22)
                $0.size.equalTo(CGSize(width: 15, height: 15))
            }
        }
        [firstRatingLbl,secondRatingLbl,thirdRatingLbl].forEach{
            let superView = $0.superview!
            $0.snp.makeConstraints{
                $0.left.equalTo(firstRateImgView.snp.right).offset(5)
                $0.centerY.equalTo(superView.snp.bottom).offset(-20)
            }
        }
        eventView.snp.makeConstraints{
            $0.top.equalTo(topNavigationView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.centerY.equalTo(background.snp.top)
        }
        
        rankView.snp.makeConstraints{
            $0.top.equalTo(topView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(background.snp.top)
        }
        reviewView.snp.makeConstraints{
            $0.top.equalTo(topView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(background.snp.top)
        }
        myView.snp.makeConstraints{
            $0.top.equalTo(topView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(background.snp.top)
        }
        firstViewBtn.snp.makeConstraints{
            $0.edges.equalTo(firstView)
        }
        secondViewBtn.snp.makeConstraints{
            $0.edges.equalTo(secondView)
        }
        thirdViewBtn.snp.makeConstraints{
            $0.top.equalTo(secondView.snp.bottom).offset(6)
            $0.left.equalToSuperview().offset(margin)
            $0.right.equalToSuperview().offset(-margin)
            $0.size.equalTo(CGSize(width: screenBounds.width - margin * 2, height: screenBounds.height/12))
        }
        noneView.snp.makeConstraints {
            $0.top.left.right.equalTo(firstView)
            $0.bottom.equalTo(thirdView)
        }
        toggleBtn.snp.makeConstraints {
            $0.top.equalTo(thirdView.snp.bottom).offset(20)
            $0.left.equalTo(busisnessLbl.snp.right).offset(5)
        }
        busisnessLbl.snp.makeConstraints {
            $0.centerY.equalTo(toggleBtn)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
        }
        smallLogoImgView.snp.makeConstraints {
            $0.centerY.equalTo(toggleBtn)
            $0.right.equalTo(busisnessLbl.snp.left).offset(-10)
        }
        businessBtn.snp.makeConstraints {
            $0.left.equalTo(smallLogoImgView)
            $0.right.equalTo(toggleBtn)
            $0.top.bottom.equalTo(busisnessLbl)
        }
        grayBackgroundView.snp.makeConstraints {
            $0.top.equalTo(smallLogoImgView.snp.bottom).offset(24)
            $0.left.equalToSuperview().offset(margin2)
            $0.right.equalToSuperview().offset(-margin2)
        }

        for i in 0...businessInfoText.count - 1 {
            if i == 0 {
                businessInfoText[i].snp.makeConstraints {
                    $0.top.equalToSuperview().offset(margin)
                    $0.left.right.equalToSuperview()
                }
            }else if i == 8 {
                businessInfoText[i].snp.makeConstraints {
                    $0.top.equalTo(businessInfoText[i-1].snp.bottom).offset(5)
                    $0.left.right.equalToSuperview()
                    $0.bottom.equalToSuperview().offset(-margin)
                }
            }else {
                businessInfoText[i].snp.makeConstraints {
                    $0.top.equalTo(businessInfoText[i-1].snp.bottom).offset(5)
                    $0.left.right.equalToSuperview()
                }
            }
        }
    }
    func addSubviewFunc(){

        
        rankView.addSubview(rankVc.view)
        
        
        [topView,background,middleView,sampleBtn].forEach{
            self.addSubview($0)
        }
        middleView.clipsToBounds = true
        [sclView,topNavigationView,eventView,rankView,reviewView,myView,helpBtn].forEach{
            middleView.addSubview($0)
        }
        [bannerCollectionView,bestTitleLbl,firstView,secondView,thirdView,firstViewBtn,secondViewBtn,thirdViewBtn,smallLogoImgView,busisnessLbl,toggleBtn,businessBtn,grayBackgroundView,noneView].forEach{
            sclView.addSubview($0)
        }
       
//        grayBackgroundView.addSubview(busisnessLbl)
        
        [homeMenuBtn,rankMenuBtn,reviewMenuBtn,myMenuBtn].forEach{
            background.addSubview($0)
        }
        [homeMenuLbl,homeMenuImgView].forEach{
            homeMenuBtn.addSubview($0)
        }
        [rankMenuLbl,rankMenuImgView].forEach{
            rankMenuBtn.addSubview($0)
        }
        [reviewMenuLbl,reviewMenuImgView].forEach{
            reviewMenuBtn.addSubview($0)
        }
        [myMenuLbl,myMenuImgView].forEach{
            myMenuBtn.addSubview($0)
        }
        [sampleLbl,plusImgView].forEach{
            sampleBtn.addSubview($0)
        }
        [firstProductLbl,firstArrowButton,firstCompanytLbl,firstProductImgView,firstCrownImgView,firstRateImgView,firstRatingLbl].forEach{
            firstView.addSubview($0)
        }
        [secondProductLbl,secondArrowButton,secondCompanytLbl,secondProductImgView,secondCrownImgView,secondRatingLbl,secondRateImgView].forEach{
            secondView.addSubview($0)
        }
        [thirdProductLbl,thirdArrowButton,thirdCompanytLbl,thirdProductImgView,thirdCrownImgView,thirdRatingLbl,thirdRateImgView].forEach{
            thirdView.addSubview($0)
        }
        for i in 0...8 {
            grayBackgroundView.addSubview(businessInfoText[i])
        }
      
       
        
    }
    @objc func touchBusinessBtn(){
        if !viewOpen {
            busisnessLbl.snp.remakeConstraints {
                $0.centerY.equalTo(toggleBtn)
                $0.centerX.equalToSuperview()
            }
            grayBackgroundView.snp.remakeConstraints {
                $0.top.equalTo(smallLogoImgView.snp.bottom).offset(21)
                $0.left.equalToSuperview().offset(margin2)
                $0.right.equalToSuperview().offset(-margin2)
                $0.bottom.equalToSuperview().offset(-50)
            }
            sclView.contentSize.height = grayBackgroundView.bounds.height + 80 + sclView.bounds.height
            toggleBtn.setImage(UIImage(named: "toggle_up_btn"), for: .normal)
            viewOpen = true
        }else {
            busisnessLbl.snp.remakeConstraints {
                $0.centerY.equalTo(toggleBtn)
                $0.centerX.equalToSuperview()
                $0.bottom.equalToSuperview().offset(-20)
            }
            grayBackgroundView.snp.remakeConstraints {
                $0.top.equalTo(smallLogoImgView.snp.bottom).offset(21)
                $0.left.equalToSuperview().offset(margin2)
                $0.right.equalToSuperview().offset(-margin2)
            }
            toggleBtn.setImage(UIImage(named: "toggle_down_btn"), for: .normal)
            viewOpen = false
        }
        sclView.setContentOffset(CGPoint(x: 0, y: sclView.contentSize.height-sclView.bounds.height),animated: true)
        
    }
    @objc func touchHomeBtn(){
        if homeMenuImgView.image == UIImage(named: "home_off_btn"){
            homeMenuImgView.image = UIImage(named: "home_on_btn")
            rankMenuImgView.image = UIImage(named: "rank_off_btn")
            reviewMenuImgView.image = UIImage(named: "review_off_btn")
            myMenuImgView.image = UIImage(named: "my_off_btn")
            homeMenuLbl.textColor = common.pointColor()
            rankMenuLbl.textColor = common.setColor(hex: "#cecece")
            reviewMenuLbl.textColor = common.setColor(hex: "#cecece")
            myMenuLbl.textColor = common.setColor(hex: "#cecece")
        }
        topView.alarmBtn.isHidden = true
        topView.searchTextField.isHidden = false
        topView.topLbl.isHidden = true
        rankView.isHidden = true
        reviewView.isHidden = true
        myView.isHidden = true
    }
    @objc func touchRankBtn(){
        if rankMenuImgView.image == UIImage(named: "rank_off_btn"){
            homeMenuImgView.image = UIImage(named: "home_off_btn")
            rankMenuImgView.image = UIImage(named: "rank_on_btn")
            reviewMenuImgView.image = UIImage(named: "review_off_btn")
            myMenuImgView.image = UIImage(named: "my_off_btn")
            homeMenuLbl.textColor = common.setColor(hex: "#cecece")
            rankMenuLbl.textColor = common.pointColor()
            reviewMenuLbl.textColor = common.setColor(hex: "#cecece")
            myMenuLbl.textColor = common.setColor(hex: "#cecece")
        }
        topView.searchTextField.isHidden = true
        topView.topLbl.text = "Rank"
        topView.topLbl.isHidden = false
        topView.alarmBtn.isHidden = true
        rankView.isHidden = false
        reviewView.isHidden = true
        myView.isHidden = true
    }
    @objc func touchReviewBtn(){
        if reviewMenuImgView.image == UIImage(named: "review_off_btn"){
            homeMenuImgView.image = UIImage(named: "home_off_btn")
            rankMenuImgView.image = UIImage(named: "rank_off_btn")
            reviewMenuImgView.image = UIImage(named: "review_on_btn")
            myMenuImgView.image = UIImage(named: "my_off_btn")
            homeMenuLbl.textColor = common.setColor(hex: "#cecece")
            rankMenuLbl.textColor = common.setColor(hex: "#cecece")
            reviewMenuLbl.textColor = common.pointColor()
            myMenuLbl.textColor = common.setColor(hex: "#cecece")
        }
        topView.searchTextField.isHidden = true
        topView.topLbl.text = "Review"
        topView.topLbl.isHidden = false
        topView.alarmBtn.isHidden = true
        rankView.isHidden = true
        reviewView.isHidden = false
        myView.isHidden = true
    }
    @objc func touchMyBtn(){
        //        if !UserDefaults.standard.bool(forKey: "PRDC_MODE"){
        //            let vc = DeliveryHistoryViewController()
        //            parentViewController?.navigationController?.pushViewController(vc, animated: true)
        //        }else{
        if myMenuImgView.image == UIImage(named: "my_off_btn"){
            homeMenuImgView.image = UIImage(named: "home_off_btn")
            rankMenuImgView.image = UIImage(named: "rank_off_btn")
            reviewMenuImgView.image = UIImage(named: "review_off_btn")
            myMenuImgView.image = UIImage(named: "my_on_btn")
            homeMenuLbl.textColor = common.setColor(hex: "#cecece")
            rankMenuLbl.textColor = common.setColor(hex: "#cecece")
            reviewMenuLbl.textColor = common.setColor(hex: "#cecece")
            myMenuLbl.textColor = common.pointColor()
        }
        topView.searchTextField.isHidden = true
        topView.topLbl.text = "My"
        topView.topLbl.isHidden = false
        topView.alarmBtn.isHidden = false
        rankView.isHidden = true
        reviewView.isHidden = true
        myView.isHidden = false
        //        }
    }
    @objc func touchNavigateEventBtn(){
        eventView.isHidden = false
    }
    @objc func touchNavigateSampleBtn(){
        eventView.isHidden = true
    }
    @objc func touchTopLogoBtn(){
        topNavigationView.sampleBtn.backgroundColor = common.pointColor()
        topNavigationView.sampleBtn.setTitleColor(UIColor.white, for: .normal)
        topNavigationView.eventBtn.backgroundColor = .white
        topNavigationView.eventBtn.setTitleColor(common.pointColor(), for: .normal)
        homeMenuImgView.image = UIImage(named: "home_on_btn")
        rankMenuImgView.image = UIImage(named: "rank_off_btn")
        reviewMenuImgView.image = UIImage(named: "review_off_btn")
        myMenuImgView.image = UIImage(named: "my_off_btn")
        homeMenuLbl.textColor = common.pointColor()
        rankMenuLbl.textColor = common.setColor(hex: "#cecece")
        reviewMenuLbl.textColor = common.setColor(hex: "#cecece")
        myMenuLbl.textColor = common.setColor(hex: "#cecece")
        topView.alarmBtn.isHidden = true
        topView.searchTextField.isHidden = false
        topView.topLbl.isHidden = true
        eventView.isHidden = true
        rankView.isHidden = true
        reviewView.isHidden = true
        myView.isHidden = true
    }
}
