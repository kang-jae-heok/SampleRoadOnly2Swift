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
}
