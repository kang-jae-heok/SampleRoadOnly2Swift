//
//  extensionUIView.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/11/10.
//

import Foundation
import UIKit

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
    var screenBounds2: CGRect {
        return UIScreen.main.bounds
    }
    var common2: CommonS {
        let common = CommonS()
        return common
    }
    @objc func touchGrayView(view: UIView){
        print("여기")
        let viewWithTag = view.viewWithTag(100)
        viewWithTag?.removeFromSuperview()
    }
    
}
