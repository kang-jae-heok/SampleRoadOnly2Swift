//
//  SelectedSampleView.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/10/18.
//

import Foundation
import UIKit
class SelectedSampleView: UIView {
    let screenBounds = UIScreen.main.bounds
    let common = CommonS()
    lazy var titLbl = UILabel().then{
        $0.text = "강재혁님이 선택하신 샘플"
        $0.font = common.setFont(font: "bold", size: 15)
        $0.textAlignment = .center
    }
    let tableView = UITableView().then{
        $0.register(SelectedTableCell.self, forCellReuseIdentifier:  CustomCell.identifier)
    }
    var sampleArrDic = [[String:Any]]()
    lazy var getSampleBtn = UIButton().then{
        $0.backgroundColor = common.pointColor()
        $0.setTitle("샘플받기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = common.setFont(font: "bold", size: 15)
        $0.addTarget(self, action: #selector(touchGetSampleBtn), for: .touchUpInside)
    }
    var vc = UIViewController()
    public init(frame: CGRect, arrDic: [[String:Any]], vc: UIViewController) {
        super.init(frame: frame)
        sampleArrDic = arrDic
        self.vc = vc
        addSubviewFunc()
        setLayout()
        self.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    required init?(coder: NSCoder) {
        fatalError("init fail")
    }
    func setLayout(){
        titLbl.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(self.snp.top).offset(100)
        }
        getSampleBtn.snp.makeConstraints{
            $0.bottom.left.right.equalToSuperview()
            $0.top.equalTo(self.snp.bottom).offset(-70)
        }
        tableView.snp.makeConstraints{
            $0.top.equalTo(titLbl.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(getSampleBtn.snp.top)
        }
    }
    func addSubviewFunc(){
        [titLbl,tableView,getSampleBtn].forEach{
            self.addSubview($0)
        }
    }
    @objc func touchGetSampleBtn(){
//        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
//           [param setObject:self.selectSampleList forKey:@"sample_list"];
//           OrderViewController*viewController = [[OrderViewController alloc] initWithDic:param];
//           [self.navigationController pushViewController:viewController animated:YES];
        var param = [String:Any]()
        param.updateValue(sampleArrDic, forKey: "sample_list")
        let convertDic = NSMutableDictionary(dictionary: param)
        let rootVc = OrderViewController(dic: convertDic)
        vc.navigationController?.pushViewController(rootVc, animated: true)
    }
}
extension SelectedSampleView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleArrDic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SelectedTableCell
        print("hi")
        let sampleDic = sampleArrDic[indexPath.row]
        let brandDic = sampleDic["brand"] as! [String:Any]
//        let brandDic = dataDic["brand"] as! [String:Any]
//        let ThumDic = dataDic["thumbnail"] as! [String:Any]
//        let ThumbURL = ThumDic["url"] as! String
//        let encoded = ThumbURL.description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//        print(dataDic["name"] as! String)
//        cell.sampleName.text = dataDic["name"] as? String
//        cell.companyLbl.text = brandDic["name"] as? String
//        common.setImageUrl(url: encoded!, imageView: cell.sampleImgView)
        cell.companyLbl.text = brandDic["name"] as? String
        cell.sampleName.text = sampleDic["name"] as? String
        let ThumDic = sampleDic["thumbnail"] as! [String:Any]
        let ThumbURL = ThumDic["url"] as! String
        let encoded = ThumbURL.description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        common.setImageUrl(url: encoded!, imageView: cell.sampleImgView)
        cell.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
