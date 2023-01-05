//
//  SettingViewController.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/11/17.
//
import Foundation
import UIKit
import NaverThirdPartyLogin
import Alamofire
import KakaoSDKUser
import KakaoSDKCommon

class SettingViewController: UIViewController {
    let settingModel = Setting()
    let settingView = SettingView()
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    override func loadView() { 
        super.loadView()
        view = settingView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setTarget()
        settingView.settingTableView.reloadData()
    }
    func setTarget(){
        settingView.topView.backBtn.addTarget(self, action: #selector(touchBackBtn), for: .touchUpInside)
    }
    func setTableView() {
        settingView.settingTableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.cellId)
        settingView.settingTableView.delegate = self
        settingView.settingTableView.dataSource = self
    }
    func goVersionView(){
        self.navigationController?.pushViewController(VersionViewController(), animated: true)
    }
    func logoutFunc(){
        let alert = UIAlertController(title: "로그아웃을 하시겠습니까?", message: "", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "YES", style: .default){ action in
            UserDefaults.standard.set(false, forKey: "auto_login")
            if UserDefaults.contains("kakao_token") || UserDefaults.contains("naver_token") {
                UserDefaults.standard.removeObject(forKey: "user_email")
            }
            UserDefaults.standard.removeObject(forKey: "kakao_token")
            UserDefaults.standard.removeObject(forKey: "naver_token")
            self.removeUserInfo()
            //네이버 로그아웃
            self.loginInstance?.requestDeleteToken()
            self.navigationController?.pushViewController(SplashViewController(), animated: false)
        }
        let noAction = UIAlertAction(title: "NO", style: .default)
        alert.addAction(okAction)
        alert.addAction(noAction)
        present(alert, animated: false, completion: nil)
    }
    func removeUserInfo(){
        UserDefaults.standard.removeObject(forKey: "order_user_info")
        UserDefaults.standard.removeObject(forKey: "auto_login")
        UserDefaults.standard.removeObject(forKey: "customer_id")
        UserDefaults.standard.removeObject(forKey: "user_mobile")
        UserDefaults.standard.removeObject(forKey: "user_name")
        UserDefaults.standard.removeObject(forKey: "user_gender")
        UserDefaults.standard.removeObject(forKey: "user_alias")
        UserDefaults.standard.removeObject(forKey: "user_birth")
        UserDefaults.standard.removeObject(forKey: "user_skin_type")
        UserDefaults.standard.removeObject(forKey: "user_skin_gomin")
        UserDefaults.standard.removeObject(forKey: "user_image")
        UserDefaults.standard.removeObject(forKey: "user_gender")
    }
    func deleteUserFunc(){
        let alert = UIAlertController(title: "회원탈퇴를 하시겠습니까?\n샘플로드의 모든 사용자 데이터가 삭제됩니다", message: "", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "YES", style: .default){ action in
            self.deleteUser()
        }
        let noAction = UIAlertAction(title: "NO", style: .default)
        alert.addAction(okAction)
        alert.addAction(noAction)
        present(alert, animated: false, completion: nil)
    }
    func deleteUser(){
        common2.sendRequest(url: "https://api.clayful.io/v1/customers/\(customerId2)", method: "delete", params: [:], sender: "") { resultJson in
            self.deleteUserDB()
        }
    }
    func deleteUserDB(){
        common2.sendRequest(url: "http://110.165.17.124/sampleroad/v1/user.php", method: "post", params: ["customer_id": customerId2, "delete": 1 ], sender:"" ) { [self] resultJson in
            print("삭제됨")
            //네이버 로그아웃
            self.loginInstance?.requestDeleteToken()
            if UserDefaults.contains("kakao_token") {
                disconnectKakaoService()
            }else {
                let settingCount = UserDefaults.standard.string(forKey: "setting-count")
                for key in UserDefaults.standard.dictionaryRepresentation().keys {
                            UserDefaults.standard.removeObject(forKey: key.description)
                        }
                UserDefaults.standard.set(settingCount, forKey: "setting-count")
                self.navigationController?.pushViewController(SplashViewController(), animated: true)
            }
        }
    }
    func disconnectKakaoService(){
        UserApi.shared.unlink {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("unlink() success.")
                let settingCount = UserDefaults.standard.string(forKey: "setting-count")
                for key in UserDefaults.standard.dictionaryRepresentation().keys {
                            UserDefaults.standard.removeObject(forKey: key.description)
                        }
                UserDefaults.standard.set(settingCount, forKey: "setting-count")
                self.navigationController?.pushViewController(SplashViewController(), animated: true)
            }
        }
    }
    @objc func touchBackBtn(){
        self.navigationController?.popViewController(animated: true)
    }
    

}
extension SettingViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingModel.settingArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SettingTableViewCell(style: SettingTableViewCell.CellStyle.default, reuseIdentifier: SettingTableViewCell.cellId)
        cell.selectionStyle = .none
        cell.tit.text = settingModel.settingArr[indexPath.row]
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if settingModel.settingArr[indexPath.row] == "로그아웃" {
            self.logoutFunc()
        }
        if settingModel.settingArr[indexPath.row] == "탈퇴하기" {
            self.deleteUserFunc()
        }
        if settingModel.settingArr[indexPath.row] == "버전정보" {
            self.goVersionView()
        }
    }
}
