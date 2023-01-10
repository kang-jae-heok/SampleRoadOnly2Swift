//
//  CartListSViewController.swift
//  sampleroad
//
//  Created by NOTEGG on 2022/07/21.
//  Copyright © 2022 CNKANG. All rights reserved.
//

import UIKit

class CartListSViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
 
    
    let screenBounds = UIScreen.main.bounds
    let commonS = CommonS()
    let margin = 27.0
    let innerMargin = 0.0
    var isInit = false
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        return tableView
    }()
    let topView = UIView()
    let tit = UILabel()
    let backBtn = UIButton()
    let bottomView = UIView()
    let noticeLabel = UILabel()
    let buyBtn = UIButton()
    let allClickBtn = UIButton()
    let allClickLbl = UILabel()
    let selectDelete = UIButton()
    let finalTit = UILabel()
    let finalPriceLbl = UILabel()
    let finalPrice = UILabel()
    let finalDeliveryPriceLbl = UILabel()
    let finalDeliveryPrice = UILabel()
    let finalGrayView = UIView()
    let expectPriceLbl = UILabel()
    let expectPrice = UILabel()
    var cartArr = [String:Any]()
    var itemArr = [[String:Any]]()
    var itemCount  = Int()
    var checkArr = [String]()
    var checkArrSub = [String]()
    var bool = Bool()
    var checkRowArr = [Int]()
    var checkRowArrSub = [Int]()
    var checkCheckBtn = [Int]()
    var itemInfoDic = [String:Any]()
    var itemInfoArr = [[String:Any]]()
    var noDataView = UIView()
    var selectedId = [String]()
    
    var totalPrice  = Int()

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  screenBounds.width/8 + (screenBounds.width - (margin * 2))/3 + (screenBounds.width - (margin * 2))/5 + margin
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
        
        let lineView = UIView()
        let title = UILabel()
        let itemLine = UIView()
        let check = UIButton()
        let imageView = UIImageView()
        let itemTit = UILabel()
        let brandName = UILabel()
        let price = UILabel()
        let gPriceLabel = UILabel()
        let gPrice = UILabel()
        let deliveryPriceLbl = UILabel()
        let deliveryPrice = UILabel()
        let minusBtn = UIButton()
        let plusBtn = UIButton()
        let count = UILabel()
        let grayView = UIView()
        let xButton = UIButton()
        let checking = UIButton()
        
        guard let itemDic = itemArr[indexPath.row] as? [String:Any],
              let productDic = itemDic["product"] as? [String:Any],
              let variant = itemDic["variant"]  as? [String:Any],
              let variantPriceDic = variant["price"] as? [String:Any],
              let salePrice = variantPriceDic["sale"] as? [String:Any],
              let rawPrice = salePrice["raw"] as? Int,
              let brandDic = itemDic["brand"] as? [String:Any],
              let brandNameLbl = brandDic["name"] as? String,
              let quantityDic = itemDic["quantity"] as? [String:Any],
              let rawQuantity = quantityDic["raw"] as? Int,
              let totalPrice = itemDic["price"] as? [String:Any],
              let saleTPrice = totalPrice["sale"] as? [String:Any],
              let rawSaleTPrice = saleTPrice["raw"] as? Int,
              let id = itemDic["_id"] as? String,
              let cellItemInfo = itemInfoDic[id] as? [String:Any],
              let cellQuantity = cellItemInfo["quantity"] as? Int,
              let cellChecked = cellItemInfo["checked"] as? Bool,
              let cellPrice = cellItemInfo["price"] as? Int
        else {return cell!}
        if let thumbnail = productDic["thumbnail"] as? [String:Any] {
            let thumbnailURL = thumbnail["url"] as? String ?? ""
            let encoded = thumbnailURL.description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
          
            let common = CommonSwift()
            if encoded != nil {
                common.setImageUrl(url: encoded!, imageView: imageView)
            }
        }
      
   
        
        
       
     
        
        lineView.backgroundColor = Common.color(withHexString: "#e6e6e6")
        lineView.frame = CGRect(x: 0, y: 0, width: screenBounds.width - (margin * 2), height: 3)
        
        title.text = "마녀공장/메디힐자오담 공식몰"
        title.font = Common.kFont(withSize: "bold", 17)
        title.frame = CGRect(x: innerMargin, y: screenBounds.width/16 - title.font.pointSize/2, width: screenBounds.width - (margin * 2), height: title.font.pointSize + 5.0)
        
        itemLine.backgroundColor = Common.color(withHexString: "#e6e6e6")
        lineView.frame = CGRect(x: innerMargin, y: screenBounds.width/8, width: screenBounds.width - (margin * 2) , height: 1)
//        check.backgroundColor = Common.pointColor1()
        
        var checkImg = UIImage(named: "check_on_btn")
        check.layer.borderColor = Common.pointColor1().cgColor
        check.layer.borderWidth = 2
        check.frame = CGRect(x: innerMargin, y: screenBounds.width/8 + 22.0, width: (checkImg?.size.width)!, height: (checkImg?.size.height)!)
        check.tag = indexPath.row
        check.addTarget(self, action: #selector(touchCheckButton(sender:)), for: .touchUpInside)
        check.setImage(checkImg, for: .selected)
        check.setImage(UIImage(named: ""), for: .normal)
        print(cellChecked)
        
//        let itemDic = itemArr[indexPath.row]
        guard let itemId = itemDic["_id"] as? String,
              let idInfo = itemInfoDic[itemId] as? [String:Any],
              let checked = idInfo["checked"] as? Bool
        else {return cell!}
       
        print(idInfo)
        if (checked) {
            check.isSelected = true
        }else {
            print("checked   false")
            check.isSelected = false
        }
        
        
        
       
        
//        checking.setImage(UIImage(named: "x_btn"), for: .normal)
//        checking.frame = CGRect(x: 0, y: 0, width: screenBounds.width/16, height: screenBounds.width/16)
//        checking.isHidden = true
//
//        check.addSubview(checking)
        

        imageView.frame = CGRect(x: (innerMargin * 2) + check.frame.size.width, y: screenBounds.width/8, width: (screenBounds.width - (margin * 2))/6.0, height: (screenBounds.width - (margin * 2)) * 2.0/9.0)
        imageView.contentMode = .scaleAspectFit
        imageView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
   
      
        
        
        
        brandName.text = brandNameLbl
        brandName.font = Common.kFont(withSize: "bold", 10)
        brandName.textColor = .lightGray
        brandName.frame = CGRect(x: imageView.frame.origin.x + imageView.frame.size.width + 22.0, y: screenBounds.width/8 + 22.0, width: tableView.frame.width - brandName.frame.origin.x, height: brandName.font.pointSize)
        
        xButton.setImage(UIImage(named: "x_btn"), for: .normal)
        xButton.frame = CGRect(x: tableView.frame.width - 25 - 22, y: screenBounds.width/8 - 3, width: 50, height: 50)
        xButton.addTarget(self, action: #selector(touchXButton), for: .touchUpInside)
        xButton.tag = indexPath.row
   
        
        
        
        itemTit.text = productDic["name"] as! String
        itemTit.font = Common.kFont(withSize: "bold", 12)
        itemTit.textColor = .black
        itemTit.frame = CGRect(x: imageView.frame.origin.x + imageView.frame.size.width + 22.0, y: screenBounds.width/8 + 33 + brandName.font.pointSize, width: tableView.frame.width - brandName.frame.origin.x - 22, height: itemTit.font.pointSize)
        
        
        minusBtn.setImage(UIImage(named: "__btn"), for: .normal)
        minusBtn.frame = CGRect(x: innerMargin, y: imageView.frame.origin.y + imageView.frame.size.height + 5, width: screenBounds.width/16, height: screenBounds.width/16)
        minusBtn.addTarget(self, action: #selector(touchMinusBtn), for: .touchUpInside)
        minusBtn.tag = indexPath.row
        
        count.text = "\(rawQuantity)"
        count.font = Common.kFont(withSize: "bold", 20)
        count.frame = CGRect(x: (minusBtn.frame.size.width + 40 + screenBounds.width/16 - 22.0)/2 , y: minusBtn.frame.origin.y + minusBtn.frame.size.height/2 - count.font.pointSize * 2/5, width: screenBounds.width/16, height: count.font.pointSize)
        count.textAlignment = .center
        
        plusBtn.setImage(UIImage(named: "+_btn"), for: .normal)
        plusBtn.frame = CGRect(x: innerMargin + minusBtn.frame.size.width + 40, y: imageView.frame.origin.y + imageView.frame.size.height + 5, width: screenBounds.width/16, height: screenBounds.width/16)
        plusBtn.tag = indexPath.row
        plusBtn.addTarget(self, action: #selector(touchPlusBtn), for: .touchUpInside)
      
        
        price.text = "\(rawPrice)원"
        price.font = Common.kFont(withSize: "bold", 13)
        price.frame = CGRect(x: 0, y: plusBtn.frame.origin.y + plusBtn.frame.size.height/2, width: screenBounds.width - (margin * 2) - innerMargin, height: price.font.pointSize)
        price.textAlignment = .right
        price.text = "\(commonS.numberFormatter(number: rawPrice))원"
        grayView.backgroundColor = Common.color(withHexString: "#f5f5f5")
        grayView.frame = CGRect(x: innerMargin, y: screenBounds.width/8 + (screenBounds.width - (margin * 2))/3, width: screenBounds.width - (margin * 2) - (innerMargin * 2), height: (screenBounds.width - (margin * 2))/5.0)
        
        gPriceLabel.text = "제품금액"
        gPriceLabel.font = Common.kFont(withSize: "bold", 13)
        gPriceLabel.textColor = .lightGray
        gPriceLabel.frame = CGRect(x: grayView.frame.size.height/2 - 5 - gPriceLabel.font.pointSize, y: grayView.frame.size.height/2 - 5 - gPriceLabel.font.pointSize, width: grayView.frame.width - (grayView.frame.size.height/2 - 5 - gPriceLabel.font.pointSize)/2, height: gPriceLabel.font.pointSize)
        
    

   
      
        gPrice.text = "\(commonS.numberFormatter(number: rawSaleTPrice))원"
        gPrice.font = Common.kFont(withSize: "bold", 13)
        gPrice.frame = CGRect(x:0, y: grayView.frame.size.height/2 - 5 - gPrice.font.pointSize, width:  grayView.frame.width - gPriceLabel.frame.origin.x, height: gPrice.font.pointSize)
        gPrice.textAlignment = .right
        
        
        deliveryPriceLbl.text = "배송비"
        deliveryPriceLbl.font = Common.kFont(withSize: "bold", 13)
        deliveryPriceLbl.textColor = .lightGray
        deliveryPriceLbl.frame = CGRect(x: gPriceLabel.frame.origin.x, y: gPriceLabel.frame.origin.y + gPriceLabel.font.pointSize + 10, width: grayView.frame.width - (grayView.frame.size.height/2 - 5 - deliveryPriceLbl.font.pointSize)/2, height: deliveryPriceLbl.font.pointSize)
        if rawQuantity * rawPrice >= 50000{
            deliveryPrice.text = "무료"
        }else{
            deliveryPrice.text = "무료"
        }
        
        deliveryPrice.font = Common.kFont(withSize: "bold", 13)
        deliveryPrice.textColor = .lightGray
        deliveryPrice.frame = CGRect(x:0, y: gPrice.frame.origin.y + 10 + gPrice.font.pointSize, width:  grayView.frame.width - gPriceLabel.frame.origin.x, height: gPrice.font.pointSize)
        deliveryPrice.textAlignment = .right
        
     
        
        
        
        
        
        grayView.addSubview(gPriceLabel)
        grayView.addSubview(gPrice)
        grayView.addSubview(deliveryPriceLbl)
        grayView.addSubview(deliveryPrice)
        
        
       
        cell?.addSubview(xButton)
        cell?.addSubview(title)
        cell?.addSubview(lineView)
        cell?.addSubview(itemLine)
        cell?.addSubview(check)
        cell?.addSubview(imageView)
        cell?.addSubview(itemTit)
        cell?.addSubview(brandName)
        cell?.addSubview(price)
        cell?.addSubview(minusBtn)
        cell?.addSubview(plusBtn)
        cell?.addSubview(count)
        cell?.addSubview(grayView)
        
        return cell!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isInit {
            selectItem()
        }
       
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.showsVerticalScrollIndicator = false
        bool = true
        isInit = true
     
   
        view.addSubview(topView)
        view.addSubview(bottomView)
        view.backgroundColor = .white
        topView.addSubview(tit)
        topView.addSubview(backBtn)
        
        bottomView.addSubview(buyBtn)
        bottomView.addSubview(tableView)
        tableView.addSubview(noticeLabel)
        tableView.addSubview(allClickBtn)
        tableView.addSubview(allClickLbl)
        tableView.addSubview(selectDelete)
        tableView.addSubview(finalTit)
        tableView.addSubview(finalPriceLbl)
        tableView.addSubview(finalPrice)
        tableView.addSubview(finalDeliveryPriceLbl)
        tableView.addSubview(finalDeliveryPrice)
        tableView.addSubview(finalGrayView)
        finalGrayView.addSubview(expectPrice)
        finalGrayView.addSubview(expectPriceLbl)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        
        topView.frame = CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.width/4)
        tit.text = "장바구니"
        tit.textColor = Common.color(withHexString: "#97C5E9")
        tit.font = Common.kFont(withSize: "bold", 20)
        tit.textAlignment = .center
        tit.frame = CGRect(x: 0, y: screenBounds.width/4 - tit.font.pointSize, width: screenBounds.width, height: tit.font.pointSize)
        let backImg = UIImage(named: "back_btn")
        backBtn.setImage(backImg, for: .normal)
        backBtn.frame = CGRect(x: margin, y: screenBounds.width/4 - 50 + (backImg?.size.height)!/2, width:50, height: 50)
        backBtn.addTarget(self, action: #selector(touchBackBtn), for: .touchUpInside)
        backBtn.contentHorizontalAlignment = .left
        bottomView.frame = CGRect(x: 0, y: screenBounds.width/4, width: screenBounds.width, height: screenBounds.height - screenBounds.width/4)
    
        buyBtn.backgroundColor = Common.pointColor1()
        buyBtn.titleLabel?.font = Common.kFont(withSize: "bold", 18)
        buyBtn.titleLabel?.textColor = .white
        buyBtn.frame = CGRect(x: 0, y: bottomView.frame.size.height - 40 - screenBounds.width/5, width: screenBounds.width, height: screenBounds.width/5)
        buyBtn.addTarget(self, action: #selector(touchBuyBtn), for: .touchUpInside)
        
        tableView.frame = CGRect(x: margin, y: 0, width: screenBounds.width - (margin * 2), height: bottomView.frame.height - 40 - screenBounds.width/5)
        tableView.contentInset = UIEdgeInsets(top: screenBounds.width/8 + screenBounds.width/10 + 40, left: 0, bottom:  screenBounds.width/8 + (screenBounds.width - (margin * 2))/3 + (screenBounds.width - (margin * 2))/5 + margin, right: 0)
        
        
        noticeLabel.text = "장바구니에 담긴 제품은 최대 30일간 저장됩니다."
        noticeLabel.backgroundColor = Common.color(withHexString: "#f5f5f5")
        noticeLabel.font = Common.kFont(withSize: "bold", 13)
        noticeLabel.frame = CGRect(x: 0, y: -(screenBounds.width/8 + screenBounds.width/10), width: screenBounds.width - (margin * 2), height: screenBounds.width/10)
        noticeLabel.textAlignment = .center

        let checkImg = UIImage(named: "check_on_btn")
        allClickBtn.frame = CGRect(x: innerMargin, y: -(screenBounds.width/16 + 25 - screenBounds.width/32) , width:(checkImg?.size.width)!, height: (checkImg?.size.width)!)
        allClickBtn.layer.borderWidth = 2
        allClickBtn.layer.borderColor = Common.pointColor1().cgColor
        allClickBtn.setImage(UIImage(named: "check_on_btn"), for: .selected)
        allClickBtn.setImage(UIImage(named: ""), for: .normal)
        allClickBtn.isSelected = true
        allClickBtn.addTarget(self, action: #selector(touchAllCheckBtn), for: .touchUpInside)
      
        allClickLbl.text = "제품 전체 선택"
        allClickLbl.font = Common.kFont(withSize: "bold", 13)
        allClickLbl.frame = CGRect(x: 12 + screenBounds.width/16, y: -(screenBounds.width/16 + allClickLbl.font.pointSize/2), width: 200, height: allClickLbl.font.pointSize)
        
        selectDelete.setTitle("선택 삭제", for: .normal)
        selectDelete.layer.borderWidth = 1
        selectDelete.layer.borderColor = Common.color(withHexString: "#e6e6e6").cgColor
        selectDelete.titleLabel?.font = Common.kFont(withSize: "bold", 11)
        selectDelete.setTitleColor(.lightGray, for: .normal)
        selectDelete.frame = CGRect(x: screenBounds.width - (margin * 2) - innerMargin - (margin * 2.5), y: -(screenBounds.width/16.0 + 13.5), width: margin * 2.5, height: margin)
        selectDelete.addTarget(self, action: #selector(touchSelectDelete), for: .touchUpInside)
        
        
        selectItem()
    }
    
    func drawBottom(){
        
      let a =  screenBounds.width/8 + (screenBounds.width - (margin * 2))/3 + (screenBounds.width - (margin * 2))/5 + margin
 
        print(itemCount)
        let cellH = a * CGFloat(itemCount)
        finalTit.text = "결제 금액 확인"
        finalTit.font = Common.kFont(withSize: "bold", 17)
        finalTit.frame = CGRect(x: innerMargin, y: cellH + screenBounds.width/16 - finalTit.font.pointSize/2.0, width: screenBounds.width - (margin * 2), height: finalTit.font.pointSize + 5.0)
        
        finalPriceLbl.text = "총 제품금액"
        finalPriceLbl.font = Common.kFont(withSize: "bold", 13)
        finalPriceLbl.textColor = .lightGray
        finalPriceLbl.frame = CGRect(x: innerMargin, y: finalTit.frame.origin.y + finalTit.font.pointSize + margin , width: screenBounds.width - (margin * 2) - innerMargin, height: finalPrice.font.pointSize)
        
        finalDeliveryPriceLbl.text = "배송비"
        finalDeliveryPriceLbl.font = Common.kFont(withSize: "bold", 13)
        finalDeliveryPriceLbl.textColor = .lightGray
        finalDeliveryPriceLbl.frame = CGRect(x: innerMargin, y: finalPriceLbl.frame.origin.y + finalPriceLbl.font.pointSize + 10.0 , width: screenBounds.width - (margin * 2) - innerMargin, height: finalPrice.font.pointSize)
   
        // 포인트
        
        var lastPrice2 = Int()
        var checkedItem = [String]()
        
        if itemArr.count != 0 {
            for i in 0...itemArr.count - 1{
                let itemDic = itemArr[i]
                let itemId = itemDic["_id"] as! String
                if itemInfoDic[itemId] == nil {
                    finalPrice.text = "0원"
                    expectPrice.text = "0원"
                    finalDeliveryPrice.text = "무료"
                }else{
                    let idInfo = itemInfoDic[itemId] as! [String:Any]
                    if idInfo["checked"] as! Bool == true{
                        checkedItem.append(itemId)
                    }
                }
            }
            if checkedItem.count != 0{
                for x in 0...checkedItem.count - 1{
                  let checkedDic = itemInfoDic[checkedItem[x]] as! [String:Any]
                    lastPrice2 += checkedDic["price"] as! Int
                }
                if lastPrice2 >= 50000{
                    finalDeliveryPrice.text = "무료"
                    finalPrice.text = "\(commonS.numberFormatter(number: lastPrice2))원"
                    expectPrice.text = "\(common2.numberFormatter(number: lastPrice2))원"
                }else if lastPrice2 == 0{
                    finalPrice.text = "0원"
                    expectPrice.text = "0원"
                    finalDeliveryPrice.text = "무료"
                }else{
                    finalDeliveryPrice.text = "3,500원"
                    finalPrice.text = "\(commonS.numberFormatter(number: lastPrice2 ))원"
                    expectPrice.text = "\(commonS.numberFormatter(number: lastPrice2 + 3500))원"
                }
            }else{
                lastPrice2 = 0
                finalPrice.text = "0원"
                expectPrice.text = "0원"
                finalDeliveryPrice.text = "무료"
            }
        }else{
            lastPrice2 = 0
            finalPrice.text = "0원"
            expectPrice.text = "0원"
            finalDeliveryPrice.text = "3,500원"
        }
        totalPrice =  lastPrice2
     
     
        

        finalPrice.font = Common.kFont(withSize: "bold", 13)
        finalPrice.frame = CGRect(x:0, y: finalTit.frame.origin.y + finalTit.font.pointSize + margin , width:  screenBounds.width - (margin * 2) - (innerMargin * 2), height: finalPrice.font.pointSize)
        finalPrice.textAlignment = .right
        
       
     
        finalDeliveryPrice.font = Common.kFont(withSize: "bold", 13)
        finalDeliveryPrice.frame = CGRect(x:0, y: finalTit.frame.origin.y + finalTit.font.pointSize + margin + 10 + finalPrice.font.pointSize, width:  screenBounds.width - (margin * 2) - (innerMargin * 2), height: finalDeliveryPrice.font.pointSize)
        finalDeliveryPrice.textAlignment = .right
  
        
        finalGrayView.backgroundColor = Common.color(withHexString: "#f5f5f5")
        finalGrayView.frame = CGRect(x: 0, y: finalDeliveryPriceLbl.frame.origin.y + finalDeliveryPriceLbl.font.pointSize + margin, width: screenBounds.width - (margin * 2), height: (screenBounds.width - (margin * 2))/6.0 )
        
        expectPriceLbl.text = "총 결제 금액"
        expectPriceLbl.font = Common.kFont(withSize: "bold", 15)
        expectPriceLbl.frame = CGRect(x: margin, y: finalGrayView.frame.height/2 - expectPriceLbl.font.pointSize/2 , width: finalGrayView.frame.width - margin, height: expectPriceLbl.font.pointSize)
        
        
  
        

        expectPrice.font = Common.kFont(withSize: "bold", 15)
        expectPrice.frame = CGRect(x: 0, y: finalGrayView.frame.height/2 - expectPrice.font.pointSize/2 , width: finalGrayView.frame.width - margin, height: expectPrice.font.pointSize)
        expectPrice.textAlignment = .right
    }
    
    
    @objc func selectItem() {
     
            
        // 데이터 불러오기
        let customerId =  UserDefaults.standard.value(forKey: "customer_id") as! String
        print("커스터머 아이디 \(customerId)")
        
        
        COMController.sendRequest("https://api.clayful.io/v1/customers/\(customerId)/cart", nil, self, #selector(selectItemCallback(result:)))
        
    }
    
    
    
    
    @objc func selectItemCallback(result :NSData) {
        let common = CommonSwift()
        print("####result")
        print(result)
        print("##끝")
        let dic:[String:Any] = common.JsonToDictionary(data: result)!
        let cartDic = dic["cart"] as! [String:Any]
        var arr = cartDic["items"] as! [[String:Any]]
        if arr.count != 0 {
            for i in 0...arr.count - 1 {
                if arr[i]["product"] == nil || arr[i]["product"] as! NSObject == NSNull() {
                    guard let itemId = arr[i]["_id"] as? String else {return}
                    selectDelete(itemId: itemId)
                    arr.remove(at: i)
                }
            }
        }
        
        
        print(arr)
        itemArr = arr
        itemCount = arr.count

        print(cartDic)
        if arr.count != 0 { 
            for i in 0...arr.count - 1{
                let itemDic = arr[i]
                let totalPrice = itemDic["price"] as! [String:Any]
                let saleTPrice = totalPrice["sale"] as! [String:Any]
                let rawSaleTPrice = saleTPrice["raw"] as! Int
                let itemID = itemDic["_id"] as! String
                let itemQuantity = itemDic["quantity"] as! [String:Any]
                let rawItemQuantity = itemQuantity["raw"] as! Int
                
                
                if ((itemInfoDic[itemID]) != nil) {
                    let itemDic = arr[i]
                    let itemId = itemDic["_id"] as! String
                    var idInfo = itemInfoDic[itemId] as! [String:Any]
                    idInfo.updateValue(rawSaleTPrice, forKey:"price")
                    idInfo.updateValue(rawItemQuantity, forKey:"quantity")
                    itemInfoDic.updateValue(idInfo, forKey: itemID)
                }else {
                    var idInfoDic = [String:Any]()
                    idInfoDic.updateValue(rawSaleTPrice, forKey: "price")
                    idInfoDic.updateValue(true, forKey: "checked")
                    idInfoDic.updateValue(rawItemQuantity, forKey: "quantity")
                    itemInfoDic.updateValue(idInfoDic, forKey: itemID)
                }

                checkArr.append(itemDic["_id"] as! String)
                checkRowArr.append(rawSaleTPrice)
                checkArrSub.append(itemDic["_id"] as! String)
                checkRowArrSub.append(rawSaleTPrice)
            }
            
            itemInfoArr.append(itemInfoDic)
            print(itemInfoArr)
            
            print("딕셔너리")
            print(itemInfoDic)
        }else{
            noDataView.removeFromSuperview()
           
            noDataView = Common.nodataView(CGRect(x: 0, y: tit.frame.origin.y + tit.font.pointSize, width: screenBounds.width, height: screenBounds.height - (tit.frame.origin.y + tit.font.pointSize)), "장바구니가 비어있습니다.")
            self.view.addSubview(noDataView)
       
        }
      
     
        print(checkArr)
        drawBuyBtn()
        drawBottom()
        tableView.reloadData()
        tableView.dataSource = self
        tableView.delegate = self
        
    
    }
    @objc func selectQuantity(quantity: Int, itemId: String) {
        let customerId =  UserDefaults.standard.value(forKey: "customer_id") as! String

        let itemId = itemId
        var params = [String:Any]()

        params.updateValue("\(quantity)", forKey: "quantity")
        print(quantity)
        print(itemId)
        
        
        
        COMController.sendRequest(withMethod: "PUT", "https://api.clayful.io/v1/customers/\(customerId)/cart/items/\(itemId)", params, self, #selector(selectQuantityCallback(result:)))
       
        
    }
    
    
    
    @objc func selectQuantityCallback(result :NSData) {

        let common = CommonSwift()

        NSLog("selectOrderCallback : %@", result);
        print(common.JsonToDictionary(data: result)!)
   
        selectItem()
    
     
    }
    @objc func selectDelete(itemId: String) {
        let customerId =  UserDefaults.standard.value(forKey: "customer_id") as! String

        let itemId = itemId

        print(itemId)
        
        
        
        COMController.sendRequest(withMethod: "DELETE", "https://api.clayful.io/v1/customers/\(customerId)/cart/items/\(itemId)", nil, self, #selector(selectDelteCallback(result:)))
       
        
    }
    
    
    
    @objc func selectDelteCallback(result :NSData) {

        let common = CommonSwift()

        NSLog("selectOrderCallback : %@", result);
     
   
        selectItem()
    
     
    }
    
    @objc func touchXButton(sender: UIButton){
        let tag = sender.tag
        let itemDic = itemArr[tag]
        let productDic = itemDic["product"] as! [String:Any]
        let itemId = itemDic["_id"] as! String
       
        selectDelete(itemId: itemId)
        print("touchXButton")
        Common.vibrate(1)
        
    }
    
    
    @objc func touchPlusBtn(sender: UIButton){
        let tag = sender.tag
        let itemDic = itemArr[tag]
        let quantityDic = itemDic["quantity"] as! [String:Any]
        let rawQuantity = quantityDic["raw"] as! Int
        let productDic = itemDic["product"] as! [String:Any]
        let itemId = itemDic["_id"] as! String
        let plusQuantity = rawQuantity + 1
        selectQuantity(quantity: plusQuantity, itemId: itemId)
        print(tag)
        Common.vibrate(1)
        
    }
    
    @objc func touchMinusBtn(sender: UIButton){
        let tag = sender.tag
        let itemDic = itemArr[tag]
        let quantityDic = itemDic["quantity"] as! [String:Any]
        let rawQuantity = quantityDic["raw"] as! Int
        let productDic = itemDic["product"] as! [String:Any]
        let itemId = itemDic["_id"] as! String
        let minusQuantity = rawQuantity - 1
        
        selectQuantity(quantity: minusQuantity, itemId: itemId)
      
        print(tag)
        Common.vibrate(1)
    
    }
    @objc func touchCheckButton(sender: UIButton){
        let tag = sender.tag
        let itemDic = itemArr[tag]
        let quantityDic = itemDic["quantity"] as! [String:Any]
        let rawQuantity = quantityDic["raw"] as! Int
        let productDic = itemDic["product"] as! [String:Any]
        let itemId = itemDic["_id"] as! String
        let totalPrice = itemDic["price"] as! [String:Any]
        let saleTPrice = totalPrice["sale"] as! [String:Any]
        let rawSaleTPrice = saleTPrice["raw"] as! Int
        if sender.isSelected == true{
            sender.isSelected = false
            allClickBtn.isSelected = false
            var idInfo = itemInfoDic[itemId] as! [String:Any]
            idInfo.updateValue(false, forKey:"checked")
            selectedId = selectedId.filter { $0 != itemId }
            itemInfoDic.updateValue(idInfo, forKey: itemId)
            drawBottom()
            drawBuyBtn()
   
        }else{
            sender.isSelected = true
            var idInfo = itemInfoDic[itemId] as! [String:Any]
            idInfo.updateValue(true, forKey:"checked")
            selectedId.append(itemId)
            selectedId = selectedId.uniqued()
            itemInfoDic.updateValue(idInfo, forKey: itemId)
            
            var allTrueArr = [Bool]()
            for i in 0...itemArr.count - 1{
                let itemDic = itemArr[i]
                let itemId = itemDic["_id"] as! String
                let idInfo = itemInfoDic[itemId] as! [String:Any]
                allTrueArr.append(idInfo["checked"] as! Bool)
            }
            if allTrueArr.contains(false){
                print("ㅇㅇㅇ")
                print(allTrueArr)
            }else{
                allClickBtn.isSelected = true
            }
            
            
            drawBottom()
            drawBuyBtn()
        }
        Common.vibrate(1)
    }
    
    @objc func touchSelectDelete(){
      if itemArr.count != 0{
            for i in 0...itemArr.count - 1{
                let itemDic = itemArr[i]
                let itemId = itemDic["_id"] as! String
                let idInfo = itemInfoDic[itemId] as! [String:Any]
               if idInfo["checked"] as! Bool == true{
                   selectDelete(itemId: itemId)
                   itemInfoDic[itemId] = nil
                }
            }
        }
           
       
            drawBottom()
            drawBuyBtn()
        Common.vibrate(1)
        }
        
        
       
        
    
    @objc func touchAllCheckBtn(sender: UIButton){
        if sender.isSelected == true{
            sender.isSelected = false
            if itemArr.count != 0{
                for i in 0...itemArr.count - 1{
                    let itemDic = itemArr[i]
                    let itemId = itemDic["_id"] as! String
                    var idInfo = itemInfoDic[itemId] as! [String:Any]
                    idInfo.updateValue(false, forKey:"checked")
                    selectedId = selectedId.filter { $0 != itemId }
                    itemInfoDic.updateValue(idInfo, forKey: itemId)
                }
            }
         
        }else{
            sender.isSelected = true
            if itemArr.count != 0{
                for i in 0...itemArr.count - 1{
                    let itemDic = itemArr[i]
                    let itemId = itemDic["_id"] as! String
                    var idInfo = itemInfoDic[itemId] as! [String:Any]
                    idInfo.updateValue(true, forKey:"checked")
                    selectedId.append(itemId)
                    selectedId = selectedId.uniqued()
                    itemInfoDic.updateValue(idInfo, forKey: itemId)
                    
                }
            }
            
            print(itemInfoDic)
        }
        
        
           tableView.reloadData()
           drawBottom()
           drawBuyBtn()
        Common.vibrate(1)
        
    }
    
    func drawBuyBtn(){
        var lastPrice2 = Int()
        var checkedItem = [String]()
        
        if itemArr.count != 0{
            for i in 0...itemArr.count - 1{
                let itemDic = itemArr[i]
                let itemId = itemDic["_id"] as! String
                if itemInfoDic[itemId] == nil {
                    finalPrice.text = "0원"
                    expectPrice.text = "0원"
                    finalDeliveryPrice.text = "무료"
                }else{
                    let idInfo = itemInfoDic[itemId] as! [String:Any]
                    if idInfo["checked"] as! Bool == true{
                        checkedItem.append(itemId)
                    }
                }
            }
            if checkedItem.count != 0{
                for x in 0...checkedItem.count - 1{
                  let checkedDic = itemInfoDic[checkedItem[x]] as! [String:Any]
                    lastPrice2 += checkedDic["price"] as! Int
                }
                if lastPrice2 >= 50000{
                    buyBtn.setTitle("총 \(commonS.numberFormatter(number: lastPrice2))원 주문하기", for: .normal)
                    buyBtn.backgroundColor = Common.pointColor1()
                }else if lastPrice2 == 0{
                    buyBtn.setTitle("총 0원 주문하기", for: .normal)
                    buyBtn.backgroundColor = Common.color(withHexString: "#e6e6e6")
                }else{
                    buyBtn.setTitle("총 \(commonS.numberFormatter(number: lastPrice2 + 3500))원 주문하기", for: .normal)
                    buyBtn.backgroundColor = Common.pointColor1()
                }
            }else{
                buyBtn.setTitle("총 0원 주문하기", for: .normal)
                buyBtn.backgroundColor = Common.color(withHexString: "#e6e6e6")
            }
        }else{
            buyBtn.setTitle("총 0원 주문하기", for: .normal)
            buyBtn.backgroundColor = Common.color(withHexString: "#e6e6e6")
        }

        
    }
    
    @objc func touchBackBtn(){
        self.navigationController?.popViewController(animated: true)
        Common.vibrate(1)
    }
    @objc func touchBuyBtn(sender: UIButton){
        if sender.backgroundColor == Common.pointColor1(){
            var param:[String:Any] = [:]
            let itemsId = checkArrSub.uniqued() 
            var selected = [[String:Any]]()
            for i in 0...itemArr.count - 1 {
                guard let id = itemArr[i]["_id"] as? String,
                      let info =  itemInfoDic[id] as? [String:Any],
                      let checked = info["checked"] as? Bool
                else {return}
                if checked {
                    selected.append(itemArr[i])
                }
            }
            
            
            print("#####buy")
//            print(itemArr)
            print(itemInfoDic)
        
            param.updateValue(selected, forKey:"cart_list")
            param.updateValue(String(totalPrice), forKey: "total_price")
            
            let convertDic = NSMutableDictionary(dictionary: param)
            self.navigationController?.pushViewController(OrderSViewController(orderListDic: param), animated: true)
        }
        Common.vibrate(1)
    }
    func findKeyForValue(value: String, dictionary: [String: [String]]) ->String?
    {
        for (key, array) in dictionary
        {
            if (array.contains(value))
            {
                return key
            }
        }

        return nil
    }

}
extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
