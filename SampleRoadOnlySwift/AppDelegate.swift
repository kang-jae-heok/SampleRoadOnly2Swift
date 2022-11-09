//
//  AppDelegate.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/09/20.
//

import UIKit
import KakaoSDKCommon
import NaverThirdPartyLogin
import IQKeyboardManagerSwift
import iamport_ios
@main

@objc class AppDelegate: UIResponder, UIApplicationDelegate {
    let userToken = NSString()
    
    public var window: UIWindow?
    //    public var navController = UINavigationController()
    //    private(set) var persistentContainer: NSPer?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        KakaoSDK.initSDK(appKey: "4574ebf3c9e9e5765331fe01d3e5181e")
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        //        IQKeyboardManager.shared.disabledToolbarClasses = [TopViewViewController.self]
        
        
        //        IQKeyboardManager.sharedManager().disableInViewControllerClass(TopViewViewController.self)
        // 네이버 간편로그인 init
        let instance = NaverThirdPartyLoginConnection.getSharedInstance()
        ///  네이버앱으로 로그인
        instance!.isNaverAppOauthEnable = true
        /// 사파리로 로그인
        instance!.isInAppOauthEnable = true
        
        instance?.serviceUrlScheme = "naverlogin" // 앱을 등록할 때 입력한 URL Scheme
        instance?.consumerKey = "YhdqBjtCMkKxxip6Egxy" // 상수 - client id
        instance?.consumerSecret = "nMdSqYG_gq" // pw
        instance?.appName = "sampleload" // app name
        return true
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        NaverThirdPartyLoginConnection.getSharedInstance()?.application(app, open: url, options: options)
        Iamport.shared.receivedURL(url)
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        
        // 세로방향 고정
        return UIInterfaceOrientationMask.portrait
    }
    
    //    @objc func returnNavi() -> UINavigationController {
    //        return self.navController
    //    }
    
}
extension UIViewController {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
        
    }
}
extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
extension UIView {
    var parentViewController: UIViewController? {
        // Starts from next (As we know self is not a UIViewController).
        var parentResponder: UIResponder? = self.next
        while parentResponder != nil {
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
            parentResponder = parentResponder?.next
        }
        return nil
    }
    var margin2: CGFloat{
        return 17.0
    }
    var screenRatio: CGFloat {
        let screenBounds = UIScreen.main.bounds
        return screenBounds.width/414.0
    }
    
}
extension UIViewController {
    var parentViewController: UIViewController? {
        // Starts from next (As we know self is not a UIViewController).
        var parentResponder: UIResponder? = self.view.next
        while parentResponder != nil {
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
            parentResponder = parentResponder?.next
        }
        return nil
    }
}
extension UIDevice {
    var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            if UIApplication.shared.windows.count == 0 { return false }          // Should never occur, but…
            let top = UIApplication.shared.windows[0].safeAreaInsets.top
            return top > 0          // That seem to be the minimum top when no notch…
        } else {
            // Fallback on earlier versions
            return false
        }
    }
}
extension UserDefaults {
    static func contains(_ key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
extension Date {

    /**
     # dateCompare
     - Parameters:
        - fromDate: 비교 대상 Date
     - Note: 두 날짜간 비교해서 과거(Future)/현재(Same)/미래(Past) 반환
    */
    public func dateCompare(fromDate: Date) -> String {
        var strDateMessage:String = ""
        let result:ComparisonResult = self.compare(fromDate)
        switch result {
        case .orderedAscending:
            strDateMessage = "Future"
            break
        case .orderedDescending:
            strDateMessage = "Past"
            break
        case .orderedSame:
            strDateMessage = "Same"
            break
        default:
            strDateMessage = "Error"
            break
        }
        return strDateMessage
    }
}


