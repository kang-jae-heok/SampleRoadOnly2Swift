//
//  EditProfileView.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/11/15.
//

import Foundation
class EditProfileView: UIView, UITextFieldDelegate {
    var placeholderStr = String()
    var dateFormate = Bool()
    let topView = SimpleTopView().then {
        $0.tit.text = "내 정보 수정"
    }
    lazy var saveBtn = UIButton().then{
        $0.setTitle("저장", for: .normal)
        $0.setTitleColor(common2.gray(), for: .normal)
        $0.titleLabel?.font = common2.setFont(font: "bold", size: 15)
        $0.addTarget(self, action: #selector(touchSaveBtn), for: .touchUpInside)
    }
    let sclView = UIScrollView()
    lazy var profileBtn = UIButton().then {
        if UserDefaults.standard.string(forKey: "user_image") ?? "" == ""  ||  !UserDefaults.contains("user_image") ||  UserDefaults.standard.string(forKey: "user_image") == "null"{
            $0.setImage(UIImage(named: "profile_btn"), for: .normal)
        }else {
            common2.setButtonImageUrl(url: UserDefaults.standard.string(forKey: "user_image")!, button: $0)
        }
        $0.clipsToBounds = true
        $0.backgroundColor = common2.pointColor()
        $0.imageView?.contentMode = .scaleAspectFill
    }
    let editProfileBtn = UIButton().then {
        $0.setImage(UIImage(named: "edit_profile_btn"), for: .normal)
    }
    let originalInfoView = UIView()
    
    lazy var originalTitBackgroundView = UIView().then {
        $0.backgroundColor = common2.pointColor().withAlphaComponent(0.5)
    }
    lazy var originalTit = UILabel().then {
        $0.font = common2.setFont(font: "regular", size: 13)
        $0.text = "\(UserDefaults.standard.string(forKey: "user_alias") ?? "") 님의 기본 정보"
        $0.asFontColor(targetStringList: ["\(UserDefaults.standard.string(forKey: "user_alias") ?? "")"], font: common2.setFont(font: "bold", size: 16), color: UIColor.black)
    }

    lazy var emailLbl = UILabel().then {
        $0.text = "이메일"
        $0.font = common2.setFont(font: "bold", size: 13)
    }
    lazy var email = UILabel().then {
        $0.text = UserDefaults.standard.string(forKey: "user_email")
        $0.font = common2.setFont(font: "regular", size: 13)
    }
    lazy var nameLbl = UILabel().then {
        $0.text = "닉네임"
        $0.font = common2.setFont(font: "bold", size: 13)
    }
    lazy var nameTextField = UITextField().then{
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.5),
            NSAttributedString.Key.font : common2.setFont(font: "medium", size: 18)
        ]
        placeholderStr = UserDefaults.standard.string(forKey: "user_alias") ?? "샘플털이범"
        $0.placeholder = placeholderStr
        $0.attributedPlaceholder = NSAttributedString(string: placeholderStr, attributes:attributes)
    }
    lazy var subNameLbl = UILabel().then {
        $0.font = common2.setFont(font: "regular", size: 10)
    }
    lazy var nameDuplicateCheckBtn = UIButton().then{
        $0.backgroundColor = common2.pointColor()
        $0.setTitle("중복검사", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = common2.setFont(font: "bold", size: 10)
        $0.layer.cornerRadius = 5
    }
    lazy var nameTextFieldLineView = UIView().then{
        $0.backgroundColor = common2.pointColor()
    }
    lazy var passwordLbl = UILabel().then {
        $0.text = "비밀번호"
        $0.font = common2.setFont(font: "bold", size: 13)
    }
    lazy var passwordTextField = UITextField().then{
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.5),
            NSAttributedString.Key.font : common2.setFont(font: "medium", size: 18)
        ]
        placeholderStr = "비밀번호를 입력해주세요"
        $0.placeholder = placeholderStr
        $0.attributedPlaceholder = NSAttributedString(string: placeholderStr, attributes:attributes)
        $0.isSecureTextEntry = true
    }
    lazy var passwordTextFieldLineView = UIView().then{
        $0.backgroundColor = common2.pointColor().withAlphaComponent(0.5)
    }
    let detailInfoView = UIView()
    lazy var detailTitBackgroundView = UIView().then {
        $0.backgroundColor = common2.pointColor().withAlphaComponent(0.5)
    }
    lazy var detailTit = UILabel().then {
        $0.font = common2.setFont(font: "bold", size: 16)
        $0.text = "상세 정보  고객님을 위한 화장품을 추천해드리는데 필요합니다:)"
        $0.asFont(targetStringList: ["고객님을 위한 화장품을 추천해드리는데 필요합니다:)"], font: common2.setFont(font: "regular", size: 10))
    }
    lazy var genderLbl = UILabel().then {
        $0.text = "성별"
        $0.font = common2.setFont(font: "bold", size: 13)
    }
    lazy var womanBtn = UIButton().then {
        $0.setTitle("여성", for: .normal)
        $0.setTitleColor(common2.pointColor(), for: .normal)
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = common2.pointColor().cgColor
        $0.layer.borderWidth = 1
        $0.titleLabel?.font = common2.setFont(font: "bold", size: 13)
        $0.addTarget(self, action: #selector(touchWomanBtn), for: .touchUpInside)
    }
    lazy var manBtn = UIButton().then {
        $0.setTitle("남성", for: .normal)
        $0.setTitleColor(common2.pointColor(), for: .normal)
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = common2.pointColor().cgColor
        $0.layer.borderWidth = 1
        $0.titleLabel?.font = common2.setFont(font: "bold", size: 13)
        $0.addTarget(self, action: #selector(touchManBtn), for: .touchUpInside)
    }
    lazy var noneBtn = UIButton().then {
        $0.setTitle("기타", for: .normal)
        $0.setTitleColor(common2.pointColor(), for: .normal)
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = common2.pointColor().cgColor
        $0.layer.borderWidth = 1
        $0.titleLabel?.font = common2.setFont(font: "bold", size: 13)
        $0.addTarget(self, action: #selector(touchNoneBtn), for: .touchUpInside)
    }
    lazy var subGenderLbl = UILabel().then {
        $0.text = "성별을 입력해주시면 더 정확한 추천이 가능해요!"
        $0.textColor = .red
        $0.font = common2.setFont(font: "regular", size: 10)
        $0.isHidden = true
    }
    lazy var ageLbl = UILabel().then {
        $0.text = "생년월일"
        $0.font = common2.setFont(font: "bold", size: 13)
    }
    lazy var age = UITextField().then {
        let attributes = [
            NSAttributedString.Key.foregroundColor: common2.pointColor().withAlphaComponent(1),
            NSAttributedString.Key.font : common2.setFont(font: "medium", size: 13)
        ]
        placeholderStr = UserDefaults.standard.string(forKey: "user_birth") ?? ""
        $0.placeholder = placeholderStr
        $0.attributedPlaceholder = NSAttributedString(string: placeholderStr, attributes:attributes)
        $0.textColor = common2.pointColor()
        $0.font = common2.setFont(font: "medium", size: 13)
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = common2.pointColor().cgColor
        $0.layer.borderWidth = 1
        $0.textAlignment = .center
        $0.keyboardType = .numberPad
        $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    lazy var skinTypeLbl = UILabel().then {
        $0.text = "피부타입"
        $0.font = common2.setFont(font: "bold", size: 13)
    }
    let skinTypeArr = ["건성","중성","지성","복합성"]
    lazy var skinTypeBtns: [UIButton] = {
        var btns = [UIButton]()
        for i in 0...3 {
            let btn = UIButton().then {
                $0.setTitle(skinTypeArr[i], for: .normal)
                if UserDefaults.standard.string(forKey: "user_skin_type") ?? ""  == skinTypeArr[i]{
                    $0.setTitleColor(.white, for: .normal)
                    $0.backgroundColor = common2.pointColor()
                }else {
                    $0.setTitleColor(common2.pointColor(), for: .normal)
                    $0.backgroundColor = .clear
                }
                $0.layer.cornerRadius = 5
                $0.layer.borderColor = common2.pointColor().cgColor
                $0.layer.borderWidth = 1
                $0.titleLabel?.font = common2.setFont(font: "bold", size: 13)
                $0.tag = i
                $0.addTarget(self, action: #selector(touchSkinTypeBtn(sender: )), for: .touchUpInside)
            }
            btns.append(btn)
        }
        return btns
    }()
    let skinWorriesArr = ["트러블","민감성","건조함","기름기","미백"]
    lazy var skinWorriesLbl = UILabel().then {
        $0.text = "피부타입"
        $0.font = common2.setFont(font: "bold", size: 13)
    }
    lazy var skinWorriesBtns: [UIButton] = {
        var btns = [UIButton]()
        for i in 0...4 {
            let btn = UIButton().then {
                $0.setTitle(skinWorriesArr[i], for: .normal)
                $0.setTitleColor(common2.pointColor(), for: .normal)
                $0.layer.cornerRadius = 5
                $0.layer.borderColor = common2.pointColor().cgColor
                $0.layer.borderWidth = 1
                $0.titleLabel?.font = common2.setFont(font: "bold", size: 13)
                $0.tag = i
                $0.addTarget(self, action: #selector(touchSkinWorriesBtn(sender:)), for: .touchUpInside)
                guard let skinGominArr = UserDefaults.standard.value(forKey: "user_skin_gomin") as? [String] else {return}
                if skinGominArr.count != 0 {
                    if skinGominArr.contains(skinWorriesArr[i]) {
                        $0.setTitleColor(.white, for: .normal)
                        $0.backgroundColor = common2.pointColor()
                    }
                }
            }
            btns.append(btn)
        }
        return btns
    }()
    lazy var yesBtn = UIButton().then {
        $0.setTitle("네", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = common2.setFont(font: "bold", size: 18)
        
    }
    lazy var noBtn = UIButton().then {
        $0.setTitle("아니오", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = common2.setFont(font: "bold", size: 18)
        $0.addTarget(self, action: #selector(touchNoBtn), for: .touchUpInside)
    }
    lazy var alertView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 9
        let tit = UILabel().then {
            $0.text = "변경된 정보를 저장할까요?"
            $0.font = common2.setFont(font: "regular", size: 18)
            $0.asFont(targetStringList: ["변경된 정보","저장"], font: common2.setFont(font: "bold", size: 18))
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
        age.delegate = self
        addSubviewFunc()
        setLayout()
        print("성별")
//        guard let gender = UserDefaults.standard.string(forKey: "user_gender")  else {return}
        let gender = UserDefaults.standard.string(forKey: "user_gender")!
        
        print(gender)
        if gender == "male" {
            manBtn.setTitleColor(.white, for: .normal)
            manBtn.backgroundColor = common2.pointColor()
        }else if gender == "female" {
            womanBtn.setTitleColor(.white, for: .normal)
            womanBtn.backgroundColor = common2.pointColor()
        }else {
            noneBtn.setTitleColor(.white, for: .normal)
            noneBtn.backgroundColor = common2.pointColor()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init fail(EditProfileView)")
    }
    func addSubviewFunc(){
        [topView,sclView].forEach{
            self.addSubview($0)
        }
        [profileBtn,editProfileBtn,originalInfoView,detailInfoView].forEach{
            sclView.addSubview($0)
        }
        topView.addSubview(saveBtn)
        [originalTitBackgroundView,emailLbl,email,nameLbl,nameTextField,nameDuplicateCheckBtn,nameTextFieldLineView,subNameLbl].forEach {
            originalInfoView.addSubview($0)
        }
        [detailTitBackgroundView,genderLbl,womanBtn,manBtn,noneBtn,subGenderLbl,ageLbl,age,skinTypeLbl,skinTypeBtns[0],skinTypeBtns[1],skinTypeBtns[2],skinTypeBtns[3],skinWorriesLbl,skinWorriesBtns[0],skinWorriesBtns[1],skinWorriesBtns[2],skinWorriesBtns[3],skinWorriesBtns[4]].forEach {
            detailInfoView.addSubview($0)
        }
        detailTitBackgroundView.addSubview(detailTit)
        originalTitBackgroundView.addSubview(originalTit)
    }
    func setLayout(){
        topView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(screenBounds2.width/4)
        }
        saveBtn.snp.makeConstraints {
            $0.centerY.equalTo(topView.tit.snp.centerY)
            $0.right.equalToSuperview().offset(-margin2)
        }
        sclView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(margin2)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        profileBtn.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 100, height: 100))
        }
        profileBtn.layer.cornerRadius = 50
        editProfileBtn.snp.makeConstraints {
            $0.right.bottom.equalTo(profileBtn).offset(-5)
        }
        originalInfoView.snp.makeConstraints {
            $0.top.equalTo(profileBtn.snp.bottom).offset(20)
            $0.left.right.equalToSuperview()
            $0.width.equalTo(screenBounds2.width)
        }
        originalTitBackgroundView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(margin2)
            $0.left.right.equalToSuperview()
            $0.size.height.equalTo(42)
            $0.width.equalTo(screenBounds2.width)
        }
        originalTit.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(margin2)
            $0.right.equalToSuperview()
        }
        emailLbl.snp.makeConstraints {
            $0.left.equalToSuperview().offset(margin2)
            $0.top.equalTo(originalTitBackgroundView.snp.bottom).offset(30)
        }
        email.snp.makeConstraints {
            $0.left.equalToSuperview().offset(screenBounds2.width/4)
            $0.centerY.equalTo(emailLbl)
        }
        nameLbl.snp.makeConstraints {
            $0.left.equalTo(emailLbl)
            $0.top.equalTo(email.snp.bottom).offset(50)
        }
        nameTextFieldLineView.snp.makeConstraints {
            $0.left.equalTo(email)
            $0.right.equalToSuperview().offset(-margin2)
            $0.bottom.equalTo(nameLbl).offset(5)
            $0.size.height.equalTo(2)
        }
        subNameLbl.snp.makeConstraints {
            $0.top.equalTo(nameTextFieldLineView.snp.bottom).offset(2)
            $0.left.equalTo(email)
        }
        nameTextField.snp.makeConstraints {
            $0.left.equalTo(nameTextFieldLineView)
            $0.centerY.equalTo(nameLbl)
            $0.right.equalTo(nameDuplicateCheckBtn.snp.left)
        }
        nameDuplicateCheckBtn.snp.makeConstraints {
            $0.right.equalTo(nameTextFieldLineView)
            $0.bottom.equalTo(nameTextFieldLineView.snp.top).offset(-2)
            $0.width.equalTo(50)
            
        }
        subNameLbl.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-30)
        }
        
     
        detailInfoView.snp.makeConstraints {
            $0.top.equalTo(originalInfoView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
            $0.width.equalTo(screenBounds2.width)
        }
        detailTitBackgroundView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.size.height.equalTo(42)
            $0.width.equalTo(screenBounds2.width)
        }
        detailTit.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(margin2)
            $0.right.equalToSuperview()
        }
        genderLbl.snp.makeConstraints {
            $0.top.equalTo(detailTitBackgroundView.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(margin2)
            
        }
        let genderBtnSize = CGSize(width: 40, height: 40)
        womanBtn.snp.makeConstraints {
            $0.left.equalTo(email)
            $0.centerY.equalTo(genderLbl)
            $0.size.equalTo(genderBtnSize)
        }
        manBtn.snp.makeConstraints {
            $0.left.equalTo(womanBtn.snp.right).offset(2)
            $0.centerY.equalTo(genderLbl)
            $0.size.equalTo(genderBtnSize)
        }
        noneBtn.snp.makeConstraints {
            $0.left.equalTo(manBtn.snp.right).offset(2)
            $0.centerY.equalTo(genderLbl)
            $0.size.equalTo(genderBtnSize)
        }
        subGenderLbl.snp.makeConstraints {
            $0.top.equalTo(manBtn.snp.bottom).offset(2)
            $0.left.equalTo(email)
        }
        ageLbl.snp.makeConstraints {
            $0.top.equalTo(subGenderLbl.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(margin2)
        }
        age.snp.makeConstraints {
            $0.left.equalTo(email)
            $0.centerY.equalTo(ageLbl)
            $0.size.equalTo(CGSize(width: 100, height: 40))
        }
        let skinTypeBtnSize = CGSize(width: 60, height: 40)
        skinTypeLbl.snp.makeConstraints {
            $0.centerY.equalTo(skinTypeBtns[0])
            $0.left.equalToSuperview().offset(margin2)
        }
        skinTypeBtns[0].snp.makeConstraints {
            $0.left.equalTo(email)
            $0.top.equalTo(age.snp.bottom).offset(30)
            $0.size.equalTo(skinTypeBtnSize)
        }
        for i in 1...3 {
            skinTypeBtns[i].snp.makeConstraints {
                $0.left.equalTo(skinTypeBtns[i-1].snp.right).offset(2)
                $0.centerY.equalTo(skinTypeLbl)
                $0.size.equalTo(skinTypeBtnSize)
            }
        }
        let skinWorriesBtnSize = CGSize(width: 50, height: 40)
        skinWorriesLbl.snp.makeConstraints {
            $0.centerY.equalTo(skinWorriesBtns[0])
            $0.left.equalToSuperview().offset(margin2)
        }
        skinWorriesBtns[0].snp.makeConstraints {
            $0.left.equalTo(email)
            $0.top.equalTo(skinTypeBtns[0].snp.bottom).offset(30)
            $0.size.equalTo(skinWorriesBtnSize)
        }
        for i in 1...4 {
            skinWorriesBtns[i].snp.makeConstraints {
                $0.left.equalTo(skinWorriesBtns[i-1].snp.right).offset(2)
                $0.centerY.equalTo(skinWorriesLbl)
                $0.size.equalTo(skinWorriesBtnSize)
                $0.bottom.equalToSuperview().offset(-50)
            }
        }
    }
  
    @objc func textFieldDidChange(_ textField: UITextField) {
        if age.text?.count == 10 {
            if !(common2.isValidDate(testStr: textField.text ?? "")) {
                parentViewController?.present(common2.alert(title: "", message: "형식을 맞춰서 입력해주세요."), animated: true)
            }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField.text?.count == 4) || (textField.text?.count == 7) {
            if !(string == "") {
                textField.text = (textField.text)! + "-"
            }
        }
    
        return !(textField.text!.count > 9 && (string.count ) > range.length)
      
    }
    @objc func touchSaveBtn(){
        common2.addGrayAlertView(view: self, alertView: alertView)
    }
    @objc func touchNoBtn(){
        print("여기")
        let viewWithTag = self.viewWithTag(100)
        viewWithTag?.removeFromSuperview()
    }
    func genderAllUnselect(){
        manBtn.backgroundColor = .clear
        manBtn.setTitleColor(common2.pointColor(), for: .normal)
        womanBtn.backgroundColor = UIColor.clear
        womanBtn.setTitleColor(common2.pointColor(), for: .normal)
        noneBtn.backgroundColor = .clear
        noneBtn.setTitleColor(common2.pointColor(), for: .normal)
        subGenderLbl.isHidden = true
    }
    @objc func touchManBtn(){
        if manBtn.backgroundColor != common2.pointColor() {
            genderAllUnselect()
            manBtn.backgroundColor = common2.pointColor()
            manBtn.setTitleColor(.white, for: .normal)
        }
    }
    @objc func touchWomanBtn(){
        if womanBtn.backgroundColor != common2.pointColor() {
            genderAllUnselect()
            womanBtn.backgroundColor = common2.pointColor()
            womanBtn.setTitleColor(.white, for: .normal)
        }
    }
    @objc func touchNoneBtn(){
        if noneBtn.backgroundColor != common2.pointColor() {
            genderAllUnselect()
            noneBtn.backgroundColor = common2.pointColor()
            noneBtn.setTitleColor(.white, for: .normal)
            subGenderLbl.isHidden = false
        }
    }
    func skinTypeAllUnselect(){
        for i in 0...skinTypeBtns.count - 1 {
            skinTypeBtns[i].backgroundColor = .clear
            skinTypeBtns[i].setTitleColor(common2.pointColor(), for: .normal)
        }
    }
    @objc func touchSkinTypeBtn(sender: UIButton){
        if sender.backgroundColor != common2.pointColor() {
            skinTypeAllUnselect()
            sender.backgroundColor = common2.pointColor()
            sender.setTitleColor(.white, for: .normal)
        }
    }
    @objc func touchSkinWorriesBtn(sender: UIButton){
        if sender.backgroundColor != common2.pointColor() {
            sender.backgroundColor = common2.pointColor()
            sender.setTitleColor(.white, for: .normal)
        }else {
            sender.backgroundColor = .clear
            sender.setTitleColor(common2.pointColor(), for: .normal)
        }
    }
   
//    if (textF)
}
