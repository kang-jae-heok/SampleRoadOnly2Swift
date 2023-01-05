//
//  OrderView.swift
//  SampleLoad
//
//  Created by notegg on 2022/11/22.
//

import UIKit
import SnapKit
import CRPickerButton

class OrderSView: UIView {

    let common = CommonS()
    let orderModel = OrderModel()
    lazy var topView: UIView = {
        let view = UIView()
        let label: UILabel = {
            let label = UILabel()
            label.font = common.setFont(font: "bold", size: 20)
            label.textColor = common.pointColor()
            label.text = "주문 / 결제"
            return label
        }()
        view.addSubview(label)
        view.addSubview(backBtn)
        label.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        backBtn.snp.makeConstraints {
            $0.centerY.equalTo(label)
            $0.left.equalToSuperview().offset(margin2)
        }
        return view
    }()
    let backBtn = UIButton().then {
        $0.setImage(UIImage(named: "back_btn"), for: .normal)
    }
    
    // MARK: -orderScrollView
    lazy var orderScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        
        let stackView = UIStackView(arrangedSubviews: [
            ordererView, orderAddressView, requireView, couponView , sampleInfoView, checkAmountView,
            totalPaymentView, paymentMethodView, agreeView
        ])

        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.edges.equalToSuperview()
        }
        let bounds = UIScreen.main.bounds
        ordererView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(35)
            $0.bottom.equalTo(emailTextField.snp.bottom)
        }
        orderAddressView.snp.makeConstraints {
            $0.leading.trailing.equalTo(ordererView)
        }
        requireView.snp.makeConstraints {
            $0.leading.trailing.equalTo(ordererView)
        }
        couponView.snp.makeConstraints {
            $0.leading.trailing.equalTo(ordererView)
        }
        sampleInfoView.snp.makeConstraints {
            $0.leading.trailing.equalTo(ordererView)
        }
        checkAmountView.snp.makeConstraints {
            $0.leading.trailing.equalTo(ordererView)
        }
        totalPaymentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(bounds.width / 6)
        }
        paymentMethodView.snp.makeConstraints {
            $0.leading.trailing.equalTo(ordererView)
        }
        agreeView.snp.makeConstraints {
            $0.leading.trailing.equalTo(ordererView)
        }
        return scrollView
    }()
    
    // MARK: -ordererView
    lazy var ordererView: UIView = {
        let view = UIView()
        let infoLabel: UILabel = {
            let label = UILabel()
            label.text = "주문자 정보"
            label.font = common.setFont(font: "bold", size: 17)
            return label
        }()
        [
            infoLabel, ordererNameTextField,
            firstPhonTextField, secondPhonTextField, thirdPhonTextField,
            emailTextField
        ].forEach {
            view.addSubview($0)
        }
        infoLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        ordererNameTextField.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(view.snp.width).dividedBy(8)
        }
        firstPhonTextField.snp.makeConstraints {
            $0.top.equalTo(ordererNameTextField.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
            $0.height.equalTo(ordererNameTextField.snp.height)
            $0.width.equalTo(view.snp.width).dividedBy(3).offset(-10)
        }
        
        secondPhonTextField.snp.makeConstraints {
            $0.top.equalTo(ordererNameTextField.snp.bottom).offset(10)
            $0.leading.equalTo(firstPhonTextField.snp.trailing).offset(10)
            $0.height.equalTo(ordererNameTextField.snp.height)
            $0.trailing.equalTo(thirdPhonTextField.snp.leading).inset(-10)

        }
        thirdPhonTextField.snp.makeConstraints {
            $0.top.equalTo(ordererNameTextField.snp.bottom).offset(10)
            $0.width.equalTo(firstPhonTextField)
            $0.height.equalTo(ordererNameTextField.snp.height)
            $0.trailing.equalToSuperview()
        }
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(firstPhonTextField.snp.bottom).offset(10)
            $0.height.equalTo(ordererNameTextField.snp.height)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        return view
    }()
    lazy var ordererNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = common.setFont(font: "bold", size: 15)
        textField.attributedPlaceholder = NSAttributedString(
            string: "주문 고객 이름을 입력해주세요",
            attributes: [.font: common.setFont(font: "regular", size: 15),
                         .foregroundColor: common.gray()
            ]
        )
        textField.addLeftPadding()
        textField.textColor = .black
        textField.layer.borderColor = common.setColor(hex: "#9f9f9f").cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    lazy var firstPhonTextField: UITextField = {
        let textField = UITextField()
        textField.font = common.setFont(font: "bold", size: 15)
        textField.attributedPlaceholder = NSAttributedString(
            string: "010",
            attributes: [.font: common.setFont(font: "regular", size: 15),
                         .foregroundColor: common.gray()
            ]
        )
        textField.textColor = .black
        textField.layer.borderColor = common.setColor(hex: "#9f9f9f").cgColor
        textField.layer.borderWidth = 1
        textField.addLeftPadding()
        textField.keyboardType = .numberPad
        return textField
    }()
    lazy var secondPhonTextField: UITextField = {
        let textField = UITextField()
        textField.font = common.setFont(font: "bold", size: 15)
        textField.attributedPlaceholder = NSAttributedString(
            string: "0000",
            attributes: [.font: common.setFont(font: "regular", size: 15),
                         .foregroundColor: common.gray()
            ]
        )
        textField.textColor = .black
        textField.layer.borderColor = common.setColor(hex: "#9f9f9f").cgColor
        textField.layer.borderWidth = 1
        textField.addLeftPadding()
        textField.keyboardType = .numberPad
        return textField
    }()
    lazy var thirdPhonTextField: UITextField = {
        let textField = UITextField()
        textField.font = common.setFont(font: "bold", size: 15)
        textField.attributedPlaceholder = NSAttributedString(
            string: "0000",
            attributes: [.font: common.setFont(font: "regular", size: 15),
                         .foregroundColor: common.gray()
            ]
        )
        textField.textColor = .black
        textField.layer.borderColor = common.setColor(hex: "#9f9f9f").cgColor
        textField.layer.borderWidth = 1
        textField.addLeftPadding()
        textField.keyboardType = .numberPad
        return textField
    }()
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.font = common.setFont(font: "bold", size: 15)
        textField.attributedPlaceholder = NSAttributedString(
            string: "이메일 주소를 입력해주세요",
            attributes: [.font: common.setFont(font: "regular", size: 15),
                         .foregroundColor: common.gray()
            ]
        )
        textField.textColor = .black
        textField.layer.borderColor = common.setColor(hex: "#9f9f9f").cgColor
        textField.layer.borderWidth = 1
        textField.addLeftPadding()
        return textField
    }()
    
    // MARK: -orderAddressView
    lazy var orderAddressView: UIView = {
        let view = UIView()
        let infoLabel: UILabel = {
            let label = UILabel()
            label.text = "배송지 정보"
            label.font = common.setFont(font: "bold", size: 17)
            return label
        }()
        
        [
            infoLabel,
            firstAddressLabel, searchAddressButton,
            secondAddressLabel,
            detailAddressTextField,
            firstAddressButton,
            secondAddressButton
        ].forEach {
            view.addSubview($0)
        }
        infoLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        let bounds = UIScreen.main.bounds
        firstAddressLabel.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
            $0.height.equalTo(bounds.width / 9)
            $0.width.equalTo(180)
        }
        firstAddressButton.snp.makeConstraints {
            $0.edges.equalTo(firstAddressLabel)
        }
        searchAddressButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalTo(firstAddressLabel.snp.top)
            $0.height.equalTo(firstAddressLabel.snp.height)
            $0.leading.equalTo(firstAddressLabel.snp.trailing).offset(12)
        }
        secondAddressLabel.snp.makeConstraints {
            $0.top.equalTo(firstAddressLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(firstAddressLabel.snp.height)
        }
        secondAddressButton.snp.makeConstraints {
            $0.edges.equalTo(secondAddressLabel)
        }
        detailAddressTextField.snp.makeConstraints {
            $0.top.equalTo(secondAddressLabel.snp.bottom).offset(10)
            $0.height.equalTo(firstAddressLabel.snp.height)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        return view
    }()
    lazy var firstAddressLabel: UITextField = {
        let textField = UITextField()
        textField.font = common.setFont(font: "bold", size: 15)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = common.setColor(hex: "#9f9f9f").cgColor
        textField.isUserInteractionEnabled = false
        textField.attributedPlaceholder = NSAttributedString(
            string: "우편번호",
            attributes: [.font: common.setFont(font: "regular", size: 15),
                         .foregroundColor: common.gray()
                        ]
        )
        textField.addLeftPadding()
        return textField
    }()
    let firstAddressButton = UIButton()
    lazy var searchAddressButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = common.pointColor()
        button.setTitle("우편번호 검색", for: .normal)
        button.titleLabel?.font = common.setFont(font: "bold", size: 16)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    lazy var secondAddressLabel: UITextField = {
        let textField = UITextField()
        textField.font = common.setFont(font: "bold", size: 15)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = common.setColor(hex: "#9f9f9f").cgColor
        textField.isUserInteractionEnabled = false
        textField.attributedPlaceholder = NSAttributedString(
            string: "주소",
            attributes: [.font: common.setFont(font: "regular", size: 15),
                         .foregroundColor: common.gray()
            ]
        )
        textField.addLeftPadding()
        return textField
    }()
    let secondAddressButton = UIButton()
    lazy var detailAddressTextField: UITextField = {
        let textField = UITextField()
        textField.font = common.setFont(font: "bold", size: 15)
        textField.textColor = .black
        textField.layer.borderColor = common.setColor(hex: "#9f9f9f").cgColor
        textField.layer.borderWidth = 1
        textField.attributedPlaceholder = NSAttributedString(
            string: "상세주소",
            attributes: [.font: common.setFont(font: "regular", size: 15),
                         .foregroundColor: common.gray()
            ]
        )
        textField.addLeftPadding()
        return textField
    }()

    // MARK: -requireView
    lazy var requireView: UIView = {
        let view = UIView()
        let infoLabel: UILabel = {
            let label = UILabel()
            label.text = "배송 요청 사항"
            label.font = common.setFont(font: "bold", size: 17)
            return label
        }()
        
        [infoLabel, selectRequireButton, requireTextField].forEach {
            view.addSubview($0)
        }
        infoLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        let bounds = UIScreen.main.bounds
        selectRequireButton.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(bounds.width / 9)
        }
        requireTextField.snp.makeConstraints {
            $0.top.equalTo(selectRequireButton.snp.bottom).offset(20)
            $0.height.equalTo(bounds.width / 9)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        return view
    }()
    lazy var requireTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = common.setColor(hex: "#9f9f9f").cgColor
        textField.font = common.setFont(font: "bold", size: 12)
        textField.addLeftPadding()
        textField.isHidden = true
        return textField
    }()
    lazy var selectRequireButton: CRPickerButton = {
        let button = CRPickerButton()
        button.setTitle("요청 사항 선택 ▼", for: .normal)
        
        button.titleLabel?.font = common.setFont(font: "bold", size: 12)
        button.setTitleColor(common.setColor(hex: "#9f9f9f"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = common.setColor(hex: "#9f9f9f").cgColor
        return button
    }()
    // MARK: -couponView
    lazy var couponView: UIView = {
       let view = UIView()
        let infoLabel: UILabel = {
            let label = UILabel()
            label.text = "할인 적용"
            label.font = common.setFont(font: "bold", size: 17)
            return label
        }()
        
        [infoLabel, couponLabel, couponDiscountPriceLabel, getCouponButton].forEach {
            view.addSubview($0)
        }
        infoLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        couponLabel.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(20)
            $0.left.equalToSuperview()
        }
        getCouponButton.snp.makeConstraints {
            $0.centerY.equalTo(couponLabel)
            $0.right.equalToSuperview()
            $0.size.equalTo(CGSize(width: 60 , height: 25))
            $0.bottom.equalToSuperview()
        }
        couponDiscountPriceLabel.snp.makeConstraints {
            $0.centerY.equalTo(getCouponButton)
            $0.right.equalTo(getCouponButton.snp.left).offset(-5)
        }
        return view
    }()
    lazy var couponLabel:UILabel = {
        let label = UILabel()
        label.font = common.setFont(font: "bold", size: 14)
        label.textColor = common.gray()
        label.text = "쿠폰"
        return label
    }()
    lazy var couponDiscountPriceLabel:UILabel = {
        let label = UILabel()
        label.font = common.setFont(font: "bold", size: 18)
        label.textColor = common.gray()
        label.text = "0원"
        return label
    }()
    lazy var getCouponButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = common.pointColor()
        button.setTitle("쿠폰적용", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = common.setFont(font: "bold", size: 14)
        return button
    }()
    
    
    // MARK: -sampleInfoView
    lazy var sampleInfoView: UIView = {
        let view = UIView()
      
        [infoLabel, sampleInfoScrollView].forEach {
            view.addSubview($0)
        }
        let bounds = UIScreen.main.bounds
        infoLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        sampleInfoScrollView.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(bounds.height / 5)
        }
        view.isHidden = true
        return view
    }()
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "선택하신 상품 정보"
        label.font = common.setFont(font: "bold", size: 17)
        return label
    }()
    lazy var sampleInfoScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        return scrollView
    }()
    
    // MARK: -checkAmountView
    lazy var checkAmountView: UIView = {
        let view = UIView()
        let infoLabel: UILabel = {
            let label = UILabel()
            label.text = "결제 금액 확인"
            label.font = common.setFont(font: "bold", size: 17)
            return label
        }()
        let amountDescLabel: UILabel = {
            let label = UILabel()
            label.text = "총 상품 금액"
            label.font = common.setFont(font: "bold", size: 14)
            label.textColor = common.gray()
            return label
        }()
        let deliveryFeeDescLabel: UILabel = {
            let label = UILabel()
            label.text = "배송비"
            label.font = common.setFont(font: "bold", size: 14)
            label.textColor = common.gray()
            return label
        }()
        
        [
            infoLabel, amountDescLabel, deliveryFeeDescLabel,
            amountValueLabel, deliveryFeeValueLabel
        ].forEach {
            view.addSubview($0)
        }
        infoLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        amountDescLabel.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
        }
        deliveryFeeDescLabel.snp.makeConstraints {
            $0.top.equalTo(amountDescLabel.snp.bottom).offset(10)
            $0.leading.bottom.equalToSuperview()
        }
        amountValueLabel.snp.makeConstraints {
            $0.bottom.equalTo(amountDescLabel.snp.bottom)
            $0.trailing.equalToSuperview()
        }
        deliveryFeeValueLabel.snp.makeConstraints {
            $0.bottom.equalTo(deliveryFeeDescLabel.snp.bottom)
            $0.trailing.equalToSuperview()
        }
        return view
    }()
    lazy var amountValueLabel: UILabel = {
        let label = UILabel()
        label.text = "무료"
        label.font = common.setFont(font: "bold", size: 16)
        label.textColor = common.setColor(hex: "#6f6f6f")
        return label
    }()
    lazy var deliveryFeeValueLabel: UILabel = {
        let label = UILabel()
        label.text = "3500원"
        label.font = common.setFont(font: "bold", size: 16)
        label.textColor = common.setColor(hex: "#6f6f6f")
        return label
    }()
    
    // MARK: -totalPaymentView
    lazy var totalPaymentView: UIView = {
        let view = UIView()
        view.backgroundColor = common.setColor(hex: "#f0f0f0")
        let infoLabel: UILabel = {
            let label = UILabel()
            label.text = "총 결제 금액"
            label.font = common.setFont(font: "bold", size: 17)
            return label
        }()
        [infoLabel, totalPaymentLabel].forEach {
            view.addSubview($0)
        }
        infoLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(35)
        }
        totalPaymentLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(35)
        }
        return view
    }()
    lazy var totalPaymentLabel: UILabel = {
        let label = UILabel()
        label.text = "총 금액 원"
        label.font = common.setFont(font: "bold", size: 24)
        return label
    }()
    
    // MARK: -paymentMethodView
    lazy var paymentMethodView: UIView = {
        let view = UIView()
        let infoLabel: UILabel = {
            let label = UILabel()
            label.text = "결제 수단"
            label.font = common.setFont(font: "bold", size: 17)
            return label
        }()
        let saveMethodDescLabel: UILabel = {
            let label = UILabel()
            label.text = "선택한 결제 수단을 다음에도 사용"
            label.font = common.setFont(font: "bold", size: 16)
            label.textColor = common.setColor(hex: "#b1b1b1")
            return label
        }()
        [infoLabel,
         creditSimpleButton, accountTransferButton, virtualAccountButton,
         savePaymentMethodButton, saveMethodDescLabel
        ]
            .forEach {
                view.addSubview($0)
            }
        infoLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        creditSimpleButton.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(view.snp.width).dividedBy(7)
        }
        accountTransferButton.snp.makeConstraints {
            $0.top.equalTo(creditSimpleButton.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(view.snp.width).dividedBy(7)
        }
        virtualAccountButton.snp.makeConstraints {
            $0.top.equalTo(accountTransferButton.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(view.snp.width).dividedBy(7)
        }
        savePaymentMethodButton.snp.makeConstraints {
            $0.top.equalTo(virtualAccountButton.snp.bottom).offset(20)
            $0.width.height.equalTo(20)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        saveMethodDescLabel.snp.makeConstraints {
            $0.centerY.equalTo(savePaymentMethodButton.snp.centerY)
            $0.leading.equalTo(savePaymentMethodButton.snp.trailing).offset(5)
        }
        [creditSimpleButton, accountTransferButton, virtualAccountButton].forEach {
            $0.layer.cornerRadius = 4
            $0.clipsToBounds = true
        }
        return view
    }()
    lazy var creditSimpleButton: UIButton = {
        let button = UIButton()
        button.setTitle("카드/간편결제", for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.setTitleColor(common.lightGray(), for: .normal)
        button.titleLabel?.font = common.setFont(font: "bold", size: 16)
        button.layer.borderWidth = 2
        button.layer.borderColor = common.lightGray().cgColor
        button.tag = 0
        return button
    }()
    lazy var accountTransferButton: UIButton = {
        let button = UIButton()
        button.setTitle("실시간 계좌이체", for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.setTitleColor(common.lightGray(), for: .normal)
        button.titleLabel?.font = common.setFont(font: "bold", size: 16)
        button.layer.borderWidth = 2
        button.layer.borderColor = common.lightGray().cgColor
        button.tag = 1
        return button
    }()
    lazy var virtualAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("가상 계좌", for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.setTitleColor(common.lightGray(), for: .normal)
        button.titleLabel?.font = common.setFont(font: "bold", size: 16)
        button.layer.borderWidth = 2
        button.layer.borderColor = common.lightGray().cgColor
        button.tag = 2
        return button
    }()
    lazy var savePaymentMethodButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(.white, for: .normal)
        button.setBackgroundColor(common.pointColor(), for: .selected)
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 2
        button.tag = 0

//        button.setImage(UIImage(named: "login_check_off_btn"), for: .normal)
//        button.setImage(UIImage(named: "login_check_on_btn"), for: .selected)
        return button
    }()
    
    // MARK: -agreeView
    lazy var agreeView: UIView = {
        let view = UIView()
        let allAgreeDescLabel: UILabel = {
            let label = UILabel()
            label.text = "전체 동의"
            label.font = common.setFont(font: "bold", size: 16)
            label.textColor = common.gray()
            return label
        }()
        let checkPaymentDescLabel: UILabel = {
            let label = UILabel()
            label.text = "[필수] 주문내용 확인 및 결제 동의"
            label.font = common.setFont(font: "bold", size: 16)
            label.textColor = common.gray()
            return label
        }()
        let privacyInfoDescLabel: UILabel = {
            let label = UILabel()
            label.text = "[필수] 개인정보 제3자 제공 동의"
            label.font = common.setFont(font: "bold", size: 16)
            label.textColor = common.gray()
            return label
        }()
        [allAgreeButton, allAgreeDescLabel,
         checkPaymentButton, checkPaymentDescLabel,
         privacyInfoButton, privacyInfoDescLabel
        ]
            .forEach {
            view.addSubview($0)
        }
        allAgreeButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.height.equalTo(20)
        }
        allAgreeDescLabel.snp.makeConstraints {
            $0.leading.equalTo(allAgreeButton.snp.trailing).offset(10)
            $0.centerY.equalTo(allAgreeButton.snp.centerY)
        }
        checkPaymentButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(allAgreeButton.snp.bottom).offset(20)
            $0.width.height.equalTo(20)
        }
        checkPaymentDescLabel.snp.makeConstraints {
            $0.leading.equalTo(checkPaymentButton.snp.trailing).offset(10)
            $0.centerY.equalTo(checkPaymentButton.snp.centerY)
        }
        privacyInfoButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(checkPaymentButton.snp.bottom).offset(10)
            $0.width.height.equalTo(20)
        }
        privacyInfoDescLabel.snp.makeConstraints {
            $0.leading.equalTo(privacyInfoButton.snp.trailing).offset(10)
            $0.centerY.equalTo(privacyInfoButton.snp.centerY)
            $0.bottom.equalToSuperview().inset(40)
        }

        
        
        return view
    }()
    lazy var allAgreeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(.white, for: .normal)
        button.setBackgroundColor(common.pointColor(), for: .selected)
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 2
        button.tag = 0
        return button
    }()
    lazy var checkPaymentButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(.white, for: .normal)
        button.setBackgroundColor(common.pointColor(), for: .selected)
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 2
        button.tag = 1
        return button
    }()
    lazy var privacyInfoButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(.white, for: .normal)
        button.setBackgroundColor(common.pointColor(), for: .selected)
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 2
        button.tag = 2
        return button
    }()
    
    // MARK: -orderButton
    lazy var orderButton: UIButton = {
        let button = UIButton()
        button.setTitle("결제하기", for: .normal)
        button.setBackgroundColor(common.lightGray(), for: .disabled)
        button.setBackgroundColor(common.pointColor(), for: .normal)
        button.titleLabel?.font = common.setFont(font: "bold", size: 18)
        button.isEnabled = false
        return button
    }()
    
    // MARK: -initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setUserInfo()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    func makeSampleInfoView(samples: [[String: Any]]) {
        sampleInfoView.isHidden = false
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 0
        
        sampleInfoScrollView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        }
        (0...samples.count - 1).forEach {
            let samplePreview = samplePreview()
            samplePreview.sampleInfo = samples[$0]
            samplePreview.setProperties()
            samplePreview.snp.makeConstraints {
                // 전체 뷰의 h: 바운드.h / 5, w: h / 3 * 2
                $0.width.equalTo(UIScreen.main.bounds.height / 5 / 3 * 2)
            }
            stackView.addArrangedSubview(samplePreview)
        }
    }
    func makeRequireTextField() {
        requireTextField.isHidden = false
    }
    func setUserInfo() {
        if UserDefaults.contains("order_user_info") {
            guard let userInfoDic = UserDefaults.standard.value(forKey: "order_user_info") as? [String:Any],
                  let name = userInfoDic["name"] as? String,
                  let email = userInfoDic["email"] as? String,
                  let firstPhone = userInfoDic["firstPhone"] as? String,
                  let secondPhone = userInfoDic["secondPhone"] as? String,
                  let thirdPhone = userInfoDic["thirdPhone"] as? String
            else {return}
            ordererNameTextField.text = name
            firstPhonTextField.text = firstPhone
            secondPhonTextField.text = secondPhone
            thirdPhonTextField.text = thirdPhone
            emailTextField.text = email
            
            if let paymethod = userInfoDic["paymethod"] as? String {
                print(paymethod)
                [creditSimpleButton, accountTransferButton, virtualAccountButton].forEach {
                    if $0.titleLabel?.text! == paymethod {
                        $0.isSelected = true
                        $0.backgroundColor = common.pointColor()
                        $0.layer.borderColor = common.pointColor().cgColor
                    }else {
                        $0.isSelected = false
                        $0.backgroundColor = .white
                        $0.layer.borderColor = common.lightGray().cgColor
                    }
                }
            }
        }else {
            if let name = UserDefaults.standard.string(forKey: "user_alias"),
               let moble = UserDefaults.standard.string(forKey: "user_mobile"),
               let email = UserDefaults.standard.string(forKey: "user_email")
            {
                let mobileArr = moble.components(separatedBy: "-")
                if mobileArr.count == 3 {
                    firstPhonTextField.text = mobileArr[0]
                    secondPhonTextField.text = mobileArr[1]
                    thirdPhonTextField.text = mobileArr[2]
                }
                ordererNameTextField.text = name
                emailTextField.text = email
            }
            [creditSimpleButton, accountTransferButton, virtualAccountButton].forEach {
                if $0.titleLabel?.text! == creditSimpleButton.titleLabel?.text! {
                    $0.isSelected = true
                    $0.backgroundColor = common.pointColor()
                    $0.layer.borderColor = common.pointColor().cgColor
                }else {
                    $0.isSelected = false
                    $0.backgroundColor = .white
                    $0.layer.borderColor = common.lightGray().cgColor
                }
            }
        }
    }

}

extension OrderSView {
  
    // MARK: - setLayout()
    private func setLayout() {
        backgroundColor = .white
        let uiProperties = [topView, orderScrollView, orderButton]

        uiProperties.forEach {
            addSubview($0)
        }
        let bounds = UIScreen.main.bounds
        topView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(bounds.width / 4)
        }
        orderScrollView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(orderButton.snp.top)
        }
        orderButton.snp.makeConstraints {
            $0.height.equalTo(bounds.width / 4.5)
            $0.top.equalTo(orderScrollView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
    }
}

class samplePreview: UIView {
    let common = CommonS()
    var sampleInfo: [String: Any]?
    
    let sampleImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    lazy var brandLabel: UILabel = {
        let label = UILabel()
        label.font = common.setFont(font: "regular", size: 9)
        label.textAlignment = .center
        label.textColor = common.lightGray()
        return label
    }()
    lazy var sampleNameLabel: UILabel = {
        let label = UILabel()
        label.font = common.setFont(font: "regular", size: 10)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProperties() {
        if let sampleInfo = sampleInfo,
              let productName = sampleInfo["name"] as? String,
              let brand = sampleInfo["brand"] as? [String: Any],
              let brandName = brand["name"] as? String,
              let thumbnail = sampleInfo["thumbnail"] as? [String: Any],
              let thumbImageURL = thumbnail["url"] as? String
        {
            if let thumbUrlStr = thumbImageURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
                common.setImageUrl(url: thumbUrlStr, imageView: sampleImageView)
            }
            sampleNameLabel.text = productName
            brandLabel.text = brandName
        }
        else {
            guard let cartInfo = sampleInfo,
                  let productDic = cartInfo["product"] as? [String:Any],
                  let prdouctName = productDic["name"] as? String,
                  let thumbnail = productDic["thumbnail"] as? [String:Any],
                  let thumbImageURL = thumbnail["url"] as? String,
                  let brand = cartInfo["brand"] as? [String:Any],
                  let brandName = brand["name"] as? String
            else {return}
            if let thumbUrlStr = thumbImageURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
                common.setImageUrl(url: thumbUrlStr, imageView: sampleImageView)
            }
            sampleNameLabel.text = prdouctName
            brandLabel.text = brandName
        }
    }
    
    // MARK: - setLayout()
    private func setLayout() {
        
        let uiProperties = [sampleImageView, brandLabel, sampleNameLabel]
        
        uiProperties.forEach {
            addSubview($0)
        }
        // 이미지뷰의 h: w * 1.1
        sampleImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(sampleImageView.snp.width).multipliedBy(1.1)
        }
        brandLabel.snp.makeConstraints {
            $0.top.equalTo(sampleImageView.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(9)
        }
        sampleNameLabel.snp.makeConstraints {
            $0.top.equalTo(brandLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(28)
        }
        
    }
}



