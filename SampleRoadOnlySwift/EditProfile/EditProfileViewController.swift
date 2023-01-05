//
//  EditProfileViewController.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/11/15.
//

import UIKit
import PhotosUI
class EditProfileViewController: UIViewController {
    let editProfileView = EditProfileView()
    let imagePicker = UIImagePickerController()
    var imgId = String()
    var imgUrl = String()
    var checkBool = Bool()
    var checkImgChange = Bool()
    
    override func loadView() {
        super.loadView()
        view = editProfileView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
        editProfileView.nameTextField.delegate = self
        imgUrl = UserDefaults.standard.string(forKey: "user_image") ?? ""
        checkBool = true
    }
    func setTarget(){
        editProfileView.topView.backBtn.addTarget(self, action: #selector(touchBackBtn), for: .touchUpInside)
        editProfileView.nameDuplicateCheckBtn.addTarget(self, action: #selector(touchCheckDuplicateBtn), for: .touchUpInside)
        editProfileView.yesBtn.addTarget(self, action: #selector(touchYesBtn), for: .touchUpInside)
        editProfileView.profileBtn.addTarget(self, action: #selector(touchProfileBtn), for: .touchUpInside)
        editProfileView.editProfileBtn.addTarget(self, action: #selector(touchProfileBtn), for: .touchUpInside)
    }
   
    @objc func touchBackBtn(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func touchYesBtn(){
        var params = [String:Any]()
        var params2 = [String:Any]()
        guard var nickText = editProfileView.nameTextField.text else { return }
        guard var birthText = editProfileView.age.text else { return }
        if nickText == "" {
            nickText = editProfileView.nameTextField.placeholder ?? ""
        }
        if birthText == "" {
            birthText = editProfileView.age.placeholder ?? ""
        }
        
        
        guard let customerId = UserDefaults.standard.string(forKey: "customer_id") else {return}
        var skinType = String()
        var skinGomin = String()
        var gender = String()
        var skinGominArr = [String]()
        for i in 0...editProfileView.skinTypeBtns.count - 1 {
            if editProfileView.skinTypeBtns[i].backgroundColor == common2.pointColor(){
                skinType = editProfileView.skinTypeBtns[i].titleLabel?.text ?? ""
                print(skinType)
            }
        }
    
        for i in 0...editProfileView.skinWorriesBtns.count - 1 {
            if editProfileView.skinWorriesBtns[i].backgroundColor == common2.pointColor() {
                skinGomin += "," + (editProfileView.skinWorriesBtns[i].titleLabel?.text ?? "")
                skinGominArr.append(editProfileView.skinWorriesBtns[i].titleLabel?.text ?? "")
            }
        }
       
        if skinGomin.count != 0 {
            skinGomin.remove(at: skinGomin.startIndex)
        }
        print("스킨타입")
        print(skinGomin)
        print(nickText)
        params.updateValue(1, forKey: "update")
        params.updateValue(nickText, forKey: "nick")
        params.updateValue(customerId, forKey: "customer_id")
        params.updateValue(skinType, forKey: "skin_type")
        params.updateValue(skinGomin, forKey: "skin_gomin")
        params2.updateValue(nickText, forKey: "alias")
        let nameDic = ["full": nickText]
        params.updateValue(nickText, forKey: "name")
        if editProfileView.manBtn.backgroundColor == common2.pointColor() {
            gender = "male"
            params2.updateValue(gender, forKey: "gender")
        }else if editProfileView.womanBtn.backgroundColor == common2.pointColor() {
            gender = "female"
            params2.updateValue(gender, forKey: "gender")
        }else {
            gender = "null"
            params2.updateValue(gender, forKey: "gender")
            
        }
        if common2.isValidDate(testStr: editProfileView.age.text ?? "") {
            params2.updateValue( common2.stringToDate2(string: birthText), forKey: "birthdate")
        }
        if checkImgChange {
            params2.updateValue(imgId, forKey: "avatar")
        }
       
       
        
        if checkBool {
            common2.sendRequest(url: "http://110.165.17.124/sampleroad/v1/user.php", method: "post", params: params, sender: "") { [self] resultJson in
                guard let resultDic = resultJson as? [String:Any] else {return}
                print(resultDic)
                print(resultDic["error"])
                guard let errorCode = resultDic["error"] as? String else {return}
                if errorCode == "1" {
                    if common2.isValidDate(testStr: birthText) {
                        self.common2.userUpdateWithNull(customerId: customerId, params: params2, sender: self) { [self] resultJson in
                            guard let result = resultJson as? [String:Any] else {return}
                            if result["error"] == nil {
                                UserDefaults.standard.set(gender, forKey: "user_gender")
                                UserDefaults.standard.set(nickText, forKey: "user_alias")
                                UserDefaults.standard.set(birthText,forKey: "user_birth")
                                UserDefaults.standard.set(skinType, forKey: "user_skin_type")
                                UserDefaults.standard.set(skinGominArr, forKey: "user_skin_gomin")
                                UserDefaults.standard.set(imgUrl, forKey: "user_image")
                                UserDefaults.standard.set(nickText, forKey: "user_name")
                                self.navigationController?.popViewController(animated: true)
                                navigationController?.present(self.common2.alert(title: "", message: "프로필 수정이 완료되었습니다"), animated: true)
                            }else {
                                self.present(self.common2.alert(title: "", message: "잠시후 다시 시작해주세요"), animated: true)
                                closeAlert()
                            }
                        }
                        
                    }else {
                        self.present(self.common2.alert(title: "", message: "생년월일을 형식에 맞춰서 작성해주세요"), animated: true)
                        closeAlert()
                    }

                }else if errorCode == "2" {
                    self.present(self.common2.alert(title: "", message: "닉네임이 중복되었습니다"), animated: true)
                    closeAlert()
                }else {
                    self.present(self.common2.alert(title: "", message: "다시 시도해주세요"), animated: true)
                    closeAlert()
                }
            }
        } else {
            present(common2.alert(title: "", message: "중복체크 해주세요"), animated: true)
            closeAlert()
        }
    }
    func convertToDictionary(data: Data) -> [String: Any]? {
        
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        
        return nil
    }
  
    
    
    func closeAlert(){
        let viewWithTag = editProfileView.viewWithTag(100)
        viewWithTag?.removeFromSuperview()
    }
    
    @objc func touchCheckDuplicateBtn(){
        guard let nickText = editProfileView.nameTextField.text else { return }
        if nickText.count < 2 {
            present(common2.alert(title: "", message: "2글자 이상 입력해주세요"), animated: true)
        }else {
            common2.checkDuplicateNick(vc: self, nick: nickText) {[self] result in
                if result {
                    checkBool = true
                }else {
                    checkBool = false
                }
            }
        }
    }

    @objc func touchProfileBtn(){
        if #available(iOS 14.0, *) {
            var configuration = PHPickerConfiguration()
            configuration.filter = .any(of: [.images])
            // 개수
            configuration.selectionLimit = 1
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }else {
            self.present(self.imagePicker, animated: true)
            self.imagePicker.sourceType = .photoLibrary // 앨범에서 가져옴
            self.imagePicker.delegate = self // picker delegate
        }
        Common.vibrate(1)
    }
    @objc func uploadImage(image :UIImage) {
        var param = [String : Any]()
        param.updateValue("Customer", forKey: "model")
        param.updateValue("avatar", forKey: "application")
        
        COMController.sendRequestMultipartClayFul(param, image, "test", self, #selector(uploadImageCallback(result:)))
    }
    
    @objc func uploadImageCallback(result :NSData) {
        let common = CommonSwift()
        
        guard let resultDic = common.JsonToDictionary(data: result) else {return}
        guard let id = resultDic["_id"] as? String else {return}
        guard let url = resultDic["url"] as? String else {return}
        imgId = id
        //        UserDefaults.standard.set(url, forKey: "user_image")
        imgUrl = url
        checkImgChange  = true
        setProfileImg()
        NSLog("uploadImageCallback : %@", resultDic);
    }
    func setProfileImg(){
        common2.setButtonImageUrl(url: imgUrl, button: editProfileView.profileBtn)
    }
}
extension EditProfileViewController: UIImagePickerControllerDelegate,PHPickerViewControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    @available(iOS 14, *)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        if results.count != 0{
            for i in 0...results.count - 1{
                if results[i].itemProvider.canLoadObject(ofClass: UIImage.self) {
                    results[i].itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                        DispatchQueue.main.sync {
                            guard let profileImage = image as? UIImage else {return}
                            self.uploadImage(image: profileImage)
                        }
                    }
                }
            }
        }else{
            dismiss(animated: false)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var newImage: UIImage? = nil // update 할 이미지
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage // 수정된 이미지가 있을 경우
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage // 원본 이미지가 있을 경우
        }
        uploadImage(image: newImage!)
        picker.dismiss(animated: true, completion: nil) // picker를 닫아줌
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        common2.checkMaxLength(textField: editProfileView.nameTextField, maxLength: 12)
        checkBool = false
    }
}
