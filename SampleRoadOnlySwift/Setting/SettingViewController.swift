//
//  SettingViewController.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/11/17.
//
import Foundation
import UIKit
import NaverThirdPartyLogin

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
    func logoutFunc(){
        let alert = UIAlertController(title: "로그아웃을 하시겠습니까?", message: "", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "YES", style: .default){ action in
            UserDefaults.standard.set(false, forKey: "auto_login")
            UserDefaults.standard.removeObject(forKey: "kakao_token")
            UserDefaults.standard.removeObject(forKey: "naver_token")
            //네이버 로그아웃
            self.loginInstance?.requestDeleteToken()
            self.navigationController?.pushViewController(SplashViewController(), animated: false)
        }
        let noAction = UIAlertAction(title: "NO", style: .default)
        alert.addAction(okAction)
        alert.addAction(noAction)
        present(alert, animated: false, completion: nil)
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
        common2.sendRequest(url: "https://api.clayful.io/v1/customers/\(UserDefaults.standard.string(forKey: "customer_id")!)", method: "delete", params: [:], sender: "") { resultJson in
            self.deleteUserDB()
        }
    }
    func deleteUserDB(){
        common2.sendRequest(url: "http://110.165.17.124/sampleroad/db/sr_user_delete.php", method: "post", params: ["customer_id": UserDefaults.standard.string(forKey: "customer_id")!], sender:"" ) { resultJson in
            print("삭제됨")
            //네이버 로그아웃
            self.loginInstance?.requestDeleteToken()
            for key in UserDefaults.standard.dictionaryRepresentation().keys {
                        UserDefaults.standard.removeObject(forKey: key.description)
                    }
            self.navigationController?.pushViewController(SplashViewController(), animated: false)
        }
//        sr_user_delete
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
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if settingModel.settingArr[indexPath.row] == "로그아웃" {
            self.logoutFunc()
        }
        if settingModel.settingArr[indexPath.row] == "탈퇴하기" {
            self.deleteUserFunc()
        }
    }
}
