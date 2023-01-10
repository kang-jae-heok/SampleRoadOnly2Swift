//
//  ProductImageViewController.swift
//  sampleroad
//
//  Created by NOTEGG on 2022/07/19.
//  Copyright © 2022 CNKANG. All rights reserved.
//

import UIKit

@objc class ProductImageViewController: UIViewController {

    
    let mainView = UIView()
    let scrollView = UIScrollView()
    var screenRect = CGRect()
    var imgArr = [String]()
    var imgY = CGFloat()
    var index = 0
    var imgUrl  = String()
    let common = CommonSwift()
    //let imageView = UIImageView()
   
    @objc init(screenRect: CGRect, imgArr: [String]) {
        self.screenRect = screenRect
        self.imgArr = imgArr
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        mainView.frame = CGRect(x: 0, y: 0, width: screenRect.width, height: screenRect.height)
        scrollView.frame = CGRect(x: 0, y: 0, width: screenRect.width, height: screenRect.height)
        print(imgArr)
    
        view.addSubview(mainView)
        mainView.addSubview(scrollView)
            
        imgUrl = imgArr[index]
        print("이미지 배열 ")
        print(imgUrl)
        let encoded = imgUrl.description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        downloadImage(from: encoded!, tag: index)
       
    }
    
    func downloadImage(from url: String, tag: Int) {
        print("Download Started")
        
        let imageView = UIImageView()
        let cacheKey = NSString(string: url) // 캐시에 사용될 Key 값
        
    
            print("not")
            DispatchQueue.global(qos: .background).async { [self] in
                if let imageUrl = URL(string: url) {
                    URLSession.shared.dataTask(with: imageUrl) {  (data, res, err) in
                        if let _ = err {
                            DispatchQueue.main.sync { [self] in
                                imageView.image = UIImage()
                            }
                            return
                        }
                        DispatchQueue.main.sync { [self] in
                            if let data = data, let image = UIImage(data: data) {
                                ImageCacheManager.share.setObject(image, forKey: cacheKey) // 다운로드된 이미지를 캐시에 저장
                                imageView.image = image
                                let imgRatio = (imageView.image?.size.width)!/(screenRect.width)
                                let imgHeight = (imageView.image?.size.height)! / imgRatio
                                imageView.tag = tag
                                scrollView.addSubview(imageView)
                                imageView.frame = CGRect(x: 0, y: imgY , width: screenRect.width , height: imgHeight)
                               
                                imgY += imgHeight
                                scrollView.contentSize = CGSize(width: screenRect.width , height: imgY  + 50)
                                
                                index += 1
                          
                                if index <= imgArr.count - 1 {
                                    imgUrl = imgArr[index]
                                    let encoded = imgUrl.description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                                    downloadImage(from: encoded!, tag: index)
                                }

                            }
                        }
                    }.resume()
                }
            
            }
        }
        
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
