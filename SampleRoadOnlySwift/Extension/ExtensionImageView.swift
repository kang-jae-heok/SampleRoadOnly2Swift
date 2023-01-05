//
//  ExtensionImageView.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/11/23.
//

import Foundation
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
