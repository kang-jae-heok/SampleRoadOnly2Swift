//
//  EventSViewController.swift
//  sampleroad
//
//  Created by NOTEGG on 2022/07/14.
//  Copyright © 2022 CNKANG. All rights reserved.
//

import UIKit
@objc class EventSViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    
    var navi: UINavigationController?
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        return tableView
    }()
    var eventArr = [[String:Any]]()
    var vc = UIViewController()
    
    var screenRect  =  CGRect()
    
    
    @objc init(screenRect: CGRect) {
        self.screenRect = screenRect
        //        self.vc = sender
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var screenBounds = CGRect()
    //    let screenBounds = UIScreen.main.bounds
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        screenBounds = self.screenRect
        tableView.frame =  CGRect(x: margin2, y: 0, width: screenBounds.width - margin2 * 2, height: screenBounds.height)
        tableView.separatorStyle = .none
        selectOrder()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (screenBounds.width - 54) * 3/5 + 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let initDict = eventArr[indexPath.row]
        let EventDetailSViewController = EventDetailSViewController(initDic: initDict)
        print("딕셔너리 ")
        print(initDict)
        navi?.pushViewController(EventDetailSViewController, animated: true)
        Common.vibrate(1)
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:CustomCell? = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomCell
        if cell == nil {
            cell = CustomCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
            cell?.selectionStyle = .none
        }
        cell?.selectionStyle = .none
        for view in cell!.subviews {
            view.removeFromSuperview()
        }
        let imageView = UIImageView()
        let peopleLabel = UILabel()
        let timeLabel = UILabel()
        let eventDic = eventArr[indexPath.row] as! [String:Any]
        print("후기")
        print(eventDic)
        
        let limitPeople =  eventDic["event_limit"] as? String
        let stringStartDate = eventDic["event_regist"] as! String
        let stringEndDate = eventDic["event_end"] as! String
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
        let img = eventDic["event_image"] as! String
        let imgUrl = "http://110.165.17.124/sampleroad/images/event_thumbnail/\(img)"
        let url = URL(string: imgUrl)
        
        imageView.backgroundColor = UIColor.lightGray
        imageView.frame = CGRect(x: 0, y: 0, width: screenBounds.width - margin2 * 2, height: (cell?.frame.size.height)! - 40)
        
        if eventDic["event_image"] != nil {
            let common = CommonSwift()
            common.setImageUrl(url: imgUrl, imageView: imageView)
        }
        
        peopleLabel.text = "모집인원 \(limitPeople!)명"
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
        
        
        
        
        
        
        
        
        
        timeLabel.frame = CGRect(x: screenBounds.width - 227 - margin2, y: (cell?.frame.size.height)! - 20 - (timeLabel.font.pointSize + 10)/2, width: 200, height: timeLabel.font.pointSize + 10)
        
        
        
        cell?.addSubview(imageView)
        cell?.addSubview(peopleLabel)
        cell?.addSubview(timeLabel)
        
        return cell!
    }
    
    
    
    @objc func selectOrder() {
        COMController.sendRequestGet("http://110.165.17.124/sampleroad/v1/event.php", nil, self, #selector(selectOrderCallback(result:)))
    }
    
    
    
    @objc func selectOrderCallback(result :NSData) {
        let common = CommonSwift()
        print("여기")
        NSLog("selectOrderCallback : %@", result);
        let arr:[[String:Any]] = common.JsonToDicArray(data: result) ?? []
        eventArr = arr
        print("selectOrderCallback    tempArray  : " + String(describing: arr));
        tableView.reloadData()
    }
    
    @objc func toDate(stringDate: String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let date = dateFormatter.date(from: stringDate)
        return date!
    }
}
