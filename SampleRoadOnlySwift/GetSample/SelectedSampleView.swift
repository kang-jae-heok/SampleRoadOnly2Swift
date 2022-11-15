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
        $0.text = "\(UserDefaults.standard.string(forKey: "user_name") ?? "고객")이 선택하신 샘플"
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
            $0.height.equalTo(100)
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
        print("convert 딕셔너리")
        print(convertDic)
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
        
        let sampleDic = sampleArrDic[indexPath.row]
        let hashTagString = sampleDic["description"] as! String
//        let pTag =  "<p>"
//        let pTag2 =  CharacterSet(charactersIn: "</p>").inverted
        var convertStr = hashTagString.components(separatedBy: "</p>").joined()
        convertStr = convertStr.components(separatedBy: "<p>").joined()
        let convertStrArr = convertStr.components(separatedBy: ",")
        print("여기 해쉬테그")
        print(convertStrArr)
        print("딕셔너리")
        print(sampleDic)
        var hasTag = String()
        hasTag = "#\(convertStrArr[0])"
        for i in 1...convertStrArr.count - 1 {
            hasTag += "\n#\(convertStrArr[i])"
        }
        print(hasTag)
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
        cell.hashtagLbl.text = hasTag
        let viewS = GetSampleView()
        cell.typeTit.text = "\(indexPath.row + 1)| \(viewS.typeTitArr[indexPath.row])"
        let ThumDic = sampleDic["thumbnail"] as! [String:Any]
        let ThumbURL = ThumDic["url"] as! String
        let encoded = ThumbURL.description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        common.setImageUrl(url: encoded!, imageView: cell.sampleImgView)
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
