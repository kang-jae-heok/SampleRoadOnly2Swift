//
//  Intro.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/09/20.
//

import Foundation
import UIKit

class IntroView: UIView {
    let margin = 50
    let screenBounds = UIScreen.main.bounds
    let common = Common()
    let vc = IntroViewController()
    lazy var betweenY = (screenBounds.height/2 - screenBounds.width/4 - screenBounds.width/6)/2
    var introIndex = 0{
        didSet {
            checkIntroIndex()
        }
    }
    let pageInt = Int()
    let scrollView = UIScrollView().then{
        $0.showsHorizontalScrollIndicator = false
        $0.bounces = false
        $0.isPagingEnabled = true
    }
    let stackView = UIStackView().then{
        $0.axis = .horizontal
        $0.spacing = 0
        $0.alignment = .fill
        $0.distribution = .fill
    }
    lazy var copyRight = UILabel().then{
        $0.text = "ⓒTov&Banah"
        $0.font = common.setFont(font: "light", size: 10)
        $0.textColor = .black
    }
    lazy var bottomLabel = UILabel().then{
        $0.text = "FIND YOUR WAY"
        $0.font = common.setFont(font: "bold", size: 18)
        $0.textColor = common.pointColor()
    }
    lazy var startBtn = UIButton().then{
        $0.setTitle("시작하기", for: .normal)
        $0.titleLabel?.textColor = .white
        $0.backgroundColor = common.lightGray()
        $0.titleLabel!.font = common.setFont(font: "bold", size: 18)
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(touchStartBtn), for: .touchUpInside)
    }
    let pageViewStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    lazy var pageController: [UIButton] = {
        var pageController = [UIButton]()
        for i in 0...3{
            let btn = UIButton()
            btn.backgroundColor = .white
            btn.layer.borderWidth = 1
            btn.layer.borderColor = common.lightGray().cgColor
            btn.tag = i
            btn.frame.size.width = 9
            btn.frame.size.height = 9
            btn.layer.cornerRadius = btn.frame.width / 2
            btn.clipsToBounds = true
            pageController.append(btn)
            pageViewStackView.addArrangedSubview(btn)
        }
        return pageController
    }()
    lazy var stackViewData1 = UIView().then{
        let title1 = UILabel().then{
            $0.text = "심플하게"
            $0.textColor = common.pointColor()
            $0.font = common.setFont(font: "light", size: 60)
            $0.asFont(targetStringList: ["심플"], font: common.setFont(font: "extraBold", size: 60))
        }
        let title2 = UILabel().then{
            $0.text = "샘플받자"
            $0.textColor = common.pointColor()
            $0.font = common.setFont(font: "light", size: 60)
            $0.asFont(targetStringList: ["샘플"], font: common.setFont(font: "extraBold", size: 60))
        }
        $0.addSubview(title1)
        $0.addSubview(title2)
        title1.snp.makeConstraints{
            $0.bottom.equalTo(title2.snp.top).offset(0)
            $0.left.equalToSuperview().offset(margin)
        }
        title2.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-betweenY)
            $0.left.equalToSuperview().offset(margin)
        }
        $0.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview($0)
    }
    lazy var stackViewData: [UIView] = {
        var views = [UIView]()
        var imgviews = [UIImageView]()
        let imgArr = ["2.-Onboarding-2","2.-Onboarding-3","2.-Onboarding-4"]
        let textArr = [["사서 고생 말고", "AI에게 추천받고!"],["구매 전에", "샘플 발라보고!"],["최저가로", "구매하자!"]]
        for i in 0...2 {
            let view = UIView()
            let imgView = UIImageView()
            let label1 = UILabel().then{
                $0.font = common.setFont(font: "light", size: 23)
                $0.textColor = common.pointColor()
            }
            let label2 = UILabel().then{
                $0.font = common.setFont(font: "light", size: 23)
                $0.textColor = common.pointColor()
            }
            imgView.tag = i
            imgView.image = UIImage(named: imgArr[i])
            imgView.contentMode = .scaleAspectFill
            if i == 0 {
                label1.text = textArr[i][0]
                label1.asFont(targetStringList: ["사서 고생"], font: common.setFont(font: "bold", size: 27))
                label2.text = textArr[i][1]
                label2.asFont(targetStringList: ["AI에게 추천"], font: common.setFont(font: "bold", size: 27))
            }else if i == 1{
                label1.text = textArr[i][0]
                label1.asFont(targetStringList: ["구매 전"], font: common.setFont(font: "bold", size: 27))
                label2.text = textArr[i][1]
                label2.asFont(targetStringList: ["발라보고!"], font: common.setFont(font: "bold", size: 27))
            }else{
                label1.text = textArr[i][0]
                label1.asFont(targetStringList: ["최저가"], font: common.setFont(font: "bold", size: 27))
                label2.text = textArr[i][1]
                label2.asFont(targetStringList: ["구매"], font: common.setFont(font: "bold", size: 27))
            }
            [label1, label2, imgView].forEach{
                view.addSubview($0)
            }
            views.append(view)
            stackView.addArrangedSubview(views[i])

            imgView.snp.makeConstraints{
                $0.top.left.right.equalToSuperview()
                $0.size.equalTo(CGSize(width: screenBounds.width, height: screenBounds.height/2))
            }

            label1.snp.makeConstraints{
                $0.bottom.equalTo(imgView.snp.bottom).offset(betweenY/2)
                $0.centerX.equalToSuperview()
            }
            label2.snp.makeConstraints{
                $0.top.equalTo(label1.snp.bottom)
                $0.centerX.equalToSuperview()
            }
        }

        return views
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubviewFunc()
        setLayout()
        scrollView.delegate = self

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func checkIntroIndex() {
        pageController.forEach{
            $0.backgroundColor = .white
        }
        pageController[introIndex].backgroundColor = common.pointColor()
        if introIndex == 3 {
            startBtn.backgroundColor = common.pointColor()
        }else{
            startBtn.backgroundColor = common.lightGray()
        }
    }

    @objc func touchStartBtn(){
        vc.touchStartBtn()
    }


}
extension IntroView {
    func addSubviewFunc(){

        [scrollView, bottomLabel, startBtn, copyRight, pageViewStackView].forEach{
            self.addSubview($0)
        }
        scrollView.addSubview(stackView)
    }

    func setLayout(){
        let svY = screenBounds.width/4 + screenBounds.width/6 + (screenBounds.height/2 - screenBounds.width/4 - screenBounds.width/6)/2 + 9
        if let top
            = UIApplication.shared.windows.first?.safeAreaInsets.top
        {
            scrollView.contentInset.top = -top
        }
        scrollView.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(pageViewStackView.snp.top)
        }
        stackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.size.equalTo(CGSize(width: screenBounds.width * 4, height:screenBounds.height - svY))
            
        }
        stackViewData1.snp.makeConstraints{
            $0.size.equalTo(CGSize(width: screenBounds.width, height: screenBounds.height - svY))
        }
        stackViewData.forEach{
            $0.snp.makeConstraints{
                $0.size.equalTo(CGSize(width: screenBounds.width, height: screenBounds.height - svY))
            }
        }
        startBtn.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-screenBounds.width/4)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: screenBounds.width - 60, height: screenBounds.width/6))
        }
        bottomLabel.snp.makeConstraints{
            $0.top.equalTo(startBtn.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        copyRight.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-20)
            $0.centerX.equalToSuperview()
        }
        pageController.forEach{
            $0.snp.makeConstraints{
                $0.size.equalTo(CGSize(width: 9, height: 9))
            }
        }
        pageViewStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(startBtn.snp.top).offset(-(screenBounds.height/2 - screenBounds.width/4 - screenBounds.width/6)/2)
            $0.height.equalTo(9)
            $0.width.equalTo(60)
        }


        
    }
}
extension IntroView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x / screenBounds.width
        introIndex = Int(value)
    }
}

