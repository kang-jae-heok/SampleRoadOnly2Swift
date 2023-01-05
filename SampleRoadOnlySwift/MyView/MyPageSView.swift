//
//  MyPageView.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/11/17.
//

import Foundation

class MyPageSView: UIView {
    
    var pointLabel: UILabel?
    var couponCountLabel: UILabel?
    var pickCountLabel: UILabel?
    
    
    var myModel = MyModel()
    var eventCount = Int()
    let sclView = UIScrollView()
    lazy var profileBtn = UIButton().then {
        $0.backgroundColor = common2.pointColor()
        if UserDefaults.standard.string(forKey: "user_image") ?? "" == ""  ||  !UserDefaults.contains("user_image") ||  UserDefaults.standard.string(forKey: "user_image") == "null"{
            $0.setImage(UIImage(named: "profile_btn"), for: .normal)
        }else {
            common2.setButtonImageUrl(url: UserDefaults.standard.string(forKey: "user_image")!, button: $0)
        }
        $0.clipsToBounds = true
        
       
        $0.imageView?.contentMode = .scaleAspectFill
    }
    let editProfileBtn = UIButton().then {
        $0.setImage(UIImage(named: "edit_profile_btn"), for: .normal)
    }
    let nameLbl = UILabel().then {
        $0.text = UserDefaults.standard.string(forKey: "user_alias") ?? "샘플 털이범" + "님"
    }
    let settingBtn = UIButton().then {
        $0.setImage(UIImage(named: "setting_btn"), for: .normal)
    }
    lazy var getSampleBtn = UIButton().then {
        $0.setTitle("받아본 샘플", for: .normal)
        $0.titleLabel?.font = common2.setFont(font: "bold", size: 13)
        $0.setTitleColor(common2.pointColor(), for: .normal)
        $0.layer.cornerRadius = 9
        $0.layer.borderColor = common2.pointColor().cgColor
        $0.layer.borderWidth = 2
    }
    lazy var likeSampleBtn = UIButton().then {
        $0.setTitle("찜", for: .normal)
        $0.titleLabel?.font = common2.setFont(font: "bold", size: 13)
        $0.setTitleColor(common2.pointColor(), for: .normal)
        $0.layer.cornerRadius = 9
        $0.layer.borderColor = common2.pointColor().cgColor
        $0.layer.borderWidth = 2
    }
    lazy var deliveryBtn = UIButton().then {
        $0.setTitle("주문/배송", for: .normal)
        $0.titleLabel?.font = common2.setFont(font: "bold", size: 13)
        $0.setTitleColor(common2.pointColor(), for: .normal)
        $0.layer.cornerRadius = 9
        $0.layer.borderColor = common2.pointColor().cgColor
        $0.layer.borderWidth = 2
    }
    lazy var noticeBtn = UIButton().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
    }
    lazy var noticeLbl = UILabel().then {
        $0.text = "공지"
        $0.textColor = common2.pointColor()
        $0.font = common2.setFont(font: "bold", size: 14)
    }
    lazy var noticeContentLbl = UILabel().then {
        $0.text = "사장님이 미쳤나봐요ㅜ.ㅜ..."
        $0.textColor = .black
        $0.font = common2.setFont(font: "bold", size: 14)
    }
    let noticeArrow = UIImageView().then {
        $0.image = UIImage(named: "arrow_btn")
        $0.contentMode = .center
    }
    let cartImgView = UIImageView().then {
        $0.image = UIImage(named: "cart_btn")
        $0.contentMode = .center
    }
    lazy var cartLbl = UILabel().then {
        $0.text = "샘플로드 쇼핑"
        $0.font = common2.setFont(font: "bold", size: 15)
    }
    lazy var topLine = UIView().then {
        $0.backgroundColor = common2.lightGray()
    }
    lazy var middleLine = UIView().then {
        $0.backgroundColor = common2.lightGray()
    }
    lazy var bottomLine = UIView().then {
        $0.backgroundColor = common2.lightGray()
    }
    lazy var verticalMiddleLine = UIView().then {
        $0.backgroundColor = common2.lightGray()
    }
    lazy var shopBtns: [UIButton] = { [self] in
        var btns = [UIButton]()
        for i in 0...3 {
            let btn = UIButton()
            let tit = UILabel().then {
                $0.text = myModel.titArr[i]
                $0.font = common2.setFont(font: "bold", size: 14)
            }
            let content = UILabel().then {
                if i == 0 {
                    $0.text = String(myModel.pointCount) + "P"
                    $0.font = common2.setFont(font: "bold", size: 16)
                    $0.asColor(targetStringList: [String(myModel.pointCount)], color: common2.pointColor())
                    pointLabel = $0
                    $0.isHidden = true
                }else if i == 1 {
                    couponCountLabel = $0
                    $0.font = common2.setFont(font: "bold", size: 16)
                }else if i == 3 {
                    pickCountLabel = $0
                    $0.font = common2.setFont(font: "bold", size: 16)
                }else {
                    $0.isHidden = true
                }
            }
            let newImg = UIImageView().then {
                $0.image = UIImage(named: "new")
                $0.isHidden = !myModel.newBool[i]
                $0.contentMode = .center
            }
            let arrowImgView = UIImageView().then {
                $0.image = UIImage(named: "arrow_btn")
                $0.contentMode = .center
            }
            [tit,content,newImg,arrowImgView].forEach {
                btn.addSubview($0)
            }
            tit.snp.makeConstraints {
                $0.left.equalToSuperview().offset(margin2)
                $0.bottom.equalTo(btn.snp.centerY).offset(-5)
            }
            content.snp.makeConstraints {
                $0.left.equalToSuperview().offset(margin2)
                $0.top.equalTo(btn.snp.centerY).offset(5)
            }
            newImg.snp.makeConstraints {
                $0.centerY.equalTo(tit).offset(-2)
                $0.left.equalTo(tit.snp.right).offset(5)
            }
            arrowImgView.snp.makeConstraints {
                $0.right.equalToSuperview().offset(-margin2)
                $0.centerY.equalTo(content)
            }
            btns.append(btn)
        }
        return btns
    }()
    let AIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubviewFunc()
        setLayout()
        print("유저 이미지")
        print(UserDefaults.standard.string(forKey: "user_image") ?? "")
        print(UserDefaults.standard.string(forKey: "user_image") == "null")
    }
    required init?(coder: NSCoder) {
        fatalError("init error")
    }
    func addSubviewFunc(){
        [sclView].forEach {
            self.addSubview($0)
        }
        for i in 0...3 {
            sclView.addSubview(shopBtns[i])
        }
        [profileBtn,editProfileBtn,nameLbl,settingBtn,getSampleBtn,likeSampleBtn,deliveryBtn,noticeBtn,cartImgView,cartLbl,topLine,middleLine,verticalMiddleLine,bottomLine].forEach {
            sclView.addSubview($0)
        }
        [noticeLbl,noticeContentLbl,noticeArrow].forEach {
            noticeBtn.addSubview($0)
        }
    }
    func setLayout(){
        sclView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
            $0.width.equalTo(screenBounds2.width)
        }
        profileBtn.snp.makeConstraints {
            $0.left.equalToSuperview().offset(margin2)
            $0.top.equalToSuperview().offset(30)
            $0.size.equalTo(CGSize(width: 100, height: 100))
        }
        profileBtn.layer.cornerRadius = 50
        editProfileBtn.snp.makeConstraints {
            $0.right.bottom.equalTo(profileBtn).offset(-5)
            
        }
        nameLbl.snp.makeConstraints {
            $0.centerY.equalTo(profileBtn)
            $0.left.equalTo(profileBtn.snp.right).offset(margin2)
        }
        settingBtn.snp.makeConstraints {
            $0.left.equalTo(nameLbl.snp.right).offset(10)
            $0.centerY.equalTo(nameLbl)
            $0.size.equalTo(CGSize(width: 50, height: 50))
        }
        getSampleBtn.snp.makeConstraints {
            $0.top.equalTo(profileBtn.snp.bottom).offset(40)
            $0.left.equalToSuperview().offset(margin2)
            $0.right.equalTo(likeSampleBtn.snp.left).offset(-5)
            $0.height.equalTo(40)
        }
        likeSampleBtn.snp.makeConstraints {
            $0.top.equalTo(getSampleBtn)
            $0.left.equalTo(getSampleBtn.snp.right)
            $0.right.equalTo(deliveryBtn.snp.left).offset(-5)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.width.equalTo(getSampleBtn)
        }
        deliveryBtn.snp.makeConstraints {
            $0.top.equalTo(getSampleBtn)
            $0.right.equalToSuperview().offset(-margin2)
            $0.left.equalTo(likeSampleBtn.snp.right)
            $0.height.equalTo(40)
            $0.width.equalTo(getSampleBtn)
        }
//        noticeBtn.snp.makeConstraints {
//            $0.top.equalTo(getSampleBtn.snp.bottom).offset(20)
//            $0.left.equalToSuperview().offset(margin2)
//            $0.right.equalToSuperview().offset(-margin2)
//            $0.height.equalTo(40)
//        }
//        noticeLbl.snp.makeConstraints {
//            $0.left.equalToSuperview().offset(margin2 * 2)
//            $0.centerY.equalToSuperview()
//        }
//        noticeContentLbl.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.centerY.equalToSuperview()
//        }
//        noticeArrow.snp.makeConstraints {
//            $0.right.equalToSuperview().offset(-margin2)
//            $0.centerY.equalToSuperview()
//        }
        cartImgView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(margin2)
            $0.top.equalTo(getSampleBtn.snp.bottom).offset(20)
        }
        cartLbl.snp.makeConstraints {
            $0.left.equalTo(cartImgView.snp.right).offset(5)
            $0.centerY.equalTo(cartImgView)
        }
//        shopBtns[0].snp.makeConstraints {
//            $0.top.equalTo(cartLbl.snp.bottom).offset(20)
//            $0.left.equalToSuperview().offset(margin2)
//            $0.right.equalTo(super.snp.centerX)
//            $0.height.equalTo(80)
//        }
        shopBtns[1].snp.makeConstraints {
            $0.top.equalTo(cartLbl.snp.bottom).offset(20)
            $0.right.equalToSuperview().offset(-margin2)
            $0.left.equalTo(super.snp.centerX)
            $0.height.equalTo(80)
        }
//        shopBtns[2].snp.makeConstraints {
//            $0.top.equalTo(shopBtns[0].snp.bottom)
//            $0.left.equalToSuperview().offset(margin2)
//            $0.right.equalTo(super.snp.centerX)
//            $0.height.equalTo(80)
//        }
        shopBtns[3].snp.makeConstraints {
            $0.top.equalTo(cartLbl.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(margin2)
            $0.right.equalTo(super.snp.centerX)
            $0.height.equalTo(80)
        }
        topLine.snp.makeConstraints {
            $0.bottom.equalTo(shopBtns[1].snp.top)
            $0.left.equalTo(shopBtns[3])
            $0.right.equalTo(shopBtns[1])
            $0.height.equalTo(2)
        }
//        middleLine.snp.makeConstraints {
//            $0.top.equalTo(shopBtns[0].snp.bottom)
//            $0.left.equalTo(shopBtns[0])
//            $0.right.equalTo(shopBtns[1])
//            $0.height.equalTo(2)
//        }
        verticalMiddleLine.snp.makeConstraints {
            $0.top.equalTo(shopBtns[1])
            $0.bottom.equalTo(shopBtns[1])
            $0.centerX.equalTo(shopBtns[3].snp.right)
            $0.width.equalTo(2)
        }
        bottomLine.snp.makeConstraints {
            $0.top.equalTo(shopBtns[1].snp.bottom)
            $0.left.equalTo(shopBtns[3])
            $0.right.equalTo(shopBtns[1])
            $0.height.equalTo(2)
            $0.bottom.equalToSuperview().offset(-100)
        }
//        AIView.snp.makeConstraints {
//            $0.top.equalTo(shopBtns[3].snp.bottom).offset(20)
//            $0.left.right.equalToSuperview()
//            $0.bottom.equalToSuperview().offset(-50)
//            $0.height.equalTo(300)
//        }
        
    }
}
