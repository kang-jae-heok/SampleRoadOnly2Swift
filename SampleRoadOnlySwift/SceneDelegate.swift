//
//  SceneDelegate.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/09/20.
//

import UIKit
import KakaoSDKAuth
import NaverThirdPartyLogin
import FacebookCore


@objc class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    public var window: UIWindow?
    public var navController = UINavigationController()
    let common = CommonS()
    let commonObjc = Common()
    var adminDic = [String:Any]()
    var mainViewController = UIViewController()
    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        userDefaultsClear()
        checkOrder()
        getAdmin {
            UserDefaults.standard.set("https://service.iamport.kr/payments/success?success=", forKey: "PAY_SUCCESS_URL")
            UserDefaults.standard.set("https://service.iamport.kr/payments/fail?success=", forKey: "PAY_FAILED_URL")
            UserDefaults.standard.set("https://service.iamport.kr/payments/vbank?imp_uid=", forKey: "VBANK_SUCCESS_URL")
        
            UserDefaults.standard.set("http://110.165.17.124/sampleroad/", forKey: "SERVER_URL")
            UserDefaults.standard.set(nil, forKey: "sample_order")
            self.window = UIWindow(windowScene: windowScene)
            self.mainViewController = SplashViewController()
            self.navController = UINavigationController(rootViewController: self.mainViewController)
            self.navController.setNavigationBarHidden(true, animated: false)
            self.window?.rootViewController = self.navController // 시작을 위에서 만든 내비게이션 컨트롤러로 해주면 끝!
            self.window?.makeKeyAndVisible()
        }
   
        
       
         // 내비게이션 컨트롤러에 처음으로 보여질 화면을 rootView로 지정해주고!
        }
  

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
            
            
            if let url = URLContexts.first?.url {
                
                ApplicationDelegate.shared.application(
                    UIApplication.shared,
                    open: url,
                    sourceApplication: nil,
                    annotation: [UIApplication.OpenURLOptionsKey.annotation]
                )
                
                NSLog("openURLContexts url  :   %@", url.absoluteString);
                print(url)
                var isNaver = true
                if (AuthApi.isKakaoTalkLoginUrl(url)) {
                    isNaver = false
                    _ = AuthController.handleOpenUrl(url: url)
                }

                if url.query != nil {
                    
                    let dic = Common.parseQueryString(url.query!)
                    print("application openURL:(NSURL *)url dic  :  \(dic)")
        
                    
                    if dic["scope"] != nil {
                        isNaver = false
                        guard let scope = dic["scope"] as? String else {return}
                        if scope == "reset-password" {
                            UserDefaults.standard.set(dic["secret"], forKey: "reset-secret")
                            UserDefaults.standard.set(dic["customer"],forKey: "reset-customer")
                            
                            navController.pushViewController(ResetPassViewController(), animated: true)
                        }
                    }
                    if dic["product"] != nil {
                        isNaver = false
                        UserDefaults.standard.set(dic["product"], forKey: "share-product")
                        UserDefaults.standard.synchronize()
                        print("아아")
                        common.sendRequest(url: "https://api.clayful.io/v1/products/\(dic["product"] ?? "")", method: "get", params: [:], sender: "") { resultJson in
                            guard let resultDic = resultJson as? [String:Any] else {return}
                            UserDefaults.standard.removeObject(forKey: "share-product")
                            self.navController.pushViewController(DetailProductViewController(productDic: resultDic), animated: true)
                        }
                    }

                    if url.absoluteString.contains("event") {
                        isNaver = false
                        let convertURL = url.absoluteString.components(separatedBy: "=")
                        let event = convertURL.last
                       
                        common.sendRequest(url: "http://110.165.17.124/sampleroad/v1/event.php", method: "post", params: ["event_id": event ?? "", "customer_id":  UserDefaults.standard.string(forKey: "customer_id") ?? ""], sender: "") { resultJson in
                            guard let resultDic = resultJson as? [String:Any],
                                  let event = resultDic["event"] as? [String:Any]
                            else {return}
                            print("#######resultDic")
                            UserDefaults.standard.removeObject(forKey: "share-event")
                            self.navController.pushViewController(EventDetailSViewController(initDic: event), animated: true)
                        }
                    }
                    
                }else {
                    

                }
                
                if isNaver {
                    NaverThirdPartyLoginConnection
                      .getSharedInstance()?
                      .receiveAccessToken(URLContexts.first?.url)
                }
                
            }

            
        }
    
    @objc func returnNavi() -> UINavigationController {
        return self.navController
    }
    //추후에 삭제해야됨 
    func userDefaultsClear(){
        if !UserDefaults.contains("isFirstActive") {
            for key in UserDefaults.standard.dictionaryRepresentation().keys {
                        UserDefaults.standard.removeObject(forKey: key.description)
                    }
            UserDefaults.standard.set(false, forKey: "isFirstActive")
        }
    }
    //주문중에서 나갔을때
    func checkOrder(){
        if UserDefaults.contains("merchant_uid") {
            var params = [String:Any]()
            let orderId = UserDefaults.standard.string(forKey: "merchant_uid") ?? ""
            guard let byString = UserDefaults.standard.string(forKey: "pay_callback") else {return}
            var by = String()
            if byString == "failed-customer" {
                by = "customer"
            }else {
                by = "store"
            }
            params.updateValue(by, forKey: "by")
            params.updateValue("", forKey: "reason")
            UserDefaults.standard.removeObject(forKey: "pay_callback")
            common.sendRequest(url: "https://api.clayful.io/v1/orders/\(orderId)/cancellation", method: "post", params: params, sender: "") { resultJson in
                print(resultJson)
                UserDefaults.standard.removeObject(forKey: "merchant_uid")
                UserDefaults.standard.removeObject(forKey: "coupon")
            }
        }
    }
    func getAdmin( completion: @escaping () -> Void){
        common.sendRequest(url: "http://110.165.17.124/sampleroad/v1/setting.php", method: "post", params: [:], sender: "") { resultJson in
            guard let resultDic = resultJson as? [String:Any],
                  let admin = resultDic["admin"] as? [String:Any],
                  let count = resultDic["count"] as? String,
                  let banner = resultDic["banner"] as? [[String:Any]],
                  let categories = resultDic["categories"] as? String,
                  let newestVersion = admin["APP_VERSION"] as? String
             else {return}
            UserDefaults.standard.set(count, forKey: "setting-count")
            UserDefaults.standard.set(banner, forKey: "setting-banner")
            UserDefaults.standard.set(categories, forKey: "setting-categories")
            guard let localVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
                return
            }
            UserDefaults.standard.set(localVersion, forKey: "current_version")
            UserDefaults.standard.set(newestVersion, forKey: "newest_version")
//            guard let verCheck = self.adminDic["REVIEW_VERSION"]!
            if admin["REVIEW_VERSION"] is NSNull {
                UserDefaults.standard.set(true, forKey: "PRDC_MODE")
                print("유저 버전")
                print(UserDefaults.standard.bool(forKey: "PRDC_MODE"))
            }else{
                if admin["REVIEW_VERSION"] as! String == localVersion {
                    print("리뷰 버전")
                    UserDefaults.standard.set(false, forKey: "PRDC_MODE")
                }else {
                    print("유저 버전")
                    UserDefaults.standard.set(true, forKey: "PRDC_MODE")
                }
                print(UserDefaults.standard.bool(forKey: "PRDC_MODE"))
               
            }
            if admin["BILLING_TEST_I"] as! String == "1" {
                UserDefaults.standard.set(true, forKey: "BILLING_TEST")
            }else {
                UserDefaults.standard.set(false, forKey: "BILLING_TEST")
            }
            completion()
        }
    }
}


