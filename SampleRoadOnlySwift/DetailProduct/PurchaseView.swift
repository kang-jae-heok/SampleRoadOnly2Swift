//
//  PurchaseView.swift
//  SampleLoad
//
//  Created by notegg on 2022/11/29.
//

import UIKit
import SnapKit

class PurchaseView: UIView {
    let screenBounds = UIScreen.main.bounds
    let common = CommonS()
    let margin: CGFloat = 26
    
    var product: Product?
    var singlePrice = 0
    var productCount = 1
    var totalOrderAmount = 0
    
    // MARK: -opacityView
    let opacityView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.6
        return view
    }()
    
    // MARK: -purchaseInfoView
    lazy var purchaseInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        [
            productNameLabel,
            decreaseNumberOfOrderButton, numberOfOrderLabel, increaseNumberOfOrderButton,
            totalOrderAmountLabel
        ].forEach {
            view.addSubview($0)
        }
        productNameLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(margin)
        }
        decreaseNumberOfOrderButton.snp.makeConstraints {
            $0.top.equalTo(productNameLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(margin)
            $0.width.height.equalTo(20)
        }
        numberOfOrderLabel.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.centerY.equalTo(decreaseNumberOfOrderButton.snp.centerY)
            $0.leading.equalTo(decreaseNumberOfOrderButton.snp.trailing).offset(4)
        }
        increaseNumberOfOrderButton.snp.makeConstraints {
            $0.centerY.equalTo(decreaseNumberOfOrderButton.snp.centerY)
            $0.width.height.equalTo(20)
            $0.leading.equalTo(numberOfOrderLabel.snp.trailing).offset(4)
        }
        totalOrderAmountLabel.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(margin)
        }
        return view
    }()
    lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.font = common.setFont(font: "Regular", size: 14)
        label.textColor = common.gray()
        label.text = "제품 이름"
        return label
    }()
    lazy var decreaseNumberOfOrderButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "__btn"), for: .normal)
        button.addTarget(self, action: #selector(decreaseNumberOfOrderButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    lazy var numberOfOrderLabel: UILabel = {
        let label = UILabel()
        label.font = common.setFont(font: "bold", size: 20)
        label.textAlignment = .center
        label.textColor = .black
        label.text = "1"
        return label
    }()
    lazy var increaseNumberOfOrderButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "+_btn"), for: .normal)
        button.addTarget(self, action: #selector(increaseNumberOfOrderButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    lazy var totalOrderAmountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = common.setFont(font: "bold", size: 20)
        label.text = "0원"
        label.textColor = .black
        return label
    }()
    
    // MARK: -buttonStackView
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            cartAddButton, orderButton
        ])
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    lazy var cartAddButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.borderWidth = 2
        button.layer.borderColor = common.pointColor().cgColor
        button.titleLabel?.font = common.setFont(font: "bold", size: 20)
        button.setTitle("장바구니", for: .normal)
        button.setTitleColor(common.pointColor(), for: .normal)
        return button
    }()
    lazy var orderButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = common.pointColor()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("구매하기", for: .normal)
        button.titleLabel?.font = common.setFont(font: "bold", size: 20)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProperties() {
        guard let product = product else {
            return
        }
        productNameLabel.text = product.name
        singlePrice = product.price.sale.raw
        totalOrderAmount = singlePrice * productCount

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        guard let str = formatter.string(from: NSNumber.init(value: Int(totalOrderAmount))) else {
            return
        }
        totalOrderAmountLabel.text = "\(str)원"
        
    }
    @objc func decreaseNumberOfOrderButtonTapped(_ sender: UIButton) {
        guard productCount != 1 else {
            return
        }
        productCount -= 1
        totalOrderAmount = singlePrice * productCount
        
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        guard let str = formatter.string(from: NSNumber.init(value: Int(totalOrderAmount))) else {
            return
        }

        numberOfOrderLabel.text = "\(productCount)"
        totalOrderAmountLabel.text = "\(str)원"
    }
    @objc func increaseNumberOfOrderButtonTapped(_ sender: UIButton) {
        productCount += 1
        totalOrderAmount = singlePrice * productCount
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        guard let str = formatter.string(from: NSNumber.init(value: Int(totalOrderAmount))) else {
            return
        }
        
        numberOfOrderLabel.text = "\(productCount)"
        totalOrderAmountLabel.text = "\(str)원"

    }
}

extension PurchaseView {
    // MARK: - setLayout()
    
    private func setLayout() {
//        backgroundColor = .black
//        alpha = 0.6
        
        let cntH = (margin * 2) + 36
        let defaultView = UIView()
        defaultView.backgroundColor = .white
        let uiProperties = [opacityView, purchaseInfoView, buttonStackView, defaultView]

        uiProperties.forEach {
            addSubview($0)
        }
        opacityView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(purchaseInfoView.snp.top)
        }
        
        purchaseInfoView.snp.makeConstraints {
            $0.height.equalTo((screenBounds.width / 4))
            $0.leading.trailing.equalToSuperview()
        }
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(purchaseInfoView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(screenBounds.width / 6)
        }
        defaultView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(buttonStackView.snp.bottom)
            $0.height.equalTo(screenBounds.width / 6)
            $0.bottom.equalToSuperview()
        }
        
    }
}



