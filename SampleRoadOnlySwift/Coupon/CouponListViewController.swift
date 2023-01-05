//
//  CouponListViewController.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/11/10.
//

import UIKit

class CouponListViewController: UIViewController {
    let couponListView = CouponListView()
    var myCouponInfoDicArr = [[String:Any]]()
    var getCouponInfoDicArr = [[String:Any]]()
    var checkCouponArr = [String]()
    
    override func loadView() {
        super.loadView()
        view = couponListView
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
        self.couponListView.couponCollectionView.delegate = self
        self.couponListView.couponCollectionView.dataSource = self
        getCouponInfo {
        }
        
       
    }
    func setTarget(){
        couponListView.topView.backBtn.addTarget(self, action: #selector(touchBackBtn), for: .touchUpInside)
        couponListView.myCouponBtn.addTarget(self, action: #selector(touchMyCouponBtn), for: .touchUpInside)
        couponListView.getCouponBtn.addTarget(self, action: #selector(touchGetCouponBtn), for: .touchUpInside)
        couponListView.noneGetCouponBtn.addTarget(self, action: #selector(touchGetCouponBtn), for: .touchUpInside)
    }
    func setView(){
        couponListView.countLbl.text = "총 \(myCouponInfoDicArr.count)개"
        couponListView.countLbl.asColor(targetStringList: ["총","개"], color: common2.setColor(hex: "#b1b1b1"))
        if myCouponInfoDicArr.count == 0 {
            couponListView.noneMyView.isHidden = false
        }else {
            couponListView.noneMyView.isHidden = true
        }
    }
    func getCouponInfo(completion: @escaping() -> Void){
        let params = ["customer_id":UserDefaults.standard.string(forKey: "customer_id") ?? ""]
        common2.sendRequest(url: "http://110.165.17.124/sampleroad/v1/coupon.php", method: "post", params: params, sender: "") { [self] resultJson in
            guard let couponsDic = resultJson as? [String:Any],
                  let ids = couponsDic["ids"] as? String
            else {return}
            let idsArr = ids.components(separatedBy: ",")
            checkCouponArr = idsArr
            print("####checkCouponArr")
            print(checkCouponArr)
            self.couponListView.couponCollectionView.reloadData()
        }
        let todayDate = common2.getCurrentDateTime()
        common2.sendRequest(url: "https://api.clayful.io/v1/coupons?expiresAtMin=\(todayDate)", method: "get", params: [:], sender: "") { [self] resultJson in
            guard let getCouponDicArr: [[String:Any]] = resultJson as? [[String:Any]] else { return }
            self.getCouponInfoDicArr = getCouponDicArr
            self.couponListView.couponCollectionView.reloadData()
        }
        common2.sendRequest(url: "https://api.clayful.io/v1/customers/\(UserDefaults.standard.string(forKey: "customer_id") ?? "")/coupons", method: "get", params: [:], sender: "") { [self] resultJson in
            guard let myCouponDicArr: [[String:Any]] = resultJson as? [[String:Any]] else { return }
            print("여기다여기")
            print(resultJson)
            print(myCouponDicArr.count)
            self.myCouponInfoDicArr = myCouponDicArr
            self.couponListView.couponCollectionView.delegate = self
            self.couponListView.couponCollectionView.dataSource = self
            self.couponListView.couponCollectionView.reloadData()
            self.setView()
        }
    }
    func getCoupon(couponId: String){
        common2.sendRequest(url: "https://api.clayful.io/v1/customers/\(UserDefaults.standard.string(forKey: "customer_id") ?? "")/coupons", method: "post", params: ["coupon":couponId], sender: "") { resultJson in
            guard let resultDic = resultJson as? [String:Any] else {return}
            if resultDic["error"] == nil {
                guard let couponId = resultDic["coupon"] as? String else {return}
                self.common2.sendRequest(url: "http://110.165.17.124/sampleroad/v1/coupon.php", method: "post", params: ["customer_id":UserDefaults.standard.string(forKey: "customer_id") ?? "","coupon_id":couponId,"insert":1], sender: "") { resultJson2 in
                    print(resultJson2)
                    guard let resultDic2 = resultJson2 as? [String:Any] else {return}
                    guard let errorCode = resultDic2["error"] as? String else {return}
                    if errorCode == "1" {
                        self.addMyCoupon(couponId: couponId)
                        self.present(self.common2.alert(title: "", message: "쿠폰이 정상적으로 발급되었습니다!"), animated: true)
                    }else {
                        self.present(self.common2.alert(title: "에러", message: "잠시 후에 다시 시도해주세요"), animated: true)
                    }
                }
            }
        }
    }
    func addMyCoupon(couponId: String){
        self.common2.sendRequest(url: "https://api.clayful.io/v1/coupons/\(couponId)", method: "get", params: [:], sender: "") { resultJson in
            print(resultJson)
            guard let reusltDic = resultJson as? [String:Any] else {return}
            self.myCouponInfoDicArr.append(reusltDic)
        }
    }
    @objc func touchBackBtn(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func touchMyCouponBtn() {
        if couponListView.myCouponBtn.backgroundColor != common2.pointColor() {
            setView()
            couponListView.myCouponBtn.setTitleColor(.white, for: .normal)
            couponListView.myCouponBtn.backgroundColor = common2.pointColor()
            couponListView.getCouponBtn.setTitleColor(common2.pointColor(), for: .normal)
            couponListView.getCouponBtn.backgroundColor = UIColor.white
            couponListView.couponCollectionView.delegate = self
            couponListView.couponCollectionView.dataSource = self
            couponListView.couponCollectionView.reloadData()
            couponListView.countLbl.text = "총 \(self.myCouponInfoDicArr.count)개"
            couponListView.countLbl.asColor(targetStringList: ["총","개"], color: common2.setColor(hex: "#b1b1b1"))
        }
    }
    @objc func touchGetCouponBtn() {
        if  couponListView.getCouponBtn.backgroundColor != common2.pointColor() {
            couponListView.getCouponBtn.setTitleColor(.white, for: .normal)
            couponListView.getCouponBtn.backgroundColor = common2.pointColor()
            couponListView.myCouponBtn.setTitleColor(common2.pointColor(), for: .normal)
            couponListView.myCouponBtn.backgroundColor = UIColor.white
            couponListView.couponCollectionView.delegate = self
            couponListView.couponCollectionView.dataSource = self
            couponListView.couponCollectionView.reloadData()
            couponListView.countLbl.text = "총 \(getCouponInfoDicArr.count)개"
            couponListView.countLbl.asColor(targetStringList: ["총","개"], color: common2.setColor(hex: "#b1b1b1"))
            couponListView.noneMyView.isHidden = true
            if getCouponInfoDicArr.count == 0 {
                couponListView.noneGetCouponView.isHidden = false
            }else {
                couponListView.noneGetCouponView.isHidden = true
            }
        }
    }
}
extension CouponListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenBounds2.width - margin2 * 2, height: 180)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if couponListView.myCouponBtn.backgroundColor == common2.pointColor() {
            print(myCouponInfoDicArr.count)
            print("다다다")
            return self.myCouponInfoDicArr.count
        }else {
            return self.getCouponInfoDicArr.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CouponCollectionCell
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 7
        cell.layer.borderColor = common2.lightGray().cgColor
        cell.clipsToBounds = true
        if couponListView.myCouponBtn.backgroundColor == common2.pointColor() {
            cell.getBtn.isHidden = true
            let couponDic = myCouponInfoDicArr[indexPath.row]
            print("마이")
            print(common2.dicToJsonString(dic: couponDic))
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
                self.getCoupon(couponId: couponId)
                cell.getBtn.backgroundColor = self.common2.lightGray()
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
            guard let expiresAtDic = couponDic["expiresAt"] as? [String:Any] else {return cell}
            if let rawDate = expiresAtDic["raw"] as? String{
                var convertDate = rawDate.dropLast(8)
                let convertDate2 = convertDate.replacingOccurrences(of: "T", with: " ")
                let convertDate3 = convertDate2.replacingOccurrences(of: "-", with: ".")
                cell.thirdLbl.text = "~ \(convertDate3)까지 사용 가능"
            } else {
                cell.thirdLbl.text = ""
            }
           
        }else {
            cell.getBtn.isHidden = false
            let couponDic = getCouponInfoDicArr[indexPath.row]
            guard let couponId = couponDic["_id"] as? String else {return cell}
            guard let name = couponDic["name"] as? String else {return cell}
            guard let discountDic = couponDic["discount"] as? [String:Any] else {return cell}
            guard let type = discountDic["type"] as? String else {return cell}
            guard let valueDic = discountDic["value"] as? [String:Any] else {return cell}
            guard let rawValue = valueDic["raw"] as? Int else {return cell}
            guard let expiresAtDic = couponDic["expiresAt"] as? [String:Any] else {return cell}
            guard let rawDate = expiresAtDic["raw"] as? String else {return cell}
            guard let description = couponDic["description"] as? String else {return cell}
            let convertDate = rawDate.dropLast(8)
            let convertDate2 = convertDate.replacingOccurrences(of: "T", with: " ")
            let convertDate3 = convertDate2.replacingOccurrences(of: "-", with: ".")
            let convertRawValue = common2.numberFormatter(number: rawValue)
            if checkCouponArr.contains(couponId) {
                cell.getBtn.backgroundColor = self.common2.lightGray()
            }
            if type == "percentage" {
                cell.firstLbl.text = convertRawValue + "% 할인"
                cell.firstLbl.asColor(targetStringList: [convertRawValue,"%"], color: common2.pointColor())
            }else {
                cell.firstLbl.text = convertRawValue + "원 할인"
                cell.firstLbl.asColor(targetStringList: [convertRawValue,"원"], color: common2.pointColor())
            }
            cell.secondLbl.text = "[\(name)]"
            cell.thirdLbl.text = "~ \(convertDate3)까지 받기 가능"
            cell.getBtnTapped = {
                self.getCoupon(couponId: couponId)
                cell.getBtn.backgroundColor = self.common2.lightGray()
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
        }

        return cell
    }
}
