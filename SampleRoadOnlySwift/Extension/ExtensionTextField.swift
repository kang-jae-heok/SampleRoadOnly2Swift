//
//  ExtensionTextField.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/11/22.
//

import Foundation
extension UITextField {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}
