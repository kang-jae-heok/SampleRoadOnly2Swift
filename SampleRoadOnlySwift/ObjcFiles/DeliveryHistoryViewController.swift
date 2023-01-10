//
//  ViewController.swift
//  tableView
//
//  Created by NOTEGG on 2022/06/22.
//

import UIKit

var listArray:[[String:Any]] = []
extension String{
    func toDate()-> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: self){
            return date
        } else{
            return nil
        }
    }
}
@objc class DeliveryHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let screenBounds = UIScreen.main.bounds
    let margin = 27.0
    var cell_height = UIScreen.main.bounds.size.height / 5 + 10.0 + 44.0
    var cacheDic: [String:Any] = [:]
    var totalArr: [[String:Any]] = []
    
    lazy var topView: UIView = {
        let uiView = UIView()
        
        return uiView
        
    }()
    
    
    let titleLabel = UILabel()
    let backBtn = UIButton()
    let shoppingBtn = UIButton()
    var date = UILabel()
    var itemDict = [[String:Any]]()
    var buttonIndex = Int()
    
    
     let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter
    }()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        return tableView
    }()
    
   

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height //화면 높이
        let itemDic = listArray[indexPath.row] as [String:Any]
        let itemArray = itemDic["items"] as! [[String:Any]]
        
        return cell_height * CGFloat(itemArray.count) - CGFloat(((itemArray.count - 1) * 44))
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Common.vibrate(1)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("테스트2")
        return  listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemDic = listArray[indexPath.row] as [String:Any]
        let itemArray = itemDic["items"] as! [[String:Any]]
        
        
        var cell:CustomCell? = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomCell
        if cell == nil {
            cell = CustomCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
            
        }
        let createdAt = itemDic["createdAt"] as! [String:Any]
        let raw = createdAt["raw"] as! String
        cell?.selectionStyle = .none
        cell?.frame = CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.height / 5 + 10.0)
        
        var isCell:Bool = false
        
        for view in cell!.subviews {
            view.removeFromSuperview()
        }
 
        
        let cW = screenBounds.size.width - (margin*2)
        let titView = UIView()
        let titText = UILabel()
        let caText = UILabel()
        
        let arr:[String] = raw.components(separatedBy: "T")
        let arr2:[String] = arr[1].components(separatedBy: ":")
        
        let test:String = arr[0].replacingOccurrences(of: "-", with: "-")
        let timeStamp:String = test+" "+arr2[0]+":"+arr2[1]
        let common = CommonSwift()
       let convertTime =  common.getTime(time: timeStamp)
        print(";;;;")
        print(raw)
        NSLog("timeStamp   :%@   %@", timeStamp,test)
        titView.addSubview(caText)
        titView.addSubview(titText)
      
        titView.frame = CGRect(x: margin, y: 0, width: cW, height: 44.0)
        titText.frame = CGRect(x: 3, y: 0, width: cW, height: 44.0)
        
        let caTextHeight = ("1" as! NSString).size(withAttributes: [NSAttributedString.Key.font : caText.font]).height
         
        caText.frame = CGRect(x: titView.frame.width-155, y: titView.frame.height-caTextHeight, width: 150, height: caTextHeight)
        caText.textAlignment = .right
        titView.backgroundColor = Common.pointColor1()
        titView.layer.shadowOffset = CGSize(width: 1, height: 1)
        titView.layer.shadowColor = Common.color(withHexString: "#b1b1b1").cgColor
        titView.layer.shadowRadius = 1
        titView.layer.shadowOpacity = 0.5
        titText.text = " 주문번호 \(itemDic["_id"]!) \(itemDic["status"]!)"
        print("여기야")
        print(itemDic["items"])
        titText.textColor = Common.color(withHexString: "#ffffff")
        titText.font = Common.kFont(withSize: "bold", 15)
        titText.tag = 99
        caText.text = convertTime
        caText.textColor = Common.color(withHexString: "#ffffff")
        caText.font = Common.kFont(withSize: "medium", 12)

        cell?.addSubview(titView)
        
        var fromY:CGFloat = 0.0
        var dic:[String:Any] = [:]
        
        var viewH = (cell_height-44) * CGFloat(itemArray.count)
        var cellView  = UIView()
        cellView.frame = CGRect(x: 0, y:(titView.frame.origin.y) + (titView.frame.size.height), width: screenBounds.width - (margin*2), height: viewH)
        
     
        if ((cacheDic[String(indexPath.row)]) != nil) {
            cellView = cacheDic[String(indexPath.row)] as! UIView
            print("cache view" + String(indexPath.row))
        } else {
            
            for x in 0...itemArray.count-1 {
                dic = itemArray[x]

                
                print(itemDic)
                let pView = makeCell(dic: dic, index: indexPath.row)
                let product = dic["product"] as! [String:Any]
                let name = product["name"] as! String
                
                print(name)
                let id = product["_id"] as! String
                let quantity = dic["quantity"] as! [String:Any]
                print(quantity)
                let rawQuantity = quantity["raw"] as! Int
                let tapGesture = refundLongClick(target: self, action: #selector(self.longClickAction(gesture:)))
                tapGesture.orderId = (itemDic["_id"] as! String)
                print(id)
                tapGesture.itemId = dic["_id"] as! String
                tapGesture.quantity = rawQuantity
                
                
                                                              
                pView.frame = CGRect(x: 0, y: fromY , width: pView.frame.size.width, height: pView.frame.size.height)
                cellView.addSubview(pView)
                fromY +=  pView.frame.size.height
                
                if("\(itemDic["status"]!)" == "paid"){
                    cell!.addGestureRecognizer(tapGesture)

                }
                
                let refundsArr =  itemDic["refunds"] as! [[String:Any]]
                if(refundsArr.count != 0){
                    for i in 0...refundsArr.count-1{
                     let itemsArr = refundsArr[i]["items"] as! [[String:Any]]
                        if(itemsArr.count != 0){
                            for x in 0...itemsArr.count-1{
                                let itemDic2 = itemsArr[x]["item"] as! [String:Any]
                                let product = itemDic2["product"] as! [String:Any]
                                let refundedId = product["_id"] as! String
                                print("비교비교비교")
                                print(id)
                                print(refundedId)
                                if(id == refundedId){
                                   
                                    let refundedBtn:UIButton = pView.subviews[5] as! UIButton
                                    print("그만")
                                    print(pView.subviews)
                                    refundedBtn.setTitle("환불됨", for: .normal)
                                }
                            }
                        }
                      
                    }
                }
                print("돌았다")
            }
            cacheDic.updateValue(cellView, forKey: String(indexPath.row))
            
        
        }
        cell?.addSubview(cellView)

        
        
        return cell!
        
    }
    
     class refundLongClick: UILongPressGestureRecognizer{
         var orderId: String?
         var itemId: String?
         var quantity: Int?
         
//         var items
    }
    
    @objc func longClickAction(gesture: refundLongClick){
        let alert = UIAlertController(title: "환불요청", message: "정말로 환불하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        var itemDic: [String:Any] = [:]

        itemDic.updateValue(gesture.itemId as Any, forKey: "item")
        itemDic.updateValue(gesture.quantity as Any, forKey: "quantity")
        let items: [[String:Any]] = [itemDic]
        print(items)
        
        let okAction = UIAlertAction(title: "YES", style: .default) { (action) in
            self.refundOrder(orderId: String(describing: gesture.orderId!), items: items)
            
        }
        let noAction = UIAlertAction(title: "NO", style: .default) { (action) in
            
        }
        alert.addAction(okAction)
        alert.addAction(noAction)
        present(alert, animated: false, completion: nil)
       
        print(gesture.orderId!)
        Common.vibrate(1)
    }
    
    @objc func selectOrder() {
        
        COMController.sendRequestGet("https://api.clayful.io/v1/orders", nil, self, #selector(selectOrderCallback(result:)))
        
    }
    
    
    
    @objc func selectOrderCallback(result :NSData) {
        let common = CommonSwift()
        NSLog("selectOrderCallback : %@", result);
        let arr:[[String:Any]] = common.JsonToDicArray(data: result)!
        listArray = arr
        print("selectOrderCallback    tempArray  : " + String(describing: listArray));
        
        tableView.reloadData()
    }
    
    
    @objc func refundOrder(orderId: String, items: [[String:Any]]) {
        print("Enter in refund")
        var params:[String:Any] = [:]
        let reason = "사용자 변심"
        params.updateValue(reason, forKey: "reason")
//        params.updateValue(Common.jsonObject(toString: items), forKey: "items")
        params.updateValue(Common.object(toJsonString: items), forKey: "items")
        print("파라미터")
        print(params)
        
        COMController.sendRequest("https://api.clayful.io/v1/orders/\(orderId)/refunds", params, self, #selector(refundOrderCallback(result:)))
       
    }
    @objc func refundOrderCallback(result :NSData) {
        let common = CommonSwift()
        NSLog("refundOrderCallback : %@", String(describing: common.JsonToDictionary(data: result)));

    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        buttonIndex = 0
        
        
        
        selectOrder()
        
        

        view.backgroundColor = UIColor.white
        // chevron.backward
        view.addSubview(topView)
        
        
        
        
        
        
        topView.addSubview(titleLabel)
        topView.addSubview(backBtn)
        topView.addSubview(shoppingBtn)
        topView.addSubview(date)

        topView.frame = CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.height/5)
        tableView.frame = CGRect(x: 0, y: topView.frame.height, width: screenBounds.width, height: screenBounds.height - (topView.frame.size.height))
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        titleLabel.text = "주문/배송 조회"
        titleLabel.textColor = Common.color(withHexString: "#97C5E9")
        titleLabel.font = Common.kFont(withSize: "bold", 23)
        titleLabel.sizeToFit()
//        titleLabel.snp.makeConstraints { (make) in
//            make.centerY.equalTo(topView.snp.centerY)
//            make.centerX.equalTo(topView.snp.centerX)
//        }
        let tLibelWidth = ("1" as! NSString).size(withAttributes: [NSAttributedString.Key.font : titleLabel.font]).width
        let tLibelHeight = ("1" as! NSString).size(withAttributes: [NSAttributedString.Key.font : titleLabel.font]).height
        titleLabel.frame = CGRect(x: (screenBounds.width/2)-(200/2), y: topView.frame.height/2 - (tLibelHeight/2), width: 200, height: tLibelHeight)
        titleLabel.textAlignment = .center
        
        let backImg = UIImage(named: "back_btn")
        if #available(iOS 13.0, *) {
            backBtn.setImage(backImg, for: .normal)
        } else {
            // Fallback on earlier versions
        }
        
        backBtn.frame = CGRect(x: 20, y: topView.frame.height/2 - 25, width: 50, height: 50)
        backBtn.contentMode = .scaleAspectFit
        backBtn.addTarget(self, action: #selector(close), for: .touchUpInside)
        let cartImg = UIImage(named: "cart_btn")
   
        shoppingBtn.setImage(cartImg, for: .normal)
       
        //바꾸자
        shoppingBtn.tintColor = Common.color(withHexString: "#97C5E9")
//        shoppingBtn.snp.makeConstraints { (make) in
//            make.centerY.equalTo(topView.snp.centerY)
//            make.right.equalToSuperview().offset(-20)
//        }
        shoppingBtn.frame = CGRect(x: screenBounds.width-75, y: topView.frame.height/2 - 25, width: 50, height: 50)
        shoppingBtn.contentMode = .scaleAspectFit
        shoppingBtn.addTarget(self, action: #selector(touchShoppingBtn), for: .touchUpInside)
        date.font = Common.kFont(withSize: "bold", 17)
      
        
        
        
        
        
    }
    //    @objc func prepareForReuse() {
    //        prepareForReuse()
    //
    //    }
    
    func makeCell(dic:[String:Any], index:Int) -> UIView {
    
        
        let bgView = UIView()
        bgView.frame = CGRect(x: 0, y: 0, width: screenBounds.width, height: cell_height-44.0)
        
        let imageView   = UIImageView()
        let productName = UILabel()
        let companyName = UILabel()
        let discount = UILabel()
        
        let price = UILabel()
        var buyBtn = UIButton()
        let deliveryBtn = UIButton()
        let reviewBtn = UIButton()
        
        
        
        
        //        let width: CGFloat = screenBounds.size.width/6
        //        let height: CGFloat = screenBounds.size.height/10 //화면 높이
        
        
        
        [imageView, productName, companyName, price, discount, buyBtn, deliveryBtn, reviewBtn].forEach {
            bgView.addSubview($0)
        }
        let rBtnW = screenBounds.width/6
        let rBtnH = rBtnW/2
        let bBtnH = rBtnW/3
        let imageW = screenBounds.width/5
        let subMargin = 16.0
        let ivCenterX = (margin+subMargin+(imageW/2))
        let bBtnCenterX = rBtnW/2
        let imageViewY = (imageView.frame.origin.y) + (imageView.frame.height) + 3
        let cLibelHeight = ("1" as! NSString).size(withAttributes: [NSAttributedString.Key.font : companyName.font]).height
        let pLibelHeight = ("1" as! NSString).size(withAttributes: [NSAttributedString.Key.font : productName.font]).height
        let prLibelHeight = ("1" as! NSString).size(withAttributes: [NSAttributedString.Key.font : price.font]).height
        let textLeft = margin+subMargin+rBtnW+10
        imageView.contentMode = .scaleAspectFit
        companyName.textColor = Common.color(withHexString: "#b1b1b1")
        companyName.font = Common.kFont(withSize: "Bold", 12)
        
        buyBtn.setTitle("구매확정", for: .normal)
        buyBtn.backgroundColor = Common.color(withHexString: "#f0f0f0")
        buyBtn.layer.cornerRadius = 2
        buyBtn.setTitleColor(Common.color(withHexString: "#6f6f6f"), for: .normal)
        buyBtn.titleLabel?.font = Common.kFont(withSize: "medium", 12)
        buyBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        buyBtn.addTarget(self, action: #selector(touchBuyBtn), for: .touchUpInside)
        buyBtn.tag = buttonIndex
        

        
        
        
        deliveryBtn.setTitle("배송조회", for: .normal)
        deliveryBtn.backgroundColor = Common.color(withHexString: "#ffffff")
        deliveryBtn.layer.borderWidth = 2
        deliveryBtn.layer.cornerRadius = 8
  
        deliveryBtn.layer.borderColor = Common.color(withHexString: "#b1b1b1").cgColor
        deliveryBtn.titleLabel?.font = Common.kFont(withSize: "bold", 12)
        deliveryBtn.setTitleColor( Common.color(withHexString: "#b1b1b1"), for: .normal)
        deliveryBtn.addTarget(self, action: #selector(touchDeliveryBtn), for: .touchUpInside)
        deliveryBtn.tag = index

        
        
        
        reviewBtn.setTitle("리뷰작성", for: .normal)
        reviewBtn.backgroundColor = Common.color(withHexString: "#97C5E9")
        reviewBtn.setTitleColor(Common.color(withHexString: "#ffffff"), for: .normal)
        reviewBtn.layer.cornerRadius = 8
        reviewBtn.titleLabel?.font = Common.kFont(withSize: "bold", 12)
        reviewBtn.addTarget(self, action: #selector(touchReviewBtn), for: .touchUpInside)
        reviewBtn.tag = buttonIndex
        
        
        totalArr.append(dic)
        buttonIndex += 1

        
        companyName.frame = CGRect(x:textLeft + 10, y:(subMargin)+10, width: 150, height: cLibelHeight)
  
        price.frame = CGRect(x: textLeft + 10, y: subMargin+17+(cLibelHeight/2)+16+(pLibelHeight/2), width: screenBounds.width, height: prLibelHeight)


        
  
        
        

        print(tableView.separatorInset.left)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        reviewBtn.frame = CGRect(x: screenBounds.width-(margin+subMargin+rBtnW), y: (bgView.frame.size.height ?? 0)-(rBtnH+subMargin), width: rBtnW, height: rBtnH)
        deliveryBtn.frame = CGRect(x: reviewBtn.frame.origin.x - (6.0+rBtnW), y: reviewBtn.frame.origin.y, width: rBtnW, height: rBtnH)
        imageView.frame = CGRect(x: (margin+subMargin), y: (subMargin), width:imageW, height: (imageW/3)*4)
        productName.frame = CGRect(x: textLeft + 10, y: subMargin+17+(cLibelHeight/2), width: screenBounds.width - margin - imageView.frame.origin.x - imageView.frame.size.width, height: pLibelHeight)
        buyBtn.frame = CGRect(x: (ivCenterX-bBtnCenterX), y: (reviewBtn.frame.origin.y) , width: rBtnW, height: bBtnH)
        
        
        
        
        let lineView = UIView()
        bgView.addSubview(lineView)
        var lH = 3.0
        lineView.frame = CGRect(x: margin, y: (bgView.frame.size.height ?? 0)-lH , width: screenBounds.width-(margin*2), height: lH)
        lineView.backgroundColor = Common.color(withHexString: "#f5f5f5")
        
        
        
        let product = dic["product"] as! [String:Any]
        let name = product["name"]!
        let thumbnail = product["thumbnail"] as! [String:Any]
        let total = dic["total"] as! [String:Any]
        let priceStr = total["price"] as! [String:Any]
        let sale = priceStr["sale"] as! [String:Any]
        let converted = sale["converted"]!
        let quantity = dic["quantity"] as! [String:Any]
        let brand = dic["brand"] as! [String:Any]
        let brandName = brand["name"]!
        let rawQuantity = quantity["raw"]!
        //        let quantityConverted = quantitiy["converted"]!
        let thumbnailUrl = thumbnail["url"] as! String
        //        let brand = product["brand"] as! [String:Any]
        
        print("아아아")
        print(brandName)
        
        
        
        //        let resultDic = itemDic[0] as! [String:Any]
        //        let productDic = resultDic["product"] as! [String:Any]
        //        let thumbnailDic = productDic["thumbnail"] as! [String:Any]
        let encoded = thumbnailUrl.description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: encoded!)
        
        if url != nil {
         
            
            if url != nil {
                let common = CommonSwift()
                common.setImageUrl(url: encoded!, imageView: imageView)
            }
            
        }
        
        
        
        
        productName.text  = "\(name)"
        
        
        
        companyName.text = "\(brandName)"
        price.text = "\(converted) | \(rawQuantity)개"
        //        cell?.discount.text = "\(arr2[indexPath.row].discount)%"
        let fullText = price.text ?? ""
        let attribtuedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: "| \(rawQuantity)개")
        attribtuedString.addAttribute(.foregroundColor, value:  Common.color(withHexString: "#b1b1b1"), range: range)
        price.font  = Common.kFont(withSize: "bold", 16)
        price.attributedText = attribtuedString
        
        
        
        
        return bgView
    }
    
    @objc func prepareForReuse() {
        prepareForReuse()
        
        
    }
    @objc func touchBuyBtn(sender: UIButton){
        
//        let test:Dictionary =  totalArr[sender.tag]
//        let product = test["product"] as! [String:Any]
//        let name = product["name"] as! String
////        print(product["name"])
//
//        let alert = UIAlertController(title: "buyBtn", message:  sender.title(for: .normal)! + name + "\(sender.tag)", preferredStyle: UIAlertController.Style.alert)
//        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
//
//                }
//        alert.addAction(okAction)
//        present(alert, animated: false, completion: nil)
        Common.vibrate(1)

       
    }
    @objc func touchDeliveryBtn(sender: UIButton){
        let dic:Dictionary =  listArray[sender.tag]
        
        let fulfillmentsArr:Array = dic["fulfillments"] as! Array<Any>
        if fulfillmentsArr.count != 0 {
            let firstArr = fulfillmentsArr[0] as! [String:Any]
            let trackingDic = firstArr["tracking"] as! [String:Any]
            let uid = trackingDic["uid"] as! String
            print()
            UIApplication.shared.open(URL(string: "http://nplus.doortodoor.co.kr/web/detail.jsp?slipno=\(uid)")!)
            
        }else{
           
            let alert = UIAlertController(title: "deliveryBtn", message: "배송조회", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in

                    }
            alert.addAction(okAction)
            present(alert, animated: false, completion: nil)
        }
        


        Common.vibrate(1)
        

    }
    
    @objc func touchShoppingBtn(){
        
        let CartListSViewController = CartListSViewController()
        self.navigationController?.pushViewController(CartListSViewController, animated: true)
    }
    
    @objc func touchReviewBtn(sender: UIButton){
        let dic:Dictionary =  totalArr[sender.tag]
        
        
        let initDic = dic["product"] as! [String:Any]
//        let name = product["name"] as! String
//        let thumbnail = product["thumbnail"] as! [String:Any]
//        let thumbnailUrl = thumbnail["url"] as! String
      
//        let alert = UIAlertController(title: "reviewBtn", message: "리뷰작성"+name, preferredStyle: UIAlertController.Style.alert)
//        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
//
//                }
//        alert.addAction(okAction)
//        present(alert, animated: false, completion: nil)
      
//
//        initDic.updateValue(name, forKey: "name")
//        initDic.updateValue(thumbnailUrl, forKey: "url")

        let WriteReivewSViewController = WriteReivewSViewController(dic: initDic)

        self.navigationController?.pushViewController(WriteReivewSViewController, animated: true)
        Common.vibrate(1)
    }
    
    @objc func close(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
        Common.vibrate(1)
    }
  
}

