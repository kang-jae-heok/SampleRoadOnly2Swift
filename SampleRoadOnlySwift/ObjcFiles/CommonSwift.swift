//
//  CommonS.swift
//  Test02
//
//  Created by eitu-Jerry on 2022/06/22.
//

import Foundation
import UIKit


class ImageCacheManager {
    static let share = NSCache<NSString, UIImage>()
    private init () {}
}
class CommonSwift {
    
    func JsonToDictionary(data: NSData) -> [String: Any]? {
        let dataString = String(decoding: data, as: UTF8.self)
        if let result = dataString.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: result, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func JsonToDicArray(data: NSData) -> [[String: Any]]? {
        let dataString = String(decoding: data, as: UTF8.self)
        if let result = dataString.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: result, options: []) as? [[String: Any]]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    func getTimeDiff(s: String) -> String {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
         dateFormatter.timeZone = TimeZone(identifier: "UTC")
         if let date = dateFormatter.date(from: s) {
             let date2 = Calendar.current.date(byAdding: .hour, value: 9, to: Date())
             print(String(describing: date))
             print(String(describing: date2))
             
             if date2 == nil {
                 return "currentTimeError"
             }
             else {
                 var diff:Int = Int(date2!.timeIntervalSince(date))
                 print(diff)
                 
                 let one_minute:Int = 60
                 let one_hour:Int = one_minute * 60
                 let one_day:Int = one_hour * 24
                 
                 let day:Int = diff / one_day
                 diff -= one_day * day
                 
                 let hour:Int = diff / one_hour
                 diff -= one_hour * hour
                 
                 let minute:Int = diff / one_minute
                 diff -= one_minute * minute
                 
                 var dateString:String = ""
                 
                 if day > 0 {
                     dateString = String(day) + "일전"
                 }
                 else {
                     if hour > 0 {
                         dateString = String(hour) + "시간전"
                     }
                     else {
                         dateString = String(minute) + "분전"
                     }
                 }
                 return dateString
             }
         }
         else {
             return "dateFormatError"
         }
     }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
         URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
     }
    
    func setImageUrl(url: String, imageView: UIImageView){
        let cacheKey = NSString(string: url) // 캐시에 사용될 Key 값
        
        if let cachedImage = ImageCacheManager.share.object(forKey: cacheKey) { // 해당 Key 에 캐시이미지가 저장되어 있으면 이미지를 사용
            print("cachedImage")
            imageView.image = cachedImage
            return
        }
        print("not")
        DispatchQueue.global(qos: .background).async {
            if let imageUrl = URL(string: url) {
                URLSession.shared.dataTask(with: imageUrl) { (data, res, err) in
                    if let _ = err {
                        DispatchQueue.main.async { [self] in
                            imageView.image = UIImage()
                        }
                        return
                    }
                    DispatchQueue.main.async { [self] in
                        if let data = data, let image = UIImage(data: data) {
                            ImageCacheManager.share.setObject(image, forKey: cacheKey) // 다운로드된 이미지를 캐시에 저장
                            imageView.image = image
                        }
                    }
                }.resume()
            }
        }
    }
    
    func getTime(time: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        print("ㅔㅔㅔㅔ")
      
        let date = dateFormatter.date(from: time)
        print(time)
        print(date)
        let date2 = Calendar.current.date(byAdding: .hour, value: 9, to: date!)
        let date3 = dateFormatter.string(from: date2!)
        return date3
    }
}
