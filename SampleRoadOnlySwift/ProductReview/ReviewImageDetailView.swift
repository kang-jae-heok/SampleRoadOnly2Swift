//
//  ReviewImageDetailView.swift
//  SampleRoadOnlySwift
//
//  Created by notegg on 2022/12/08.
//

import UIKit
import SnapKit

class ReviewImageDetailView: UIView {
    let margin: CGFloat = 26
    let viewBounds = UIScreen.main.bounds
    var imageUrls: [String]? {
        didSet {
            setProperties()
        }
    }
    
    lazy var topView: UIView = {
        let view = UIView()
        view.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(margin)
        }
        return view
    }()
    lazy var backButton: UIButton = {
        let button = UIButton()
        guard let xImage = UIImage(named: "x_btn") else {
            return button
        }
        let renderImage = xImage.withRenderingMode(.alwaysTemplate)
        renderImage.withTintColor(common2.pointColor())
        
        button.setImage(renderImage, for: .normal)
        return button
    }()
    lazy var imageScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        }
        return scrollView
    }()
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setProperties() {
        guard let imageUrls = imageUrls else {
            return
        }
        imageUrls.forEach {
            if let reviewUrlStr = $0.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
               let url = URL(string: reviewUrlStr){
                let imageView = UIImageView().then {
                    $0.contentMode = .scaleAspectFit
                }
                common2.setImageUrl(url: reviewUrlStr, imageView: imageView)
                imageView.snp.makeConstraints {
                    $0.width.equalTo(viewBounds.width - margin * 2)
                }
                stackView.addArrangedSubview(imageView)
            }
        }
    }
}

extension ReviewImageDetailView {
    // MARK: - setLayout()
    private func setLayout() {
        backgroundColor = .white
        let uiProperties = [topView, imageScrollView]
        
        uiProperties.forEach {
            addSubview($0)
        }
        topView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(viewBounds.width / 4)
        }
        imageScrollView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(margin)
            $0.bottom.equalToSuperview()
        }

    }
}
