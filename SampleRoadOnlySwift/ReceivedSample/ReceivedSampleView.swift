//
//  receivedSampleView.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/11/04.
//

import Foundation

class ReceivedSampleView: UIView {
   
    let common = CommonS()
    let screenBounds = UIScreen.main.bounds
    
    let topView = SimpleTopView()
    lazy var countLbl = UILabel().then{
        $0.text = "총 3개"
        $0.textColor = common.pointColor()
        $0.font = common.setFont(font: "bold", size: 15)
        $0.asColor(targetStringList: ["총","개"], color: common.setColor(hex: "#b1b1b1"))
    }
    lazy var allDeleteBtn = UIButton().then{
        $0.setTitle("전체 삭제", for: .normal)
        $0.setTitleColor(common.setColor(hex: "$b1b1b1"), for: .normal)
        $0.titleLabel?.font = common.setFont(font: "bold", size: 10)
        $0.layer.borderWidth = 1
    }
    lazy var topLineView = UIView().then{
        $0.backgroundColor = common.gray()
    }
    let receivedSampleTableView = UITableView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        receivedSampleTableView.register(ReceivedSampleTableViewCell.self, forCellReuseIdentifier: ReceivedSampleTableViewCell.cellId)
        addSubviewFunc()
        setLayout()
        receivedSampleTableView.delegate = self
        receivedSampleTableView.dataSource = self
        receivedSampleTableView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("initFail")
    }
    func addSubviewFunc(){
        [topView,countLbl,allDeleteBtn,topLineView,receivedSampleTableView].forEach{
            self.addSubview($0)
        }
    }
    func setLayout(){
        topView.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.size.height.equalTo(screenBounds.width/4)
        }
        countLbl.snp.makeConstraints{
            $0.top.equalTo(topView.snp.bottom).offset(margin2)
            $0.left.equalToSuperview().offset(margin2)
        }
        allDeleteBtn.snp.makeConstraints{
            $0.top.equalTo(topView.snp.bottom).offset(margin2)
            $0.right.equalToSuperview().offset(-margin2)
            $0.size.equalTo(CGSize(width: margin2 * 3, height: margin2))
        }
        topLineView.snp.makeConstraints{
            $0.top.equalTo(allDeleteBtn.snp.bottom).offset(margin2)
            $0.left.right.equalToSuperview()
            $0.size.height.equalTo(2)
        }
        receivedSampleTableView.snp.makeConstraints{
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(topLineView.snp.bottom)
        }
        
    }
}
extension ReceivedSampleView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ReceivedSampleTableViewCell(style: ReceivedSampleTableViewCell.CellStyle.default, reuseIdentifier: ReceivedSampleTableViewCell.cellId)
        return cell
    }
    
     
}
