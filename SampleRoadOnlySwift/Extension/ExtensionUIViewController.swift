//
//  ExtensionUIViewController.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/11/11.
//

import Foundation
import UIKit

extension UIViewController {
    var margin2: CGFloat{
        return 17.0
    }
    var screenRatio: CGFloat {
        let screenBounds = UIScreen.main.bounds
        return screenBounds.width/414.0
    }
    var screenBounds2: CGRect {
        return UIScreen.main.bounds
    }
    var common2: CommonS {
        let common = CommonS()
        return common
    }
    var customerId2: String {
        let customerId = UserDefaults.standard.string(forKey: "customer_id") ?? ""
        return customerId
    }
    var clientId: String {
        let clientId = "d7e698eb-c67d-4525-9253-ae881ee06f9f"
        return clientId
    }
    var clientSecret: String {
        let clientSecret = "xchdmPXIhzQN28jFBeg1FOfwazl0A_eudwsl6zEEtMw"
        return clientSecret
    }
    
    

}
