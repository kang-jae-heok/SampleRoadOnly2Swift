//
//  NoticeViewController.swift
//  sampleroad
//
//  Created by NOTEGG on 2022/07/19.
//  Copyright © 2022 CNKANG. All rights reserved.
//

import UIKit

@objc class NoticeViewController: UIViewController {
    
    let screen = UIScreen.main.bounds

    let titleView = UIView()
    
    let titleLabel = UILabel()
    
    let tableView = UITableView()
    
    let margin:CGFloat = 24.0
    
    var scrY = CGFloat()
    
    var noticeList = [[String:Any]]()
    
    var selectIndex:Int = 0
   
    @objc let titleBackBtn: UIButton = {
        let backbtn = UIButton()
        backbtn.setImage(UIImage(named: "back_btn"), for: .normal)
        backbtn.contentMode = .scaleAspectFit
        return backbtn
    }()
    
    var noDataView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titleView)
        view.addSubview(tableView)
        titleViewFram()
        tableViewFram()
        self.tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        selectNoticeList(customerId: UserDefaults.standard.value(forKey: "customer_id") as! String)
        titleBackBtn.addTarget(self, action: #selector(touchBackBtn), for: .touchUpInside)

    }
    
    private func titleViewFram() {
        titleView.frame = CGRect(x: 0, y: 0, width: screen.width, height: Common.topHeight())
        titleView.backgroundColor = .white
        titleLabel.text = "알림함"
        titleLabel.font = Common.kFont(withSize: "bold", 20)
        titleLabel.textColor = Common.pointColor1()
        titleLabel.textAlignment = .center
        titleLabel.frame = CGRect(x: 0, y: titleView.frame.size.height - (50+(margin/2))  , width: screen.size.width, height: 50)
        titleView.addSubview(titleLabel)
        titleView.addSubview(titleBackBtn)
        titleBackBtn.frame = CGRect(x: margin, y: titleLabel.frame.origin.y, width: 50 , height: 50)
        titleBackBtn.contentHorizontalAlignment = .left
        titleBackBtn.addTarget(self, action: #selector(getter: titleBackBtn), for: .touchUpInside)
    }
    private func tableViewFram() {
//        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame = CGRect(x: margin , y: titleView.frame.size.height , width: screen.size.width - (margin * 2), height: screen.height - titleView.frame.size.height)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.rowHeight = 70
//        scrY = titleView.frame.origin.y + titleView.frame.size.height
        tableView.register(NoticeCell.self, forCellReuseIdentifier: NoticeCell.identifier
        
        )
      
    }
   
    // 알림함 온 시간 date
    @objc func selectNoticeList(customerId: String) {
        var params: [String:Any] = [:]
        params.updateValue(customerId, forKey: "customer_id")
        COMController.sendRequest("http://110.165.17.124/sampleroad/v1/alarm.php", params, self, #selector(selectNoticeListCallBack(result:)))
    }
    
    @objc func selectNoticeListCallBack(result :NSData) {
        let common = CommonSwift()
        noDataView.removeFromSuperview()
        noticeList = common.JsonToDicArray(data: result)!
        if (noticeList.count > 0) {
            tableView.reloadData()
        }else {
            noDataView = Common.nodataView(tableView.frame, "새 알림이 없습니다.")
            self.view.addSubview(noDataView)
        }
        

    }
    
    @objc func touchBackBtn(){
        self.navigationController?.popViewController(animated: true)
        Common.vibrate(1)
    
    }
    
//     알림 닫기
    @objc func closeNotice(alarm_id: String)  {
        var params1: [String:Any] = [:]
        params1.updateValue(customerId2, forKey: "customer_id")
        params1.updateValue(alarm_id, forKey: "alarm_id")
        params1.updateValue(1, forKey: "insert")
        common2.sendRequest(url: "http://110.165.17.124/sampleroad/v1/alarm.php", method: "post", params: params1, sender: "") {[self] resultJson in
            guard let resultDic = resultJson as? [String:Any],
                  let error = resultDic["error"] as? String
            else {return}
            if error == "1" {
                noticeList.remove(at: selectIndex)
                let indexPath = IndexPath(item: selectIndex, section: 0)
                tableView.deleteRows(at: [indexPath], with: .fade)

                noDataView.removeFromSuperview()
                if (noticeList.count > 0) {
                    tableView.reloadData()
                }else {
                    noDataView = Common.nodataView(tableView.frame, "새 알림이 없습니다.")
                    self.view.addSubview(noDataView)
                }
            }
        }
        
    }
}


// MARK: - TableView
extension NoticeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeList.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Common.vibrate(1)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return (screen.size.width - CGFloat((margin*2))) / 4 + 20.0
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NoticeCell.identifier, for: indexPath) as? NoticeCell
        
        cell?.selectionStyle = .none
        
        cell?.frame = CGRect(x: 0, y: 0, width: (tableView.frame.size.width), height: (cell?.frame.size.height)!)
        cell?.eventLabel.frame = CGRect(x: 0, y: 30, width: 90 , height: 30)
        
        var val: CGFloat = 0.0
        
        let selectNoticeListDic = noticeList[indexPath.row] as! [String:Any]
        let common = CommonSwift()
        
        let date = selectNoticeListDic["create_at"] as! String
        
        
        val = (cell?.dataLabel.font.pointSize)! + (cell?.descriptionLabel.font.pointSize)! + 4.0
        let dataMargin:CGFloat = 20
        cell?.dataLabel.frame = CGRect(x: dataMargin + (cell?.eventLabel.frame.origin.x)! + (cell?.eventLabel.frame.size.width)!, y: (cell?.eventLabel.frame.origin.y)! + (cell?.eventLabel.frame.height)! / 2 - (cell?.dataLabel.font.pointSize)! / 2, width: screen.width, height: (cell?.dataLabel.font.pointSize)!)
        //        cell?.dataLabel.text = checkTime
        //cell?.dataLabel.text = Common.calculate(convertDate!)
        
        cell?.dataLabel.text = common.getTimeDiff(s: date)
        //
        cell?.descriptionLabel.text = selectNoticeListDic["title"] as! String
        cell?.descriptionLabel.frame = CGRect(x: (cell?.eventLabel.frame.origin.x)!, y: (cell?.eventLabel.frame.origin.y)! / 3  + val + (cell?.eventLabel.frame.size.height)!,width: screen.width, height: (cell?.descriptionLabel.font.pointSize)!)
        
        
        
//        let close =
        
        //UI 버튼 imgSize
        let xImgSize:CGSize = CGSize(width: 50, height: 50)
        cell?.xImg.frame = CGRect(x: (tableView.frame.size.width) - (xImgSize.width), y: (cell?.dataLabel.frame.origin.y)!  + ((cell?.dataLabel.frame.size.height)!)/2 - 25, width: xImgSize.width, height: xImgSize.height)
        cell?.xImg.addTarget(self, action: #selector(buttonSelected), for: .touchUpInside)
        cell?.xImg.tag = indexPath.row
        
        
        
        
        //TableView 라인
        cell?.underLine.frame = CGRect(x: 0, y: (cell?.frame.size.height)! - 2, width: (cell?.frame.size.width)!, height: 2)
        cell?.underLine.backgroundColor = Common.lightGray()
        return cell!
    }
    @objc func buttonSelected(sender: UIButton){
        
        selectIndex = sender.tag as! Int
        let selectNoticeListDic = noticeList[selectIndex] as! [String:Any]
        closeNotice(alarm_id: selectNoticeListDic["alarm_id"] as! String)
        print(sender.tag)
        Common.vibrate(1)
    }
}


//@objc func cancelButtonAction(_ sender : UIButton)  {
////        let indexPath = IndexPath(item: 0, section: 0)
//    let point = sender.convert(CGPoint.zero, to: tableView)
//
//    guard let indexPath = UITableViewCell.indexPathForRow(at: point) else { return }
//
//    selectNoticeList.remove(at: indexPath.row)
//
//    tableView.deleteRows(at: [indexPath], with: .automatic)
//
////           didDelete()
//}
//        cell?.didDelete = { [weak self] in
//            guard let self = self else { return }
//
//
//
//            self.selectNoticeList.remove(at: indexPath.row)
//
////            let indexPath = IndexPath(item: 0, section: 0)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//
////            self.tableView.reloadData()
//        }
