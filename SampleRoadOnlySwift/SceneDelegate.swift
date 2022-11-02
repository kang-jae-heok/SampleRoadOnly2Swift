//
//  SceneDelegate.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/09/20.
//

import UIKit
import KakaoSDKAuth
import NaverThirdPartyLogin


@objc class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    public var window: UIWindow?
    public var navController = UINavigationController()
    let common = CommonS()
    let commonObjc = Common()
    var adminDic = [String:Any]()
    var mainViewController = UIViewController()
    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        getAdmin()
        UserDefaults.standard.set("https://service.iamport.kr/payments/success?success=", forKey: "PAY_SUCCESS_URL")
        UserDefaults.standard.set("https://service.iamport.kr/payments/fail?success=", forKey: "PAY_FAILED_URL")
        UserDefaults.standard.set("http://110.165.17.124/sampleroad/", forKey: "SERVER_URL")
        window = UIWindow(windowScene: windowScene)
        mainViewController = SplashViewController()
        navController = UINavigationController(rootViewController: mainViewController)
        navController.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = self.navController // 시작을 위에서 만든 내비게이션 컨트롤러로 해주면 끝!
        window?.makeKeyAndVisible()
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
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
            
            let dic = Common.parseQueryString(url.query!)
            print("application openURL:(NSURL *)url dic  :  \(dic)")
            if dic["scope"] != nil {
                if dic["scope"] as! String == "reset-password" {
                    UserDefaults.standard.set(dic["reset-password"], forKey: "scope")
                    UserDefaults.standard.set(dic["secret"], forKey: "secret")
                    UserDefaults.standard.synchronize()
                }
            }

            if dic["product"] != nil {
                UserDefaults.standard.set(dic["product"], forKey: "share-product")
                UserDefaults.standard.synchronize()
            }

            if dic["event"] != nil {
                UserDefaults.standard.set(dic["event"], forKey: "share-event")
                UserDefaults.standard.synchronize()
            }
        }
        NaverThirdPartyLoginConnection
          .getSharedInstance()?
          .receiveAccessToken(URLContexts.first?.url)
      
        
//        NSDictionary* dic = [self parseQueryString:[url query]];
//            NSLog(@"application openURL:(NSURL *)url dic  :  %@",dic);
//            if ([dic valueForKey:@"scope"]) {
//                if ([[dic valueForKey:@"scope"] isEqualToString:@"reset-password"]) {
//                    [[NSUserDefaults standardUserDefaults] setObject:[dic valueForKey:@"reset-password"] forKey:@"scope"];
//                    [[NSUserDefaults standardUserDefaults] setObject:[dic valueForKey:@"secret"] forKey:@"secret"];
//                    [[NSUserDefaults standardUserDefaults] synchronize];
//                }
//
//            }
//
//            if ([dic valueForKey:@"product"]) {
//                [[NSUserDefaults standardUserDefaults] setObject:[dic valueForKey:@"product"] forKey:@"share-product"];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//            }
//
//            if ([dic valueForKey:@"event"]) {
//                [[NSUserDefaults standardUserDefaults] setObject:[dic valueForKey:@"event"] forKey:@"share-event"];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//            }
        
    }
    
    @objc func returnNavi() -> UINavigationController {
        return self.navController
    }
    func getAdmin(){
        common.sendRequest(url: "http://110.165.17.124/sampleroad/db/sr_admin_select.php", method: "post", params: [:], sender: "") { resultJson in
            self.adminDic = resultJson as! [String:Any]
            if self.adminDic["REVIEW_VERSION"] != nil {
                UserDefaults.standard.set(false, forKey: "PRDC_MODE")
                print("유저 버전")
                print(UserDefaults.standard.bool(forKey: "PRDC_MODE"))
            }else{
                UserDefaults.standard.set(true, forKey: "PRDC_MODE")
                print("유저 버전")
                print(UserDefaults.standard.bool(forKey: "PRDC_MODE"))
//                if adminDic["APP_VERSION"] == adminDic["REVIEW_VERSION"] {
//
//                }
            }
            
            
            if self.adminDic["BILLING_TEST_I"] as! String == "1" {
                UserDefaults.standard.set(true, forKey: "BILLING_TEST")
            }else {
                UserDefaults.standard.set(false, forKey: "BILLING_TEST")
            }
        }
    }

}


