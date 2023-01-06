//
//  LikeEventViewController.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/11/29.
//

import UIKit

class LikeEventViewController: UIViewController {
    let likeEventView = LikeEventView()
    var eventArr = [[String:Any]]()
    let customerId = UserDefaults.standard.string(forKey: "customer_id") ?? ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getData()
    }
    override func loadView() {
        super.loadView()
        view = likeEventView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setTarget()
        likeEventView.likeEventTableView.dataSource = self
        likeEventView.likeEventTableView.delegate = self
    }
    func setTarget(){
        likeEventView.topView.backBtn.addTarget(self, action: #selector(touchBackBtn), for: .touchUpInside)
    }
    func getData(){
        var params = [String:Any]()
        params = ["customer_id":customerId]
        common2.sendRequest(url: "http://110.165.17.124/sampleroad/v1/event.php", method: "post", params: params, sender: "") {[self] resultJson in
            guard let resultArr = resultJson as? [[String:Any]] else {return}
            self.eventArr = resultArr
            if eventArr.count == 0 {
                likeEventView.noneView.isHidden = false
            }else {
                likeEventView.noneView.isHidden = true
            }
            self.likeEventView.likeEventTableView.reloadData()
        }
    }
    func toDate(stringDate: String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let date = dateFormatter.date(from: stringDate)
        return date!
    }
    @objc func touchBackBtn(){
        self.navigationController?.popViewController(animated: true)
    }
}
extension LikeEventViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (screenBounds2.width - 54) * 3/5 + 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let initDict = eventArr[indexPath.row]
        let EventDetailSViewController = EventDetailSViewController(initDic: initDict)
        print("딕셔너리 ")
        print(initDict)
        self.navigationController?.pushViewController(EventDetailSViewController, animated: true)
        Common.vibrate(1)
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:CustomCell? = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomCell
        if cell == nil {
            cell = CustomCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
            cell?.selectionStyle = .none
        }
        for view in cell!.subviews {
            view.removeFromSuperview()
        }
        cell?.selectionStyle = .none
        let imageView = UIImageView()
        let peopleLabel = UILabel()
        let timeLabel = UILabel()
        let eventDic = eventArr[indexPath.row]
        print("후기")
        print(eventDic)
        
        guard let limitPeople =  eventDic["event_limit"] as? String else {return cell!}
        guard let stringStartDate = eventDic["event_regist"] as? String else {return cell!}
        guard let stringEndDate = eventDic["event_end"] as? String else {return cell!}
        let date2 = Calendar.current.date(byAdding: .hour, value: 9, to: Date())
        
        let startDate = date2
        let endDate = toDate(stringDate: stringEndDate)
        
        let useTime = Int(endDate.timeIntervalSince(startDate!))
        let minute = useTime/60
        let dayLabel = minute/1440
        let hourLabel = (minute % 1440)/60
        let minuteLabel = ((minute % 1440) % 60) % 60
        
        
        print(hourLabel)
        print(minuteLabel)
        guard let img = eventDic["event_image"] as? String else {return cell!}
        let imgUrl = "http://110.165.17.124/sampleroad/images/event_thumbnail/\(img)"
        let url = URL(string: imgUrl)
        
        imageView.backgroundColor = UIColor.lightGray
        imageView.frame = CGRect(x: 0, y: 0, width: screenBounds2.width, height: (cell?.frame.size.height)! - 40)
        
        if eventDic["event_image"] != nil {
            let common = CommonSwift()
            common.setImageUrl(url: imgUrl, imageView: imageView)
        }
        
        peopleLabel.text = "모집인원 \(limitPeople)명"
        peopleLabel.font = Common.kFont(withSize: "bold", 13)
        peopleLabel.frame = CGRect(x: 0, y: (cell?.frame.size.height)! - 20 - peopleLabel.font.pointSize/2, width: 100, height: peopleLabel.font.pointSize)
        
        timeLabel.text = "남은시간 \(dayLabel)일  \(hourLabel)시간 \(minuteLabel)분"
        timeLabel.textAlignment = .right
        timeLabel.textColor = Common.pointColor1()
        timeLabel.font = Common.kFont(withSize: "bold", 16)
        
        
        
        let searchString = "시간"
        let entireString =  "남은시간 \(dayLabel)일  \(hourLabel)시간 \(minuteLabel)분"
        
        
        let attrStr = NSMutableAttributedString(string: entireString)
        let entireLength = entireString.count
        var range = NSRange(location: 0, length: entireLength)
        var rangeArr = [NSRange]()
        while (range.location != NSNotFound) {
            range = (attrStr.string as NSString).range(of: searchString, options: .caseInsensitive, range: range)
            rangeArr.append(range)
            if (range.location != NSNotFound){
                range = NSRange(location: range.location + range.length, length: entireString.count - (range.location + range.length))
            }
        }
        rangeArr.forEach{ (range) in
            attrStr.addAttribute(.foregroundColor, value: Common.color(withHexString: "#6f6f6f"), range: range)
            attrStr.addAttribute(.font, value: Common.kFont(withSize: "Regular", 10), range: range)
        }
        
        
        attrStr.addAttribute(.foregroundColor, value: Common.color(withHexString: "#6f6f6f"), range: (timeLabel.text! as NSString).range(of: "일"))
        attrStr.addAttribute(.font, value: Common.kFont(withSize: "Regular", 10), range: (timeLabel.text! as NSString).range(of: "일"))
        
        attrStr.addAttribute(.foregroundColor, value: Common.color(withHexString: "#6f6f6f"), range: (timeLabel.text! as NSString).range(of: "분"))
        attrStr.addAttribute(.font, value: Common.kFont(withSize: "Regular", 10), range: (timeLabel.text! as NSString).range(of: "분"))
        
        attrStr.addAttribute(.foregroundColor, value: Common.color(withHexString: "#6f6f6f"), range: (timeLabel.text! as NSString).range(of: "남은"))
        attrStr.addAttribute(.font, value: Common.kFont(withSize: "Regular", 10), range: (timeLabel.text! as NSString).range(of: "남은"))
        timeLabel.attributedText = attrStr
        
        timeLabel.frame = CGRect(x: screenBounds2.width - 227 - margin2, y: (cell?.frame.size.height)! - 20 - (timeLabel.font.pointSize + 10)/2, width: 200, height: timeLabel.font.pointSize + 10)
        
        
        
        
        cell?.addSubview(imageView)
        cell?.addSubview(peopleLabel)
        cell?.addSubview(timeLabel)
        cell?.preservesSuperviewLayoutMargins = false
        cell?.separatorInset = UIEdgeInsets.zero
        cell?.layoutMargins = UIEdgeInsets.zero
        
        
        return cell!
    }
    
    
}
