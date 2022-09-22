//
//  Common.swift
//  SampleRoadOnlySwift
//
//  Created by NOTEGG on 2022/09/21.
//

import Foundation
import UIKit
class Common{
    func setFont(font: String, size: CGFloat) -> UIFont{
        let upperFont = font.uppercased()
        if upperFont == "BOLD"{
            return UIFont(name: "AppleSDGothicNeo-Bold", size: size)!
        }else if upperFont == "EXTRABOLD"{
            return UIFont(name: "AppleSDGothicNeo-ExtraBold", size: size)!
        }else if upperFont == "SEMIBOLD"{
            return UIFont(name: "AppleSDGothicNeo-SemiBold", size: size)!
        }else if upperFont == "LIGHT"{
            return UIFont(name: "AppleSDGothicNeo-Light", size: size)!
        }else if upperFont == "MEDIUM"{
            return UIFont(name: "AppleSDGothicNeo-Medium", size: size)!
        }else{
            return UIFont(name: "AppleSDGothicNeo-Regular", size: size)!
        }
    }
    func setColor(hex: String) -> UIColor {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0

        return(UIColor(red: r, green: g, blue: b, alpha: 1.0))
    }
    func pointColor() -> UIColor{
        return self.setColor(hex: "#97C5E9")
    }
    func lightGray() -> UIColor{
        return self.setColor(hex: "#e6e6e6")
    }
}
extension UILabel {
    func asFontColor(targetStringList: [String], font: UIFont?, color: UIColor?) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)

        targetStringList.forEach {
            let range = (fullText as NSString).range(of: $0)
            attributedString.addAttributes([.font: font as Any, .foregroundColor: color as Any], range: range)
        }
        attributedText = attributedString
    }
    func asFont(targetStringList: [String], font: UIFont?) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)

        targetStringList.forEach {
            let range = (fullText as NSString).range(of: $0)
            attributedString.addAttributes([.font: font as Any], range: range)
        }
        attributedText = attributedString
    }
    func asColor(targetStringList: [String],color: UIColor?) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)

        targetStringList.forEach {
            let range = (fullText as NSString).range(of: $0)
            attributedString.addAttributes([.foregroundColor: color as Any], range: range)
        }
        attributedText = attributedString
    }

}
