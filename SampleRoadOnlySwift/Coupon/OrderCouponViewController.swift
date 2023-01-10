//
//  OrderCouponViewController.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/12/28.
//

import UIKit

class OrderCouponViewController: UIViewController {
    let orderCouponView = OrderCouponView()
    var myCouponInfoDicArr = [[String:Any]]()
    var orderList = [[String:Any]]()
    var availableCouponId = [String]()
    var selectedIndex = IndexPath()
    var selectedCouponId = String()
    var discountPrice = Int()
    var mostExpOrder = [String:Any]()
    override func loadView() {
        super.loadView()
        view = orderCouponView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getExpensiveItem()
        setTarget()
    }
    func setTarget() {
        orderCouponView.topView.backBtn.addTarget(self, action: #selector(touchBackBtn), for: .touchUpInside)
        orderCouponView.applyBtn.addTarget(self, action: #selector(touchApplyBtn(sender:)), for: .touchUpInside)
    }
    func getCoupon(){
        common2.sendRequest(url: "https://api.clayful.io/v1/customers/\(UserDefaults.standard.string(forKey: "customer_id") ?? "")/coupons", method: "get", params: [:], sender: "") { [self] resultJson in
            guard let myCouponDicArr: [[String:Any]] = resultJson as? [[String:Any]] else { return }
            
            print(myCouponDicArr.count)
            if myCouponDicArr.count != 0 {
                for i in 0...myCouponDicArr.count - 1 {
                    print("여기다여기")
                    guard let id = myCouponDicArr[i]["_id"] as? String else {return}
                    if self.availableCouponId.contains(id) {
                        self.myCouponInfoDicArr.append(myCouponDicArr[i])
                    }
                }
            }
            if self.myCouponInfoDicArr.count == 0 {
                orderCouponView.noneView.isHidden = false
            }
            
            self.orderCouponView.couponCollectionView.delegate = self
            self.orderCouponView.couponCollectionView.dataSource = self
            self.orderCouponView.couponCollectionView.reloadData()
            self.setView()
        }
    }
    func setView(){
        if myCouponInfoDicArr.count == 0 {
            orderCouponView.noneView.isHidden = false
        }else {
            orderCouponView.noneView.isHidden = true
        }
    }
    func setApplyBtn(price: Int) {
        orderCouponView.applyBtn.setTitle("\(common2.numberFormatter(number: price))원 적용하기", for: .normal)
    }
    func getExpensiveItem() {
        var mostExpPrice = 0
        var orderTotalPrice = Int()
        for i in 0...orderList.count - 1 {
            guard let price = orderList[i]["price"] as? Int,
                  let quantity = orderList[i]["quantity"] as? Int
            else {return}
            
            if quantity == 1 {
                if mostExpPrice < price {
                    mostExpPrice = price
                    mostExpOrder = orderList[i]
                }
            }
            orderTotalPrice += price * quantity
        }
        if mostExpPrice >= 10000 {
            availableCouponId.append("RBB6ZETT5EU8")
        }
        if orderTotalPrice < 50000 {
            availableCouponId.append("DH8PZKCGBXCH")
        }
        
        getCoupon()
    }
    
    @objc func touchBackBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func touchApplyBtn(sender: UIButton){
        if sender.backgroundColor == common2.pointColor() {
            var couponDic = [String:Any]()
            couponDic.updateValue(discountPrice, forKey: "price")
            couponDic.updateValue(selectedCouponId, forKey: "_id")
            UserDefaults.standard.set(couponDic, forKey: "coupon")
            self.navigationController?.popViewController(animated: true)
        }
    }
  
  
}
extension OrderCouponViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return myCouponInfoDicArr.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenBounds2.width - margin2 * 2, height: 180)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OrderCouponCollectionCell
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 7
        cell.layer.borderColor = common2.lightGray().cgColor
        cell.clipsToBounds = true
        cell.innerCircleView.isHidden = true
        if self.selectedIndex == indexPath {
            cell.innerCircleView.isHidden = false
        }
        let couponDic = myCouponInfoDicArr[indexPath.row]
        guard let couponId = couponDic["_id"] as? String else {return cell}
        guard let name = couponDic["name"] as? String else {return cell}
        guard let discountDic = couponDic["discount"] as? [String:Any] else {return cell}
        guard let type = discountDic["type"] as? String else {return cell}
        guard let valueDic = discountDic["value"] as? [String:Any] else {return cell}
        guard let rawValue = valueDic["raw"] as? Int else {return cell}
        guard let description = couponDic["description"] as? String else {return cell}
        let convertRawValue = common2.numberFormatter(number: rawValue)
       
        cell.secondLbl.text = "[\(name)]"
        if type == "percentage" {
            cell.firstLbl.text = convertRawValue + "% 할인"
            cell.firstLbl.asColor(targetStringList: [convertRawValue,"%"], color: common2.pointColor())
        }else {
            cell.firstLbl.text = convertRawValue + "원 할인"
            cell.firstLbl.asColor(targetStringList: [convertRawValue,"원"], color: common2.pointColor())
        }
        cell.getBtnTapped = {
            if cell.innerCircleView.isHidden {
                cell.innerCircleView.isHidden = false
                self.selectedIndex = indexPath
                self.orderCouponView.applyBtn.backgroundColor = self.common2.pointColor()
                //배송비
                if couponId == "DH8PZKCGBXCH"{
                    self.discountPrice = 3500
                    self.setApplyBtn(price: 3500)
                    self.selectedCouponId = "DH8PZKCGBXCH"
                }else if couponId == "RBB6ZETT5EU8" {
                    guard let price = self.mostExpOrder["price"] as? Int else {return}
                    print("")
                    if price/10 > 2000 {
                        self.discountPrice = 2000
                    }else {
                        self.discountPrice = price/10
                    }
                    self.selectedCouponId = "RBB6ZETT5EU8"
                    self.setApplyBtn(price: self.discountPrice)
                }
                self.orderCouponView.couponCollectionView.reloadData()
            }else {
                cell.innerCircleView.isHidden = true
                self.selectedIndex = IndexPath()
                self.orderCouponView.applyBtn.backgroundColor = self.common2.lightGray()
                self.setApplyBtn(price: 0)
                self.orderCouponView.couponCollectionView.reloadData()
                UserDefaults.standard.removeObject(forKey: "coupon")
            }
        }
        cell.infoBtnTapped = {
            if description == "" {
                self.present(self.common2.alert(title: "", message: "상세정보가 없습니다"), animated: true)
            }else {
                var convertStr = description.components(separatedBy: "</p>").joined()
                convertStr = convertStr.components(separatedBy: "<p>").joined()
                self.present(self.common2.alert(title: "", message: convertStr), animated: true)
            }
        }
        if UserDefaults.contains("coupon") {
            if couponId == "DH8PZKCGBXCH" {
                cell.innerCircleView.isHidden = false
                self.selectedIndex = indexPath
                self.orderCouponView.applyBtn.backgroundColor = self.common2.pointColor()
                //배송비
                self.setApplyBtn(price: 3500)
            }
        }
        guard let expiresAtDic = couponDic["expiresAt"] as? [String:Any] else {return cell}
        if let rawDate = expiresAtDic["raw"] as? String{
            let convertDate = rawDate.dropLast(8)
            let convertDate2 = convertDate.replacingOccurrences(of: "T", with: " ")
            let convertDate3 = convertDate2.replacingOccurrences(of: "-", with: ".")
            cell.thirdLbl.text = "~ \(convertDate3)까지 사용 가능"
        } else {
            cell.thirdLbl.text = ""
        }
       
        return cell
    }
    
    
}
