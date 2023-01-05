//
//  DetailProductView.swift
//  SampleLoad
//
//  Created by notegg on 2022/11/23.
//

import UIKit
import SnapKit
//import HCSStarRatingView

enum detailDisplayingView {
    case AIParsing
    case productDesc
    case review
}

class DetailProductView: UIView {
    
    var product: Product?
    var selectedView: detailDisplayingView = .AIParsing
    var imgArr = [String]()
    let margin: CGFloat = 17
    var index = 0
    let viewBounds = UIScreen.main.bounds
    let common = CommonS()
    lazy var contentH = viewBounds.height - topView.frame.height - changeViewButtonStackView.frame.height - bottomView.frame.height
    
    // MARK: -PurchaseView
    let purchasePopupView: PurchaseView = {
        let view = PurchaseView()
        view.isHidden = true
        return view
    }()
    
    // MARK: -topView
    lazy var topView: UIView = {
        let view = UIView()
        let topViewLabel: UILabel = {
            let label = UILabel()
            label.text = "제품정보"
            label.font = common.setFont(font: "bold", size: 20)
            label.textColor = common.pointColor()
            return label
        }()
        [backButton, topViewLabel, shareButton, cartButton].forEach {
            view.addSubview($0)
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(26)
            $0.width.height.equalTo(50)
            $0.bottom.equalToSuperview()
        }
        topViewLabel.snp.makeConstraints {
            $0.centerY.equalTo(backButton)
            $0.centerX.equalToSuperview()
        }
        shareButton.snp.makeConstraints {
            $0.trailing.equalTo(cartButton.snp.leading)
            $0.width.height.equalTo(50)
            $0.bottom.equalToSuperview()
        }
        cartButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(26)
            $0.width.height.equalTo(50)
            $0.bottom.equalToSuperview()
        }
        return view
    }()
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back_btn"), for: .normal)
        button.contentHorizontalAlignment = .leading
        return button
    }()
    lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "share_btn"), for: .normal)
        button.contentHorizontalAlignment = .trailing
        return button
    }()
    lazy var cartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cart_btn"), for: .normal)
        button.contentHorizontalAlignment = .trailing
        return button
    }()
    
    // MARK: -detailProductScrollView
    
    lazy var detailProductScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        let contentView = UIView()
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.edges.equalToSuperview()
        }
        [
            productImageScrollView, productImageNextButton, productImageBackButton,
            productInfoView,
            changeViewButtonStackView,
            changingSubScrollView
        ].forEach {
            contentView.addSubview($0)
        }
        
        productImageScrollView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(margin)
            $0.height.equalTo(viewBounds.width / 5 * 4)
        }
        productImageBackButton.snp.makeConstraints {
            $0.centerY.equalTo(productImageScrollView.snp.centerY)
            $0.leading.equalTo(productImageScrollView.snp.leading)
        }
        productImageNextButton.snp.makeConstraints {
            $0.centerY.equalTo(productImageScrollView.snp.centerY)
            $0.trailing.equalTo(productImageScrollView.snp.trailing)
        }
        
        productInfoView.snp.makeConstraints {
            $0.top.equalTo(productImageScrollView.snp.bottom).offset(margin)
            $0.leading.trailing.equalToSuperview().inset(margin)
        }
        changeViewButtonStackView.snp.makeConstraints {
            $0.top.equalTo(productInfoView.snp.bottom).offset(margin)
            $0.leading.trailing.equalToSuperview().inset(margin)
        }
        changingSubScrollView.snp.makeConstraints {
            $0.top.equalTo(changeViewButtonStackView.snp.bottom).offset(margin)
            $0.leading.trailing.equalToSuperview().inset(margin)
            $0.height.equalTo(AIParsingWebView.snp.height)
            $0.bottom.equalToSuperview()
        }
        return scrollView
    }()
    
    
    // MARK: -productImageScrollView
    var currentX:CGFloat = 0
    lazy var productImageScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = false
        [productImageStackView]
            .forEach {
                scrollView.addSubview($0)
            }
        productImageStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        }
        scrollView.bringSubviewToFront(productImageNextButton)
        return scrollView
    }()
    lazy var productImageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        stackView.addArrangedSubview(productThumbImageView)
        return stackView
    }()
    lazy var productThumbImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.snp.makeConstraints {
            $0.width.equalTo(viewBounds.width - (margin * 2))
        }
        return imageView
    }()
    lazy var productImageNextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "image_next_btn"), for: .normal)
        button.snp.makeConstraints {
            $0.width.equalTo(21)
            $0.height.equalTo(33)
        }
        button.addTarget(self, action: #selector(productImageNextButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    lazy var productImageBackButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "image_back_btn"), for: .normal)
        button.snp.makeConstraints {
            $0.width.equalTo(21)
            $0.height.equalTo(33)
        }
        button.isHidden = true
        button.addTarget(self, action: #selector(productImageBackButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: -productInfoView
    lazy var productInfoView: UIView = {
        let view = UIView()
        [
            brandNameLabel, productNameLabel, priceLabel,
            evaluationStarView, evaluationScoreLabel, evaluationCount,
            satisfyLabel
        ].forEach {
            view.addSubview($0)
        }
        brandNameLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        productNameLabel.snp.makeConstraints {
            $0.top.equalTo(brandNameLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview()
        }
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(productNameLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview()
        }
        evaluationStarView.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview()
            $0.height.equalTo(20)
            $0.width.equalTo(86)
        }
        evaluationScoreLabel.snp.makeConstraints {
            $0.bottom.equalTo(evaluationStarView)
            $0.leading.equalTo(evaluationStarView.snp.trailing).offset(5)
        }
        evaluationCount.snp.makeConstraints {
            $0.bottom.equalTo(evaluationStarView)
            $0.leading.equalTo(evaluationScoreLabel.snp.trailing).offset(5)
        }
        satisfyLabel.snp.makeConstraints {
            $0.top.equalTo(evaluationStarView.snp.bottom).offset(3)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        return view
    }()
    lazy var brandNameLabel: UILabel = {
        let label = UILabel()
        label.font = common.setFont(font: "bold", size: 13)
        label.textColor = common.gray()
        label.text = "브랜드 네임"
        return label
    }()
    lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.font = common.setFont(font: "bold", size: 17)
        label.textColor = .darkGray
        label.text = "상품 이름"
        return label
    }()
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = common.setFont(font: "bold", size: 15)
        label.textColor = .darkGray
        label.text = "상품 가격 원"
        return label
    }()
    lazy var evaluationStarView: HCSStarRatingView = {
        let starView = HCSStarRatingView()
        starView.minimumValue = 0
        starView.maximumValue = 5
        starView.starBorderColor = .clear
        starView.allowsHalfStars = true
        starView.isUserInteractionEnabled = false
        starView.spacing = 1
        starView.emptyStarColor = common.gray()
        starView.tintColor = common.setColor(hex: "#ffbc00")
        
        starView.value = 0
        return starView
    }()
    lazy var evaluationScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "0.0"
        label.font = common.setFont(font: "bold", size: 13)
        label.textColor = common.setColor(hex: "ffbc00")
        return label
    }()
    lazy var evaluationCount: UILabel = {
        let label = UILabel()
        label.text = "(0)"
        label.font = common.setFont(font: "bold", size: 13)
        label.textColor = common.gray()
        return label
    }()
    lazy var satisfyLabel: UILabel = {
        let label = UILabel()
        label.font = common.setFont(font: "bold", size: 13)
        label.textColor = common.gray()
        label.text = "100%가 이 제품에 만족했습니다."
        return label
    }()
    
    // MARK: -changeViewButtonStackView
    lazy var changeViewButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        [AIParsingButton, productDescriptionButton, reviewButton]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        return stackView
    }()
    lazy var AIParsingButton: UIButton = {
        let button = UIButton()
        button.setTitle("AI 분석", for: .normal)
        button.titleLabel?.font = common.setFont(font: "bold", size: 18)
        button.setTitleColor(.black, for: .selected)
        button.setTitleColor(common.gray(), for: .normal)
        button.contentVerticalAlignment = .center
        button.tag = 0
        button.addTarget(self, action: #selector(changeViewButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    lazy var productDescriptionButton: UIButton = {
        let button = UIButton()
        button.setTitle("제품설명", for: .normal)
        button.titleLabel?.font = common.setFont(font: "bold", size: 18)
        button.setTitleColor(.black, for: .selected)
        button.setTitleColor(common.gray(), for: .normal)
        button.contentVerticalAlignment = .center
        button.tag = 1
        button.addTarget(self, action: #selector(changeViewButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    lazy var reviewButton: UIButton = {
        let button = UIButton()
        button.setTitle("리뷰", for: .normal)
        button.titleLabel?.font = common.setFont(font: "bold", size: 18)
        button.setTitleColor(.black, for: .selected)
        button.setTitleColor(common.gray(), for: .normal)
        button.contentVerticalAlignment = .center
        button.tag = 2
        button.addTarget(self, action: #selector(changeViewButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: -changingSubScrollView
    lazy var changingSubScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.edges.equalToSuperview()
        }
        
        [
            AIParsingWebView, productDescriptionScrollView, reviewListTableView
        ].forEach {
            contentView.addSubview($0)
        }
        AIParsingWebView.snp.makeConstraints {
            $0.height.equalTo(viewBounds.width / 2 - margin)
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        productDescriptionScrollView.snp.makeConstraints {
            $0.top.equalTo(AIParsingWebView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
        }
        reviewListTableView.snp.makeConstraints {
            $0.top.equalTo(productDescriptionScrollView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            
            $0.bottom.equalToSuperview()
        }
        return scrollView
    }()
    
    // MARK: -AIParsingWebView
    let chartWebView = ChartWebView(frame: .zero, arr: ["20", "30", "40", "10", "5"]).then {
        $0.backgroundColor = .clear
    }
    lazy var percentTit = UILabel().then {
        $0.text = "예상"
        $0.textColor = common2.pointColor()
        $0.font = common2.setFont(font: "bold", size: 18)
    }
    lazy var percentLbl = UILabel().then {
        $0.text = "0%"
        $0.textColor = .black
        $0.font = common2.setFont(font: "bold", size: 18)
    }
    lazy var AIPercentView: UIView = {
        let view = UIView()
        [percentTit,percentLbl].forEach {
            view.addSubview($0)
        }
        percentTit.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.snp.centerY).offset(-5)
        }
        percentLbl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.snp.centerY).offset(5)
        }
        return view
    }()
    lazy var AIParsingWebView: UIView = {
        var view = UIView()
        [chartWebView,AIPercentView].forEach {
            view.addSubview($0)
        }
        chartWebView.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview()
            $0.width.equalTo(screenBounds2.width/2 - margin)
        }
        AIPercentView.snp.makeConstraints {
            $0.top.bottom.right.equalToSuperview()
            $0.width.equalTo(screenBounds2.width/2 - margin)
        }
        return view
    }()
    
    
    
    // MARK: -productDescriptionScrollView
    lazy var productDescriptionScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = true
        
        scrollView.addSubview(productDescriptionStackView)
        scrollView.addSubview(noneDescriptionView)
        productDescriptionStackView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.edges.equalToSuperview()
        }
        return scrollView
    }()
    lazy var productDescriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    lazy var noneDescriptionView = NoneView().then {
        $0.tit.text = "제품 설명 이미지가 없습니다"
        $0.isHidden = true
    }
    
    // MARK: -reviewListTableView
    lazy var reviewListTableView: UITableView = {
        let tableView = UITableView()
        tableView.bounces = false
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = common.gray()
        tableView.separatorInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.showsVerticalScrollIndicator = false
        
        tableView.addSubview(reviewNoDataView)
        reviewNoDataView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.height.width.equalToSuperview()
        }
        return tableView
    }()
    lazy var reviewNoDataView: UIView = {
        let view = UIView()
        let label: UILabel = {
            let label = UILabel()
            label.text = "리뷰가 없습니다"
            label.font = common.setFont(font: "bold", size: 16)
            label.textColor = common.gray()
            label.textAlignment = .center
            return label
        }()
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        view.isHidden = true
        return view
    }()
    
    
    
    // MARK: -showAllReviewListButton
    lazy var showAllReviewListButton: UIButton = {
        let button = UIButton()
        button.setTitle("리뷰 전체보기", for: .normal)
#warning("리뷰 ~개 전체보기")
        button.setTitleColor(common.pointColor(), for: .normal)
        button.setBackgroundColor(.white, for: .normal)
        button.titleLabel?.font = common.setFont(font: "bold", size: 17)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = common.lightGray().cgColor
        button.isHidden = true
        return button
    }()
    
    // MARK: -writeReviewButton
    lazy var writeReviewButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = common.pointColor()
        button.setImage(UIImage(named: "write_btn"), for: .normal)
        button.isHidden = true
        return button
    }()
    
    // MARK: -bottomView
    lazy var bottomView: UIView = {
        let view = UIView()
        [likeButton, likeCountLabel, purchaseButton].forEach {
            view.addSubview($0)
        }
        likeButton.snp.makeConstraints {
            $0.width.height.equalTo(30)
            $0.leading.equalToSuperview().inset(margin * 2)
            $0.top.equalToSuperview().inset(margin)
        }
        likeCountLabel.snp.makeConstraints {
            $0.top.equalTo(likeButton.snp.bottom)
            $0.leading.trailing.equalTo(likeButton)
        }
        
        purchaseButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(margin * 2)
            $0.top.equalToSuperview().inset(margin)
            $0.width.equalTo(viewBounds.width / 5 * 3)
            $0.height.equalTo(viewBounds.width / 5 * 3 / 6).dividedBy(6)
        }
        purchaseButton.layer.cornerRadius = 8
        purchaseButton.clipsToBounds = true
        
        return view
    }()
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "like_btn"), for: .normal)
        button.setImage(UIImage(named: "like_fill_btn"), for: .selected)
        
        return button
    }()
    lazy var likeCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = common.setFont(font: "bold", size: 13)
        label.textColor = common.setColor(hex: "#ff96a0")
        label.textAlignment = .center
        
        return label
    }()
    lazy var purchaseButton: UIButton = {
        let button = UIButton()
        button.setTitle("구매하기", for: .normal)
        button.titleLabel?.font = common.setFont(font: "bold", size: 18)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundColor(common.pointColor(), for: .normal)
        return button
    }()
    
    // MARK: -initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func changeViewButtonTapped(_ sender: UIButton) {
        showAllReviewListButton.isHidden = true
        writeReviewButton.isHidden = true
        let contentH = viewBounds.height - topView.frame.height - changeViewButtonStackView.frame.height - bottomView.frame.height
        [AIParsingButton, productDescriptionButton, reviewButton]
            .forEach {
                $0.isSelected = false
                $0.layer.addBorder([.bottom], color: .white, width: 3)
            }
        sender.isSelected = true
        sender.layer.addBorder([.bottom], color: .black, width: 3)
        if sender.tag == 0 {
            selectedView = .AIParsing
            detailProductScrollView.isScrollEnabled = true
            let point = CGPoint(
                x: 0,
                y: 0
            )
            changingSubScrollView.setContentOffset(point, animated: true)
            detailProductScrollView.setContentOffset(point, animated: true)
            
            
            changingSubScrollView.snp.remakeConstraints {
                $0.top.equalTo(changeViewButtonStackView.snp.bottom).offset(margin)
                $0.leading.trailing.equalToSuperview().inset(margin)
                $0.height.equalTo(AIParsingWebView.snp.height)
                $0.bottom.equalToSuperview()
            }
            
            
        } else if sender.tag == 1 {
            selectedView = .productDesc
            changingSubScrollView.snp.remakeConstraints {
                $0.top.equalTo(changeViewButtonStackView.snp.bottom).offset(margin)
                $0.leading.trailing.equalToSuperview().inset(margin)
                $0.height.equalTo(contentH)
                $0.bottom.equalToSuperview()
            }
            productDescriptionScrollView.snp.makeConstraints {
                $0.height.equalTo(contentH - 26)
            }
            
            detailProductScrollView.isScrollEnabled = false
            changingSubScrollView.isScrollEnabled = false
            productDescriptionScrollView.isHidden = false
            var point = CGPoint(
                x: 0,
                y: changeViewButtonStackView.frame.minY
            )
            detailProductScrollView.setContentOffset(point, animated: true)
            
            print(changeViewButtonStackView.frame.origin.y)
            point = CGPoint(
                x: 0,
                y: productDescriptionScrollView.frame.minY
            )
            changingSubScrollView.setContentOffset(point, animated: true)
            
        } else if sender.tag == 2 {
            selectedView = .review
            showAllReviewListButton.isHidden = false
            writeReviewButton.isHidden = false
            productDescriptionScrollView.isHidden = true
            changingSubScrollView.snp.remakeConstraints {
                $0.top.equalTo(changeViewButtonStackView.snp.bottom).offset(margin)
                $0.leading.trailing.equalToSuperview().inset(margin)
                $0.height.equalTo(contentH)
                $0.bottom.equalToSuperview()
            }
            reviewListTableView.snp.makeConstraints {
                $0.height.equalTo(contentH - 26)
            }
            detailProductScrollView.isScrollEnabled = false
            changingSubScrollView.isScrollEnabled = false
            var point = CGPoint(
                x: 0,
                y: changeViewButtonStackView.frame.minY
            )
            detailProductScrollView.setContentOffset(point, animated: true)
            
            print(changeViewButtonStackView.frame.origin.y)
            point = CGPoint(
                x: 0,
                y: reviewListTableView.frame.minY
            )
            changingSubScrollView.setContentOffset(point, animated: true)
        }
    }
    
    func setProperties() {
        guard let product = product else {
            return
        }
        makeThumbImage()
        purchasePopupView.product = product
        purchasePopupView.setProperties()
        
        brandNameLabel.text = product.brand.name
        productNameLabel.text = product.name
        setPriceLabel()
        evaluationStarView.value = CGFloat(product.rating.average.raw)
        evaluationScoreLabel.text = product.rating.average.formatted
        evaluationCount.text = "(\(product.rating.count.formatted))"
        satisfyLabel.text = "\(product.rating.average.raw * 20)%가 이 제품에 만족했습니다."
        setProductDescriptionImageView()
    }
    func makeThumbImage() {
        guard let product = product else {
            return
        }
        if let encodedUrlStr = product.thumbnail?.url.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed)
        //           let url = URL(string: encodedUrlStr),
        //           let imageData = try? Data(contentsOf: url),
        //           let image = UIImage(data: imageData)
        {
            //            productThumbImageView.image = image
            common.setImageUrl(url: encodedUrlStr, imageView: productThumbImageView)
        }else {
            productThumbImageView.image = UIImage(named: "")
            productThumbImageView.contentMode = .center
        }
        
        makeSummaryLabel()
        if product.catalogs?.count ?? 0 > 2 {
            (0...1).forEach {
                guard let encodedUrlStr = product.catalogs?[$0].image?.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                      let url = URL(string: encodedUrlStr),
                      let imageData = try? Data(contentsOf: url),
                      let image = UIImage(data: imageData) else {
                    productImageNextButton.isHidden = true
                    return
                }
                let imageView = UIImageView(image: image)
                imageView.snp.makeConstraints {
                    $0.width.equalTo(viewBounds.width - (margin * 2))
                }
                productImageStackView.addArrangedSubview(imageView)
            }
        }
    }
    
    func makeSummaryLabel() {
        guard let product = product ,
              product.summary != "" else {
            return
        }
        let summaryStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.spacing = 10
            stackView.alignment = .fill
            stackView.distribution = .equalSpacing
            return stackView
        }()
        productThumbImageView.addSubview(summaryStackView)
        summaryStackView.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
            $0.height.equalTo(viewBounds.width / 10)
        }
        let summaries = product.summary.components(separatedBy: ",")
            .map {
                $0.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        summaries.forEach {
            let label = UILabel()
            label.backgroundColor = common.pointColor()
            label.textColor = .white
            label.font = common.setFont(font: "bold", size: 13)
            label.adjustsFontSizeToFitWidth = true
            label.textAlignment = .center
            label.text = "#\($0)"
            label.snp.makeConstraints {
                $0.width.equalTo(viewBounds.size.width / 10 * 1.5)
            }
            summaryStackView.addArrangedSubview(label)
        }
    }
    func setPriceLabel() {
        guard let product = product else {
            return
        }
        if product.discount.value == nil {
            var price = product.price.sale.formatted
            price.removeFirst()
            priceLabel.text = price + "원"
        } else {
            let salePercentage = product.discount.value?.formatted ?? ""
            
            var discountedPriceFormated = product.price.sale.formatted
            discountedPriceFormated.removeFirst()
            discountedPriceFormated += "원"
            
            var originPriceFormated = product.price.original.formatted
            originPriceFormated.removeFirst()
            originPriceFormated += "원"
            
            let priceText = "\(salePercentage) \(discountedPriceFormated) \(originPriceFormated)"
            
            let attributedString = NSMutableAttributedString(string: priceText)
            attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: (priceText as NSString).range(of: salePercentage))
            attributedString.addAttribute(.foregroundColor, value: UIColor.lightGray, range: (priceText as NSString).range(of: originPriceFormated))
            attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: (priceText as NSString).range(of: originPriceFormated))
            priceLabel.attributedText = attributedString
            
        }
    }
    func setProductDescriptionImageView() {
            guard let product = product else {
                return
            }
        if product.catalogs?.count ?? 0 > 3 {
            DispatchQueue.global().async {
                for c in 2..<(product.catalogs?.count ?? 0) {
                    if let urlStr = product.catalogs?[c].image?.url,
                       let encodedUrlStr = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                       let url = URL(string: encodedUrlStr)
                    {
                        if let data = try? Data(contentsOf: url) {
                            if let image = UIImage(data: data) {
                                DispatchQueue.main.sync {
                                    let descImageView = UIImageView()
                                    descImageView.image = image
                                    let imageHeight = image.size.height
                                    let imageWidth = image.size.width
                                    let imageRatio = (self.screenBounds2.width - self.margin * 2) / imageWidth
                                    descImageView.snp.makeConstraints {
                                        $0.height.equalTo(imageHeight * imageRatio)
                                    }
                                    self.productDescriptionStackView.addArrangedSubview(descImageView)
                                }
                            }
                        }
                    }
                }
            }
        }else {
            noneDescriptionView.isHidden = false
            noneDescriptionView.snp.makeConstraints {
                $0.edges.equalTo(productDescriptionStackView)
                $0.height.equalTo(screenBounds2.height - viewBounds.width / 2)
            }
        }
        }
        func setPick(isPick: Bool, count: String) {
            if isPick {
                likeButton.isSelected = true
            } else {
                likeButton.isSelected = false
            }
            likeCountLabel.text = count
        }
        @objc func productImageNextButtonTapped(_ sender: UIButton) {
            let imageCount = productImageStackView.subviews.count - 1
            
            let imageW = productThumbImageView.frame.width
            let point = CGPoint(x: imageW + imageW * currentX, y: 0)
            currentX += 1
            if imageCount == Int(currentX) {
                productImageNextButton.isHidden = true
            }
            if Int(currentX) != 0 {
                productImageBackButton.isHidden = false
            }
            productImageScrollView.setContentOffset(point, animated: true)
        }
        @objc func productImageBackButtonTapped(_ sender: UIButton) {
            let imageCount = productImageStackView.subviews.count - 1
            
            let imageW = productThumbImageView.frame.width
            let point = CGPoint(x: imageW * currentX - imageW, y: 0)
            currentX -= 1
            if Int(currentX) == 0 {
                productImageBackButton.isHidden = true
            }
            if imageCount != Int(currentX) {
                productImageNextButton.isHidden = false
            }
            
            productImageScrollView.setContentOffset(point, animated: true)
        }
    }
    

extension DetailProductView {
    // MARK: - setLayout()
    
    private func setLayout() {
        backgroundColor = .white
        let showAllReviewListButtonView: UIView = {
            let view = UIView()
            view.backgroundColor = .clear
            view.addSubview(showAllReviewListButton)
            showAllReviewListButton.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            return view
        }()
//        showAllReviewListButtonView.layer.shadowColor = UIColor.gray.cgColor
//        showAllReviewListButtonView.layer.shadowOpacity = 1.0
//        showAllReviewListButtonView.layer.shadowOffset = CGSize.zero
//        showAllReviewListButtonView.layer.shadowRadius = 3
        
        let uiProperties = [
            purchasePopupView,
            topView,
            detailProductScrollView,
            showAllReviewListButtonView,
            writeReviewButton,
            bottomView
        ]
        
        uiProperties.forEach {
            addSubview($0)
        }
        
        purchasePopupView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        topView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(viewBounds.width / 4)
        }
        detailProductScrollView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomView.snp.top)
        }
        writeReviewButton.snp.makeConstraints {
            $0.height.width.equalTo(60)
            $0.trailing.equalToSuperview().inset(margin)
            $0.bottom.equalTo(showAllReviewListButtonView.snp.top).inset(-20)
        }
        writeReviewButton.layer.cornerRadius = 30
        writeReviewButton.clipsToBounds = true
        showAllReviewListButtonView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(margin)
            $0.bottom.equalTo(bottomView.snp.top).offset(-10)
            $0.height.equalTo(44)
        }
        bottomView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(viewBounds.width / 4)
        }
        
        bringSubviewToFront(purchasePopupView)
        
        let contentH1 = viewBounds.height - topView.frame.size.height - changeViewButtonStackView.frame.size.height - bottomView.frame.size.height
        print(viewBounds.height)
        print(contentH, "contentH")
    }
    
}





