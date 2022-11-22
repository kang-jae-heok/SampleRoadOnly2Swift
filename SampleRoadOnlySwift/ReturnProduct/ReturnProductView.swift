//
//  ReturnProductView.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/11/22.
//

import Foundation

class ReturnProductView: UIView {
    let returnProductModel = ReturnProductModel()
    let topView = SimpleTopView().then {
        $0.tit.text = "반품신청"
    }
    let scrlView = UIScrollView()
    lazy var titBackground = UIView().then {
        $0.backgroundColor = common2.pointColor()
    }
    lazy var titLbl = UILabel().then {
        $0.text = "취소하실 상품을 선택해주세요"
        $0.textColor = .black
        $0.font = common2.setFont(font: "bold", size: 13)
    }
    lazy var dateLbl = UILabel().then {
        $0.text = common2.nowDate()
        $0.textColor = .black
        $0.font = common2.setFont(font: "regular", size: 15)
    }
    lazy var deliveryNumLbl = UILabel().then {
        $0.text = "주문번호"
        $0.textColor = .black
        $0.font = common2.setFont(font: "regular", size: 15)
    }
    lazy var productInfoBackground = UIView().then {
        $0.backgroundColor = common2.lightGray()
    }
    lazy var checkBtn = UIButton().then {
        $0.setImage(UIImage(named: "check_on_btn"), for: .normal)
    }
    let productImgView = UIImageView().then{
        $0.backgroundColor = .red
    }
    lazy var companyNameLbl = UILabel().then{
        $0.font = common2.setFont(font: "regular", size: 10)
        $0.text = "테스트"
    }
    lazy var productNameLbl = UILabel().then{
        $0.font = common2.setFont(font: "bold", size: 12)
        $0.text = "테스트"
    }
    lazy var priceLbl = UILabel().then{
        $0.font = common2.setFont(font: "bold", size: 10)
        $0.text = "테스트"
    }
    lazy var deliveryPrice = UILabel().then {
        $0.font = common2.setFont(font: "regular", size: 10)
        $0.text = "테스트"
    }
    lazy var retunrReasonLbl = UITextField().then {
        $0.font = common2.setFont(font: "regular", size: 15)
        $0.textColor = common2.gray()
        $0.tintColor = .clear
        $0.text = "단순변심"
        $0.layer.borderWidth = 1
        $0.addLeftPadding()
    }
    let pickerView = UIPickerView()
    lazy var reasonDetailTit = UILabel().then {
        $0.text = "상세 사유 입력"
        $0.font = common2.setFont(font: "regular", size: 10)
        $0.textColor = common2.gray()
    }
    lazy var reasonDetailContent = UITextView().then {
        $0.showsHorizontalScrollIndicator = false
//        $0.delegate = self
        $0.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 20, right: 5)
        $0.layer.borderWidth = 1
    }
    lazy var returnInfoBackground = UIView().then {
        $0.backgroundColor = common2.lightGray()
    }
    lazy var returnInfoTit = UILabel().then {
        $0.font = common2.setFont(font: "bold", size: 15)
        $0.text = "환불 정보"
    }
    lazy var returnMethodLbl = UILabel().then {
        $0.font = common2.setFont(font: "regular", size: 13)
        $0.text = "환불 수단"
    }
    lazy var returnMethod = UILabel().then {
        $0.font = common2.setFont(font: "regular", size: 13)
        $0.text = "환불 수단"
    }
    lazy var returnPriceLbl = UILabel().then {
        $0.font = common2.setFont(font: "regular", size: 13)
        $0.text = "상품 취소 금액"
    }
    lazy var returnPrice = UILabel().then {
        $0.font = common2.setFont(font: "regular", size: 13)
        $0.text = "환불 수단"
    }
    lazy var couponDiscountLbl = UILabel().then {
        $0.font = common2.setFont(font: "regular", size: 13)
        $0.text = "쿠폰 할인 차감"
    }
    lazy var couponDiscount = UILabel().then {
        $0.font = common2.setFont(font: "regular", size: 13)
        $0.text = "환불 수단"
    }
    lazy var nextBtn = UIButton().then {
        $0.backgroundColor = common2.pointColor()
        $0.setTitle("다음 단계로 이동", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = common2.setFont(font: "bold", size: 15)
        $0.addTarget(self, action: #selector(touchNextBtn), for: .touchUpInside)
    }
    lazy var homeBtn = UIButton().then {
        $0.backgroundColor = common2.pointColor()
        $0.setTitle("홈 가기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = common2.setFont(font: "bold", size: 18)
    }
    lazy var yesBtn = UIButton().then {
        $0.setTitle("네", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = common2.setFont(font: "regular", size: 18)
    }
    lazy var noBtn = UIButton().then {
        $0.setTitle("아니오", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = common2.setFont(font: "regular", size: 18)
        $0.addTarget(self, action: #selector(touchNoBtn), for: .touchUpInside)
    }
    lazy var alertView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 9
        let tit = UILabel().then {
            $0.text = "확인시 바로 반품요청이 진행됩니다 \n 진행하시겠습니까?"
            $0.font = common2.setFont(font: "regular", size: 18)
            $0.numberOfLines = 0
//            $0.asFont(targetStringList: ["변경된 정보","저장"], font: common2.setFont(font: "bold", size: 18))
        }
        $0.addSubview(yesBtn)
        $0.addSubview(noBtn)
        $0.addSubview(tit)
        tit.snp.makeConstraints {
            $0.left.top.equalToSuperview().offset(margin2)
        }
        yesBtn.snp.makeConstraints {
            $0.right.bottom.equalToSuperview().offset(-margin2)
        }
        noBtn.snp.makeConstraints {
            $0.right.equalTo(yesBtn.snp.left).offset(-margin2)
            $0.bottom.equalToSuperview().offset(-margin2)
        }
        $0.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: screenBounds2.width - margin2 * 2, height: 100))
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubviewFunc()
        setLayout()
        createPickerView()
//        dismissPickerView()
    }
    required init?(coder: NSCoder) {
        fatalError("init-fail")
    }
    func addSubviewFunc(){
        [topView,scrlView,homeBtn].forEach {
            self.addSubview($0)
        }
        [titBackground,dateLbl,deliveryNumLbl,productInfoBackground,retunrReasonLbl,reasonDetailTit,reasonDetailContent,returnInfoBackground,nextBtn].forEach {
            scrlView.addSubview($0)
        }
        [checkBtn,productImgView,productNameLbl,companyNameLbl,priceLbl,deliveryPrice].forEach {
            productInfoBackground.addSubview($0)
        }
        [returnInfoTit,returnMethodLbl,returnMethod,returnPriceLbl,returnPrice,couponDiscountLbl,couponDiscount].forEach {
            returnInfoBackground.addSubview($0)
        }
        titBackground.addSubview(titLbl)
    }
    func setLayout(){
        topView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(screenBounds2.width/4)
        }
        scrlView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(homeBtn.snp.top)
        }
        titBackground.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview().offset(margin2)
            $0.height.equalTo(30)
            $0.width.equalTo(screenBounds2.width)
        }
        titLbl.snp.makeConstraints {
            $0.left.equalToSuperview().offset(5)
            $0.centerY.equalToSuperview()
        }
        dateLbl.snp.makeConstraints {
            $0.left.equalToSuperview().offset(margin2)
            $0.top.equalTo(titBackground.snp.bottom).offset(margin2)
        }
        deliveryNumLbl.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-margin2)
            $0.centerY.equalTo(dateLbl)
        }
        productInfoBackground.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(dateLbl.snp.bottom).offset(margin2)
            $0.width.equalTo(screenBounds2.width)
        }
        checkBtn.snp.makeConstraints {
            $0.top.equalTo(productImgView)
            $0.left.equalToSuperview().offset(margin2)
        }
        productImgView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.left.equalTo(checkBtn.snp.right).offset(margin2)
            $0.bottom.equalToSuperview().offset(-margin2)
            $0.size.equalTo(CGSize(width: margin2 * 3, height: 70))
        }
        companyNameLbl.snp.makeConstraints{
            $0.left.equalTo(productImgView.snp.right).offset(6)
            $0.bottom.equalTo(productNameLbl.snp.top).offset(-6)
        }
        productNameLbl.snp.makeConstraints{
            $0.left.equalTo(companyNameLbl)
            $0.centerY.equalToSuperview()
        }
        priceLbl.snp.makeConstraints{
            $0.left.equalTo(companyNameLbl)
            $0.top.equalTo(productNameLbl.snp.bottom).offset(6)
        }
        deliveryPrice.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-margin2)
            $0.centerY.equalTo(priceLbl)
        }
        retunrReasonLbl.snp.makeConstraints {
            $0.top.equalTo(productInfoBackground.snp.bottom).offset(margin2)
            $0.left.equalToSuperview().offset(margin2)
            $0.right.equalToSuperview().offset(-margin2)
            $0.height.equalTo(30)
        }
        reasonDetailTit.snp.makeConstraints {
            $0.left.equalToSuperview().offset(margin2)
            $0.top.equalTo(retunrReasonLbl.snp.bottom).offset(margin2)
        }
        reasonDetailContent.snp.makeConstraints {
            $0.top.equalTo(reasonDetailTit.snp.bottom).offset(margin2)
            $0.left.equalToSuperview().offset(margin2)
            $0.right.equalToSuperview().offset(-margin2)
            $0.width.equalTo(screenBounds2.width - margin2 * 2)
            $0.height.equalTo(300)
        }
        returnInfoBackground.snp.makeConstraints {
            $0.top.equalTo(reasonDetailContent.snp.bottom).offset(margin2)
            $0.left.right.equalToSuperview()
        }
        returnInfoTit.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(margin2)
        }
        returnMethodLbl.snp.makeConstraints {
            $0.left.equalTo(returnInfoTit).offset(5)
            $0.top.equalTo(returnInfoTit.snp.bottom).offset(margin2)
        }
        returnMethod.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-margin2)
            $0.centerY.equalTo(returnMethodLbl)
        }
        returnPriceLbl.snp.makeConstraints {
            $0.left.equalTo(returnInfoTit).offset(5)
            $0.top.equalTo(returnMethodLbl.snp.bottom).offset(5)
        }
        returnPrice.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-margin2)
            $0.centerY.equalTo(returnPriceLbl)
        }
        couponDiscountLbl.snp.makeConstraints {
            $0.left.equalTo(returnInfoTit).offset(5)
            $0.top.equalTo(returnPriceLbl.snp.bottom).offset(5)
            $0.bottom.equalToSuperview().offset(-margin2)
        }
        couponDiscount.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-margin2)
            $0.centerY.equalTo(couponDiscountLbl)
        }
        nextBtn.snp.makeConstraints {
            $0.left.equalToSuperview().offset(margin2)
            $0.right.equalToSuperview().offset(-margin2)
            $0.top.equalTo(returnInfoBackground.snp.bottom).offset(margin2 * 2)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().offset(-50)
        }
        homeBtn.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(80)
        }
    }
    func createPickerView() {
       
        pickerView.delegate = self
        retunrReasonLbl.inputView = pickerView
    }
    @objc func touchNoBtn(){
        print("여기")
        let viewWithTag = self.viewWithTag(100)
        viewWithTag?.removeFromSuperview()
    }
    @objc func touchNextBtn(){
        common2.addGrayAlertView(view: self, alertView: alertView)
    }

//
//    func dismissPickerView() {
//        let toolBar = UIToolbar()
//        toolBar.sizeToFit()
//        let button = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(closePicker))
//        toolBar.setItems([button], animated: true)
//        toolBar.isUserInteractionEnabled = true
//        retunrReasonLbl.inputAccessoryView = toolBar
//    }
//    @objc func closePicker(){
//        pickerView.isHidden = tr
//    }

   
}
extension ReturnProductView:  UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
          return 1
      }


      func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
          return returnProductModel.returnReasonArr.count
      }


      func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return returnProductModel.returnReasonArr[row]
      }


      func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
          retunrReasonLbl.text = returnProductModel.returnReasonArr[row]
      }

}
