//
//  BannerCollectionView.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/10/20.
//

import Foundation
class BannerCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    let common = CommonS()
    var nowPage: Int = 0
    var bannerDicArr = [[String:Any]]()
    let flowLayout = UICollectionViewFlowLayout().then{
        $0.scrollDirection = .horizontal
        
    }
    lazy var bannerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout).then{
        $0.isPagingEnabled = true
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        getBannerImg()
        addSubviewFunc()
        setLayout()
        bannerCollectionView.showsHorizontalScrollIndicator = false
        bannerCollectionView.register(BannerCollectionCell.self, forCellWithReuseIdentifier: "bannerCell")
   
//        bannerTimer()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addSubviewFunc(){
        self.addSubview(bannerCollectionView)
    }
    func setLayout(){
        bannerCollectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    func getBannerImg(){
        guard let settingBannerDicArr = UserDefaults.standard.value(forKey: "setting-banner") as? [[String: Any]] else {return}
        self.bannerDicArr = settingBannerDicArr
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        bannerCollectionView.reloadData()
        bannerTimer()
    }
    func getProductDic(prductId: String){
        common.sendRequest(url: "https://api.clayful.io/v1/products/\(prductId)", method: "get", params: [:], sender: "") { resultJson in
            let infoDic = resultJson as! [String:Any]
            let convertDic = NSMutableDictionary(dictionary: infoDic)
            guard let productId = convertDic["_id"] as? String else {return}
            let vc = DetailProductViewController(productDic: infoDic)
            self.parentViewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("ㄴㄴㄴ")
        print(bannerDicArr)
        return bannerDicArr.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bannerDic = bannerDicArr[indexPath.row]
        if !(bannerDic["banner_action"] is NSNull) {
            print(bannerDic["banner_action"] as! String)
            let actionURL = bannerDic["banner_action"] as! String
            let actionType = actionURL.components(separatedBy: "://")
            if actionType[0] == "product" {
                print(actionType[1])
                getProductDic(prductId: actionType[1])
            }else{
                //나중에 코드 넣을 곳
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as! BannerCollectionCell
        let bannerDic = bannerDicArr[indexPath.row]
        let bannerPath = bannerDic["banner_img"] as! String
        print(bannerPath)
        self.common.setImageUrl(url: "http://110.165.17.124/sampleroad/images/banner/\(bannerPath)", imageView: cell.bannerImgView)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("배너사이즈")
        print(bannerCollectionView.frame.size.width)
        print(bannerCollectionView.frame.height)
         return CGSize(width: bannerCollectionView.frame.size.width  , height:  bannerCollectionView.frame.height)
     }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
         nowPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
     }
    // 2초마다 실행되는 타이머
       func bannerTimer() {
           let _: Timer = Timer.scheduledTimer(withTimeInterval: 5.5, repeats: true) { (Timer) in
               self.bannerMove()
           }
       }
       // 배너 움직이는 매서드
       func bannerMove() {
//           for cell in bannerCollectionView.visibleCells {
//                 if let row = bannerCollectionView.indexPath(for: cell)?.item {
//                      print(row)
//                 }
//               }
          
//           print(bannerDicArr.count)
           // 현재페이지가 마지막 페이지일 경우
           if nowPage == bannerDicArr.count-1 {
           // 맨 처음 페이지로 돌아감
               let rect = bannerCollectionView.layoutAttributesForItem(at: IndexPath(row: 0, section: 0))?.frame
               self.bannerCollectionView.scrollRectToVisible(rect!, animated: true)
               nowPage = 0
               return
           }
           // 다음 페이지로 전환
           nowPage += 1
           let rect = bannerCollectionView.layoutAttributesForItem(at: IndexPath(row: nowPage, section: 0))?.frame
           self.bannerCollectionView.scrollRectToVisible(rect!, animated: true)
       }
}
