//
//  RankSViewController.swift
//  sampleroad
//
//  Created by NOTEGG on 2022/07/28.
//  Copyright © 2022 CNKANG. All rights reserved.
//

import UIKit

@objc class RankSViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    var navi: UINavigationController?
    
    var screenBounds = CGRect()
    let whiteView = UIView().then{
        $0.backgroundColor = .white
    }
    var superVc = UIViewController()
    
    @objc init(screenRect: CGRect) {
        self.screenBounds  = screenRect
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        return tableView
    }()
    let slideScrollView = UIScrollView()
    var typeArr = [String]()
//    var typeArr = ["전체", "비건", "메디컬", "자연주의", "무향", "유향", "매끈", "보습"]
    let margin = 20.0
    
    var viewY = CGFloat()
    var rankInfoDicArr = [[String:Any]]()
    var selectedBtn = UIButton()
    var noDataView = UIView()
    var recentKeyword =  String()
    var page: Int = 1
    lazy var typeBtnWidth = (screenBounds.width - margin * 2)/6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        
        view.frame = screenBounds
        whiteView.frame = screenBounds
        slideScrollView.frame = CGRect(x: margin, y: 0 , width: screenBounds.width - margin * 2, height: margin * 2)
        slideScrollView.translatesAutoresizingMaskIntoConstraints = false
        slideScrollView.showsHorizontalScrollIndicator = false
        
        viewY = slideScrollView.frame.origin.y + slideScrollView.frame.size.height
        
        tableView.frame = CGRect(x: 0, y: viewY , width: screenBounds.width - margin, height: screenBounds.height - viewY)
        tableView.separatorStyle = .none
        getTypeArr()
        view.addSubview(whiteView)
        whiteView.addSubview(slideScrollView)
        whiteView.addSubview(tableView)
        selectRank(keywords: "전체")
    }
    
    
    func getTypeArr(){
        let categories = UserDefaults.standard.string(forKey: "setting-categories") ?? ""
        typeArr = categories.components(separatedBy: ",")
        typeArr.insert("전체", at: 0)
        self.drawSlideView()
    }
    func drawSlideView(){
        var orgX:CGFloat = 10.0
        let typeMargin:CGFloat = (screenBounds.width - margin * 2)/12
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        slideScrollView.contentSize = CGSize(width: typeBtnWidth * CGFloat(typeArr.count), height: margin * 2)
        for i in 0...typeArr.count - 1{
            let typeBtn = UIButton()
            var react = CGRect()
            typeBtn.setTitle(typeArr[i], for: .normal)
            typeBtn.titleLabel?.font = Common.kFont(withSize: "bold", 14)
            typeBtn.setTitleColor(Common.color(withHexString: "#b1b1b1"), for: .normal)
            react = Common.labelFitRect(typeBtn.titleLabel!)
            typeBtn.tag = i
            let typeBtnWidth = react.width
            typeBtn.frame = CGRect(x: orgX , y: 0, width: typeBtnWidth, height: slideScrollView.frame.size.height)
            slideScrollView.addSubview(typeBtn)
            //            typeBtn.layer.borderWidth = 1
            typeBtn.addTarget(self, action: #selector(touchTypeBtn), for: .touchUpInside)
            if i == 0 {
                selectedBtn = typeBtn
                typeBtn.setTitleColor(Common.pointColor1(), for: .normal)
                typeBtn.titleLabel?.font = Common.kFont(withSize: "bold", 14)
            }
            orgX += typeBtnWidth + typeMargin
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankInfoDicArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (screenBounds.width - margin * 2)/5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dic: [String : Any] = rankInfoDicArr[indexPath.row]
        guard let productId = dic["_id"] as? String else {return}
        let vc = DetailProductViewController(productDic: dic)
        navi?.pushViewController(vc, animated: true)
        
        //        let sc = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        //        sc.navController.pushViewController(viewController, animated: true)
        
        //        self.navigationController?.pushViewController(viewController, animated: true)
        //        let navi = UINavigationController()
        //        navi.pushViewController(viewController, animated: true)
        //            superVc.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:CustomCell? = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomCell
        if cell == nil {
            cell = CustomCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
            cell?.selectionStyle = .none
        }
        cell?.selectionStyle = .none
        for view in cell!.subviews {
            view.removeFromSuperview()
        }
        let cloudImgView = UIImageView()
        let numberLbl = UILabel()
        let itemImgView = UIImageView()
        let brandLbl = UILabel()
        let itemNameLbl = UILabel()
        var numArr = [Int]()
        let rankDic = rankInfoDicArr[indexPath.row]
        let itemName = rankDic["name"] as? String ?? ""
        let brandDic = rankDic["brand"] as? [String:Any] ?? [:]
        let brandName = brandDic["name"] as? String ?? ""
        let thumDic = rankDic["thumbnail"] as? [String:Any] ?? [:]
        var thumbURL = String()
        if let itemUrl = thumDic["url"] as? String {
            thumbURL = itemUrl
            let encoded = thumbURL.description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let url = URL(string: encoded!)
            let common = CommonSwift()
            common.setImageUrl(url: encoded!, imageView: itemImgView)
        }else {
            let encoded = thumbURL.description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let url = URL(string: encoded!)
            let common = CommonSwift()
            itemImgView.image = UIImage(named: "logo_top_btn")
        }
        
        
        for i in 1...rankDic.count {
            numArr.append(i)
        }
        
        cloudImgView.image = UIImage(named: "cloud_btn")
        cloudImgView.frame = CGRect(x: 6, y: 0, width: (cell?.frame.size.height)!, height: (cell?.frame.size.height)!)
        print("####")
        print(cell?.frame.size.height)
        print(cell?.frame.size.height)
        cloudImgView.contentMode = .scaleAspectFit
        //numberLbl.text = String(describing: numArr[indexPath.row])
        numberLbl.text = String(describing: indexPath.row + 1)
        numberLbl.font = Common.kFont(withSize: "bold", 18)
        numberLbl.textColor = Common.pointColor1()
        numberLbl.frame = CGRect(x: 0, y: (cell?.frame.size.height)! / 2 - (numberLbl.font.pointSize) / 2 + 3, width: (cell?.frame.size.height)!, height: numberLbl.font.pointSize)
        numberLbl.textAlignment = .center
        
        if indexPath.row + 1  > 3 {
            cloudImgView.image = nil
            numberLbl.textColor = Common.color(withHexString: "b1b1b1")
        }
        
     
        
        
        
        //        DispatchQueue.main.sync() { [weak self] in
        //
        //            let data = try Data(contentsOf: url!)
        //            itemImgView.image = UIImage(data: data)
        //        }
        let width = screenBounds.width/8 - (margin * 2)/7
        itemImgView.frame =  CGRect(x: cloudImgView.frame.origin.x + cloudImgView.frame.width, y: 0, width:  width, height: (cell?.frame.height)!)
//            itemImgView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        itemImgView.contentMode = .scaleAspectFit
        brandLbl.text = brandName
        brandLbl.font = Common.kFont(withSize: "regular", 17)
        brandLbl.textColor = Common.color(withHexString: "6f6f6f")
        let margin2x = margin * 2
        brandLbl.frame = CGRect(x: cloudImgView.frame.origin.x + 8.0 + cloudImgView.frame.width + screenBounds.width/7 - (margin * 2)/7, y: ((cell?.frame.height)!)/2 - brandLbl.font.pointSize - 3.0, width: tableView.frame.width - (itemImgView.frame.origin.x + itemImgView.frame.width), height: brandLbl.font.pointSize + 5.0)
        
        itemNameLbl.text = itemName
        itemNameLbl.font = Common.kFont(withSize: "bold", 17)
        itemNameLbl.textColor = Common.color(withHexString: "6f6f6f")
        itemNameLbl.frame = CGRect(x: brandLbl.frame.origin.x, y: ((cell?.frame.height)!)/2 + 3 , width: brandLbl.frame.width - 10, height: itemNameLbl.font.pointSize)
        
        //        itemImgView.backgroundColor = .blue
        
        
        
        
        cell?.addSubview(cloudImgView)
        cloudImgView.addSubview(numberLbl)
        cell?.addSubview(itemImgView)
        cell?.addSubview(brandLbl)
        cell?.addSubview(itemNameLbl)
        return cell!
    }
    
    @objc func selectRank(keywords: String) {
        var params: [String:Any] = [:]
        
        //params.updateValue("nil", forKey: "search:name")
        //        params.updateValue("ㅗㅓㅓㅗ", forKey: "search:keywords")
        //        params.updateValue("-totalReview", forKey: "sort")
        //
        
        var converKeywords = String()
        recentKeyword = keywords
        
        if keywords == "전체"{
            converKeywords = ""
        }else{
            converKeywords = "&search:keywords=" + Common.urlEncode(keywords)
        }
        
        
        COMController.sendRequestGet("https://api.clayful.io/v1/products?sort=-totalReview\(converKeywords)&limit=10&page=\(page)", nil, self, #selector(selectReviewCallBack(result:)))
    }
    @objc func selectReviewCallBack(result :NSData) {
        let common = CommonSwift()
        let arrDict = common.JsonToDicArray(data: result)!
        if arrDict.count == 10 {
            for i in 0...arrDict.count - 1{
                rankInfoDicArr.append(arrDict[i])
            }
            page += 1
            selectRank(keywords: recentKeyword)
        }else if arrDict.count == 0{
            page = 1
            noDataView.removeFromSuperview()
            if (rankInfoDicArr.count > 0) {
                tableView.reloadData()
                tableView.dataSource = self
                tableView.delegate = self
            }else {
                noDataView = Common.nodataView(tableView.frame, "조회된 제품이 없습니다.")
                self.view.addSubview(noDataView)
            }
        }else{
            for i in 0...arrDict.count - 1{
                rankInfoDicArr.append(arrDict[i])
            }
            page = 1
            noDataView.removeFromSuperview()
            
            if (rankInfoDicArr.count > 0) {
                tableView.reloadData()
                tableView.dataSource = self
                tableView.delegate = self
            }else {
                noDataView = Common.nodataView(tableView.frame, "조회된 제품이 없습니다.")
                self.view.addSubview(noDataView)
            }
        }
        
        
        
        //           NSLog("refundOrderCallback : %@", String(describing: common.JsonToDicArray(data: result)));
        
    }
    
    @objc func touchTypeBtn(sender: UIButton){
        let keywords = typeArr[sender.tag]
        
        if (sender.tag >= 4) {
            let rigthOffset = CGPoint(x: slideScrollView.contentSize.width - slideScrollView.bounds.size.width + slideScrollView.contentInset.right, y: 0)
            slideScrollView.setContentOffset(rigthOffset, animated: true)
        }else {
            slideScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
        
        for i in 0...typeArr.count - 1{
            sender.setTitleColor(Common.color(withHexString: "#b1b1b1"), for: .normal)
            sender.titleLabel?.font = Common.kFont(withSize: "Regular", 14)
        }
        if selectedBtn != nil{
            selectedBtn.setTitleColor(Common.color(withHexString: "#b1b1b1"), for: .normal)
            selectedBtn.titleLabel?.font = Common.kFont(withSize: "Regular", 14)
        }
        sender.setTitleColor(Common.pointColor1(), for: .normal)
        selectedBtn = sender
        page = 1
        rankInfoDicArr.removeAll()
        tableView.reloadData()
        selectRank(keywords: keywords)
        sender.titleLabel?.font = Common.kFont(withSize: "bold", 14)
        Common.vibrate(1)
        
        
    }
    //
    //   @objc func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
    //        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    //    }
    //
    
}

