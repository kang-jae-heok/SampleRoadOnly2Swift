//
//  MyReviewView.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/12/01.
//

import Foundation

class MyReviewView: UIView {

    lazy var nameLbl = UILabel().then {
        $0.text = "\(UserDefaults.standard.string(forKey: "user_alias") ?? "")님"
        $0.font = common2.setFont(font: "bold", size: 15)
        $0.textColor = common2.gray()
    }
    lazy var countLbl = UILabel().then {
        $0.text = "총 0개"
        $0.textColor = common2.gray()
        $0.font = common2.setFont(font: "bold", size: 15)
    }
    lazy var couponBackGroundView = UIView().then {
        $0.backgroundColor = common2.pointColor()
    }
    lazy var couponSubBackGroundView = UIView().then {
        $0.backgroundColor = .white
    }
    lazy var couponSubSubBackGroundView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderWidth = 2
        $0.layer.borderColor = common2.pointColor().cgColor
        $0.layer.cornerRadius = 8
    }
    lazy var couponTit = UILabel().then {
        $0.text = "리뷰 10번 작성하면 한 번은 무료배송!"
        $0.font = common2.setFont(font: "bold", size: 12)
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.textAlignment = .center
    }
    lazy var reviewTit = UILabel().then {
        $0.text = "리뷰 쿠폰"
        $0.font = common2.setFont(font: "bold", size: 12)
        $0.backgroundColor = .white
        $0.textAlignment = .center
    }
    let reviewTableView = UITableView().then {
        $0.separatorStyle = .none
    }
    let noneReviewView = NoneView().then {
        $0.tit.text = "작성하신 리뷰가 없습니다"
        $0.isHidden = true
    }
    

    let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
    }
    let stackView2 = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
    }
    lazy var circleViews: [UIButton] = { [self] in
       var circleViewArr = [UIButton]()
        for i in 0...9 {
            let circleView = UIButton().then {
                $0.layer.borderWidth = 1
                $0.backgroundColor = .white
                $0.layer.borderColor = self.common2.pointColor().cgColor
                $0.clipsToBounds = true
                
                circleViewArr.append($0)
                if i < 5 {
                    stackView.addArrangedSubview($0)
                }else {
                    stackView2.addArrangedSubview($0)
                }
            }
        }
        return circleViewArr
    }()

  

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor  = .white
        addSubviewFunc()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init-fail")
    }
    func addSubviewFunc(){
        [nameLbl,countLbl,couponBackGroundView,reviewTableView,noneReviewView].forEach {
            self.addSubview($0)
        }
        couponBackGroundView.addSubview(couponSubBackGroundView)
        couponBackGroundView.addSubview(couponTit)
        couponSubBackGroundView.addSubview(couponSubSubBackGroundView)
        couponSubBackGroundView.addSubview(reviewTit)
        couponSubSubBackGroundView.addSubview(stackView)
        couponSubSubBackGroundView.addSubview(stackView2)
        
    }
    func setLayout(){
   
        nameLbl.snp.makeConstraints {
            $0.top.equalToSuperview().offset(margin2)
            $0.left.equalToSuperview().offset(margin2)
        }
        countLbl.snp.makeConstraints {
            $0.top.equalToSuperview().offset(margin2)
            $0.right.equalToSuperview().offset(-margin2)
        }
        couponBackGroundView.snp.makeConstraints {
            $0.top.equalTo(countLbl.snp.bottom).offset(margin2)
            $0.left.equalToSuperview().offset(margin2)
            $0.right.equalToSuperview().offset(-margin2)
        }
        couponSubBackGroundView.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(5)
            $0.right.equalToSuperview().offset(-5)
            $0.bottom.equalToSuperview().offset(-couponTit.font.pointSize - 15)
        }
        couponTit.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-5)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(couponTit.font.pointSize + 5)
            $0.width.equalTo(200)
        }
        couponTit.layer.cornerRadius = (couponTit.font.pointSize + 5)/2
        couponSubSubBackGroundView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.left.right.equalToSuperview().inset(5)
        }
        reviewTit.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(couponSubSubBackGroundView.snp.top)
            $0.height.equalTo(reviewTit.font.pointSize + 5)
            $0.width.equalTo(70)
        }
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.left.right.equalToSuperview().inset(10)
            $0.bottom.equalTo(stackView2.snp.top).offset(-10)
        }
        circleViews.forEach {
            $0.snp.makeConstraints{
                $0.size.equalTo(CGSize(width: 50 * screenRatio, height: 50 * screenRatio))
            }
            $0.layer.cornerRadius = 25 * screenRatio
        }
        stackView2.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(10)
            $0.bottom.left.right.equalToSuperview().inset(10)
            $0.top.equalTo(couponSubSubBackGroundView.snp.centerY)
        }
        reviewTableView.snp.makeConstraints {
            $0.bottom.left.right.equalToSuperview()
            $0.top.equalTo(couponBackGroundView.snp.bottom).offset(margin2)
        }
        noneReviewView.snp.makeConstraints {
            $0.edges.equalTo(reviewTableView)
        }
        
    }
    
}
