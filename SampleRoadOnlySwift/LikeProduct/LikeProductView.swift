//
//  receivedSampleView.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/11/04.
//

import Foundation

class LikeProductView: UIView {
   
    let common = CommonS()
    let screenBounds = UIScreen.main.bounds
    
    let topView = SimpleTopView().then {
        $0.tit.text = "찜"
    }
    lazy var countLbl = UILabel().then{
        $0.text = "총 3개"
        $0.textColor = common.pointColor()
        $0.font = common.setFont(font: "bold", size: 15)
        $0.asColor(targetStringList: ["총","개"], color: common.setColor(hex: "#b1b1b1"))
    }
    lazy var allDeleteBtn = UIButton().then{
        $0.setTitle("전체 삭제", for: .normal)
        $0.setTitleColor(common.gray(), for: .normal)
        $0.titleLabel?.font = common.setFont(font: "bold", size: 12)
        $0.layer.borderColor  = common.gray().cgColor
        $0.layer.borderWidth = 1
    }
    lazy var topLineView = UIView().then{
        $0.backgroundColor = common.gray()
    }
    let likeProductTableView = UITableView()
    let noneView = NoneView().then {
        $0.tit.text = "찜한 제품이 없습니다"
        $0.isHidden = true
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubviewFunc()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("initFail")
    }
    func addSubviewFunc(){
        [topView,countLbl,allDeleteBtn,topLineView,likeProductTableView,noneView].forEach{
            self.addSubview($0)
        }
    }
    func setLayout(){
        topView.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.size.height.equalTo(screenBounds.width/4)
        }
        countLbl.snp.makeConstraints{
            $0.centerY.equalTo(allDeleteBtn)
            $0.left.equalToSuperview().offset(margin2)
        }
        allDeleteBtn.snp.makeConstraints{
            $0.top.equalTo(topView.snp.bottom).offset(margin2)
            $0.right.equalToSuperview().offset(-margin2)
            $0.size.equalTo(CGSize(width: margin2 * 4, height: margin2 * 2))
        }
        topLineView.snp.makeConstraints{
            $0.top.equalTo(allDeleteBtn.snp.bottom).offset(margin2)
            $0.left.right.equalToSuperview()
            $0.size.height.equalTo(2)
        }
        likeProductTableView.snp.makeConstraints{
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(topLineView.snp.bottom)
        }
        noneView.snp.makeConstraints {
            $0.edges.equalTo(likeProductTableView)
        }
        
    }
}


