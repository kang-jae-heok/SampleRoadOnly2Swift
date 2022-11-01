//
//  getSampleView.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/10/14.
//

import Foundation
import UIKit
class GetSampleView: UIView{
    struct sampleItems {
        var sampleImgURL = String()
        var companyName = String()
        var sampleName = String()
        init(sampleImgURL: String, companyName: String, sampleName: String){
            self.sampleName = sampleName
            self.sampleImgURL = sampleImgURL
            self.companyName = companyName
        }
    }
    let screenBounds = UIScreen.main.bounds
    let margin = 17.0
    lazy var ratio = screenBounds.width/414.0
    let common = CommonS()
    lazy var tit = UILabel().then{
        $0.text = "샘플받기"
        $0.textColor = common.pointColor()
        $0.font = common.setFont(font: "bold", size: 17)
    }
    lazy var closeBtn = UIButton().then{
        let img = UIImage(named: "x_btn")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        $0.tintColor = common.pointColor()
        $0.setImage(img, for: .normal)
    }
    let typeTitArr = ["깨끗이 닦아내는 Cleansing","하루종일 촉촉한 Moisturising","햇빛을 막아주는 Suncare"]
    lazy var typeTit = UILabel().then{
        $0.textColor = .white
        $0.backgroundColor = common.pointColor()
        $0.font = common.setFont(font: "bold", size: 20)
        $0.text = typeTitArr[0]
        $0.textAlignment = .center
    }
    lazy var subTit = UILabel().then{
        $0.textColor = common.pointColor()
        $0.backgroundColor = common.lightGray()
        $0.font = common.setFont(font: "semibold", size: 15 )
        $0.textAlignment = .center
        $0.text = "아래에서 원하시는 제품을 골라주세요!"
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }
    let bottomBtnView = UIView().then{
        $0.backgroundColor = .white
    }
    let flowLayout = UICollectionViewFlowLayout().then{
        $0.scrollDirection = .horizontal
    }
   
    lazy var sampleCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout).then{
        $0.backgroundColor = .white
    }
    lazy var data = [sampleItems(sampleImgURL: "a", companyName: "test", sampleName: "test"),sampleItems(sampleImgURL: "a", companyName: "test2", sampleName: "test2"),sampleItems(sampleImgURL: "a", companyName: "test", sampleName: "test")]
    var sampleArr = [[String:Any]]()
    lazy var selectedSampleView = UIView()
    lazy var nextBtn = UIButton().then{
        $0.setTitle("다음", for: .normal)
        $0.backgroundColor = common.pointColor()
        $0.layer.cornerRadius = 5
    }
    lazy var backBtn = UIButton().then{
        $0.setTitle("이전", for: .normal)
        $0.backgroundColor = common.pointColor()
        $0.layer.cornerRadius = 5
        $0.isHidden = true
    }
    lazy var applicateBtn = UIButton().then{
        $0.setTitle("신청하기", for: .normal)
        $0.backgroundColor = common.pointColor()
        $0.layer.cornerRadius = 5
        $0.isHidden = true
        $0.addTarget(self, action: #selector(touchApplicateBtn), for: .touchUpInside)
    }
    
    lazy var selectedStackView  = UIStackView().then{
        let btnSize = screenBounds.width/2 - 50 - (screenBounds.width/3 - margin - 25)
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 50
        $0.distribution = .fillEqually
        $0.isLayoutMarginsRelativeArrangement = true
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: btnSize/2 + 1.5, leading: margin, bottom: btnSize/2 + 1.5, trailing: margin)
    }
    lazy var selectedViews: [UIView] = {
        var views = [UIView]()
        for i in 0...2 {
            let subBackgroundView = UIView().then{
                $0.backgroundColor = .clear
                $0.alpha = 0.0
            }
            let backgroundView = UIView().then{
                $0.backgroundColor = common.lightGray()
                $0.clipsToBounds = true
                $0.layer.cornerRadius = 0.5 * (screenBounds.width/3 - margin - 25)
            }
            let sampleImgView = UIImageView().then{
                $0.tag = i
            }
            let unselectBtn = UIButton().then{
                $0.tag = i
                $0.addTarget(self, action: #selector(touchUnselectedBtn(sender:)), for: .touchUpInside)
            }
            let xImgView = UIImageView().then{
                $0.image = UIImage(named: "x_btn")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                $0.tintColor = UIColor.white
            }
            let xBackgroundView = UIView().then{
                $0.backgroundColor = common.pointColor()
                $0.clipsToBounds = true
                $0.layer.cornerRadius = 0.5 * 25
            }
            
            [sampleImgView,unselectBtn].forEach{
                backgroundView.addSubview($0)
            }
            [backgroundView,xBackgroundView].forEach{
                subBackgroundView.addSubview($0)
            }
            xBackgroundView.addSubview(xImgView)
            views.append(subBackgroundView)
            selectedStackView.addArrangedSubview(views[i])
            unselectBtn.snp.makeConstraints{
                $0.edges.equalToSuperview()
            }
            sampleImgView.snp.makeConstraints{
                $0.top.left.equalToSuperview().offset(14 * ratio)
                $0.bottom.right.equalToSuperview().offset(-14 * ratio)
            }
            backgroundView.snp.makeConstraints{
                $0.edges.equalToSuperview()
            }
            xBackgroundView.snp.makeConstraints{
                $0.centerX.equalTo(sampleImgView.snp.right)
                $0.centerY.equalTo(sampleImgView.snp.top)
                $0.size.equalTo(CGSize(width: 25, height: 25))
            }
            xImgView.snp.makeConstraints{
                $0.centerX.centerY.equalToSuperview()
                $0.size.equalTo(CGSize(width: 20, height: 20))
            }
          
            
        }
        return views
    }()
    let alphaView = UIView().then{
        $0.isHidden = true
        $0.backgroundColor = .black.withAlphaComponent(0.3)
    }
    let alphaHiddenBtn = UIButton().then{
        $0.isHidden = true
        $0.backgroundColor = .clear
        $0.addTarget(self, action: #selector(touchAlphaHiddenBtn), for: .touchUpInside)
    }
    var selectedArr = [String]()
    var typeString = String()
    var selectedDicArr = [[String: Any]]()
    var detailDic = [String:Any]()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white
        
        sampleCollectionView.showsHorizontalScrollIndicator = false
        sampleCollectionView.register(SampleCollectionCell.self, forCellWithReuseIdentifier: "cell")
        getSample(type: "클렌징")
        
        
        addSubviewFunc()
        setLayout()
    }
    required init(coder: NSCoder) {
        fatalError("init fail")
    }
    func addSubviewFunc(){
        [tit,closeBtn,typeTit,subTit,bottomBtnView,sampleCollectionView,selectedStackView,alphaView].forEach{
            self.addSubview($0)
        }
        alphaView.addSubview(alphaHiddenBtn)
        alphaView.addSubview(selectedSampleView)
     
        [nextBtn,backBtn,applicateBtn].forEach{
            bottomBtnView.addSubview($0)
        }
    }
    func setLayout(){
        tit.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(closeBtn)
        }
        closeBtn.snp.makeConstraints{
            $0.top.equalToSuperview().offset(50)
            $0.right.equalToSuperview().offset(-margin)
            $0.size.equalTo(CGSize(width: 50, height: 50))
        }
        selectedStackView.snp.makeConstraints{
            $0.top.equalTo(tit.snp.bottom).offset(50)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(tit.snp.bottom).offset(screenBounds.width/2)
        }
        
        typeTit.snp.makeConstraints{
            $0.top.equalTo(selectedStackView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(selectedStackView.snp.bottom).offset(70)
        }
        subTit.snp.makeConstraints{
            $0.top.equalTo(typeTit.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(margin)
            $0.right.equalToSuperview().offset(-margin)
            $0.bottom.equalTo(typeTit.snp.bottom).offset(10 + 70)
        }
        sampleCollectionView.snp.makeConstraints{
            $0.top.equalTo(subTit.snp.bottom).offset(10)
            $0.bottom.equalTo(bottomBtnView.snp.top).offset(-10)
            $0.left.right.equalToSuperview()
        }
        bottomBtnView.snp.makeConstraints{
            $0.bottom.left.right.equalToSuperview()
            $0.top.equalTo(self.snp.bottom).offset(-90)
        }
        nextBtn.snp.makeConstraints{
            $0.left.equalTo(super.snp.centerX).offset(10)
            $0.right.equalToSuperview().offset(-margin)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(50)
        }
        backBtn.snp.makeConstraints{
            $0.right.equalTo(super.snp.centerX).offset(-10)
            $0.left.equalToSuperview().offset(margin)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(50)
        }
        applicateBtn.snp.makeConstraints{
            $0.left.equalToSuperview().offset(margin)
            $0.right.equalToSuperview().offset(-margin)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(50)
        }
        selectedViews.forEach{
            $0.snp.makeConstraints{
                print("이쪽")
                $0.size.equalTo(CGSize(width: 10, height: 50))
            }
        }
        selectedSampleView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(150)
            $0.bottom.equalToSuperview().offset(-150)
            $0.left.equalToSuperview().offset(margin)
            $0.right.equalToSuperview().offset(-margin)
        }
        alphaView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        alphaHiddenBtn.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    func getSample(type: String){
        
        //        [self selectSampleList:[NSString stringWithFormat:@"클렌징 %@",curSampleSubCate]];
        //    }else if (curCateIdx==1) {
        //        [self selectSampleList:[NSString stringWithFormat:@"모이스처 %@",curSampleSubCate]];
        //    }else {
        //        [self selectSampleList:[NSString stringWithFormat:@"선케어"]];
        //    }
        
        
        typeString = type
        let encodedType =  typeString.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        //        NSDictionary *thumbDic = [NSDictionary dictionaryWithDictionary:[dic valueForKey:@"thumbnail"]];
        //        NSString *thumbUrl = [[thumbDic valueForKey:@"url"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        //
        //        NSString *cacheKey = [dic valueForKey:@"name"];
        
        common.sendRequest(url: "https://api.clayful.io/v1/products?search:keywords=\(String(describing: encodedType!))", method: "get", params: [:], sender: "") { [self] resultJson in
            sampleArr = resultJson as! [[String:Any]]
            sampleCollectionView.delegate = self
            sampleCollectionView.dataSource = self
            sampleCollectionView.reloadData()
        }
    }
    @objc func touchUnselectedBtn(sender: UIButton){
        addAnimation(tag: sender.tag)
        if sender.tag < selectedArr.count{
            selectedArr.remove(at: sender.tag)
            selectedDicArr.remove(at: sender.tag)
            drawSelectedViews()
        }
        changeApplicateBtn()
    }
    func addAnimation(tag: Int){
        for i in 0...selectedArr.count - 1 {
            selectedViews[i].subviews[0].subviews.compactMap{$0 as? UIImageView}[0].alpha = 0.0
            UIView.animate(withDuration: 0.5, animations: { [self] in
                selectedViews[i].subviews[0].subviews.compactMap{$0 as? UIImageView}[0].alpha = 1.0
            })
        }
    }
    func drawSelectedViews() {
        for i in 0...2{
            selectedViews[i].alpha = 0.0
            selectedViews[i].subviews[0].subviews.compactMap{$0 as? UIImageView}[0].image = nil
        }
        if selectedArr.count != 0 {
            for i in 0...selectedArr.count - 1 {
                selectedViews[i].alpha = 1.0
                let encoded = selectedArr[i].description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                common.setImageUrl(url: encoded!, imageView: selectedViews[i].subviews[0].subviews.compactMap{$0 as? UIImageView}[0])
            }
        }
        
    }
    func changeApplicateBtn(){
        if selectedArr.count == 3 {
            applicateBtn.isHidden = false
            nextBtn.isHidden = true
            backBtn.isHidden = true
        }else if selectedArr.count != 3 && typeString != "클렌징"{
            applicateBtn.isHidden = true
            nextBtn.isHidden = false
            backBtn.isHidden = false
        }else{
            applicateBtn.isHidden = true
            nextBtn.isHidden = false
            backBtn.isHidden = true
        }
    }
    @objc func touchApplicateBtn(){
        alphaView.isHidden = false
        alphaHiddenBtn.isHidden = false
//        [tit,typeTit,subTit,bottomBtnView,sampleCollectionView,selectedStackView].forEach{
//            $0.alpha = 0.3
//        }
      
        let dataSelectedSampleView = SelectedSampleView(frame: .zero, arrDic: selectedDicArr, vc: parentViewController ?? GetSampleViewController())
        selectedSampleView.addSubview(dataSelectedSampleView)
        dataSelectedSampleView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    @objc func touchAlphaHiddenBtn(){
        alphaView.isHidden = true
        alphaHiddenBtn.isHidden = true
    }
    @objc func touchDetailBtn(sender: UIButton){
        let converDic = NSMutableDictionary(dictionary: sampleArr[sender.tag])
        let vc = ProductDetailViewController(data: converDic)
        parentViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension GetSampleView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenBounds.width/2 - 50, height: screenBounds.height * 2 / 5)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(sampleArr.count)
        return sampleArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SampleCollectionCell
        let dataDic = sampleArr[indexPath.row]
        let brandDic = dataDic["brand"] as! [String:Any]
        let ThumDic = dataDic["thumbnail"] as! [String:Any]
        let ThumbURL = ThumDic["url"] as! String
        let encoded = ThumbURL.description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        cell.sampleName.text = dataDic["name"] as? String
        cell.companyLbl.text = brandDic["name"] as? String
        cell.detailBtn.tag = indexPath.row
        cell.detailBtn.addTarget(self, action: #selector(touchDetailBtn(sender:)), for: .touchUpInside)
        common.setImageUrl(url: encoded!, imageView: cell.sampleImgView)
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        if selectedViews[0].subviews.compactMap{$0 as? UIImageView}[0].image == nil{
        //            selectedArr.append(selectedViews[0].subviews.compactMap{$0 as? UIImageView}[0])
        //            brankImgView = selectedViews[0].subviews.compactMap{$0 as? UIImageView}[0]
        //        }else if selectedViews[1].subviews.compactMap{$0 as? UIImageView}[0].image == nil{
        //            selectedArr.append(selectedViews[1].subviews.compactMap{$0 as? UIImageView}[0])
        //            brankImgView = selectedViews[1].subviews.compactMap{$0 as? UIImageView}[0]
        //        }else if selectedViews[2].subviews.compactMap{$0 as? UIImageView}[0].image == nil {
        //            selectedArr.append(selectedViews[2].subviews.compactMap{$0 as? UIImageView}[0])
        //            brankImgView = selectedViews[2].subviews.compactMap{$0 as? UIImageView}[0]
        //        }
        let dataDic = sampleArr[indexPath.row]
        let ThumDic = dataDic["thumbnail"] as! [String:Any]
        let ThumbURL = ThumDic["url"] as! String
        let encoded = ThumbURL.description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let index = selectedArr.firstIndex(of: encoded!) {
            selectedArr.remove(at: index)
            selectedDicArr.remove(at: index)
            addAnimation(tag: index)
            drawSelectedViews()
        }else if selectedArr.count < 3 {
            selectedArr.append(encoded!)
            selectedDicArr.append(dataDic)
            drawSelectedViews()
        }
        changeApplicateBtn()
    }
    
    
}
