//
//  CryptoDetail.swift
//  cryptocurrencyIOS
//
//  Created by Alan Soares de Oliveira on 21/02/21.
//

import UIKit

class CryptoDetailController: UIViewController {
    
    // MARK: - Properties
    
    private var statusBarHeight = CGFloat(0)
    
    private lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 100)
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .systemGray6
        view.frame = self.view.bounds
        view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.showsHorizontalScrollIndicator = true
        view.bounces = true
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = contentViewSize
        return view
    }()
    
    private lazy var headerView: HeaderView = {
        let view  = HeaderView()
        return view
    }()
    
    private lazy var chartCoinView: ChartView = {
        let chart = ChartView()
        
        return chart
    }()
    
    private lazy var chartView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 4.65
        view.layer.shadowOpacity = 0.3
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = false
        
        view.addSubview(iconImageChart)
        iconImageChart.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 24, paddingLeft: 12)
        
        view.addSubview(bitconWalletLabelChart)
        bitconWalletLabelChart.centerY(inView: iconImageChart, leftAnchor: iconImageChart.rightAnchor, paddingLeft: 8)
        
        view.addSubview(bitconForShortLabelChart)
        bitconForShortLabelChart.anchor(top: bitconWalletLabelChart.bottomAnchor, left: bitconWalletLabelChart.leftAnchor, paddingTop: 4)
        
        view.addSubview(chartCoinView)
        chartCoinView.anchor(top: bitconForShortLabelChart.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 24, paddingRight: 24)
        
        return view
    }()
    
    private lazy var containerBuyView: UIView = {
        let view = UIView()
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 4.65
        view.layer.shadowOpacity = 0.3
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = false
        
        view.addSubview(iconImage)
        iconImage.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 24, paddingLeft: 12)
        
        view.addSubview(bitconWalletLabel)
        bitconWalletLabel.centerY(inView: iconImage, leftAnchor: iconImage.rightAnchor, paddingLeft: 8)
        
        view.addSubview(bitconForShortLabel)
        bitconForShortLabel.anchor(top: bitconWalletLabel.bottomAnchor, left: bitconWalletLabel.leftAnchor, paddingTop: 4)
        
        view.addSubview(nextImage)
        nextImage.centerY(inView: iconImage)
        nextImage.anchor(right: view.rightAnchor, paddingRight: 12)
        
        view.addSubview(amountLabel)
        amountLabel.centerY(inView: nextImage)
        amountLabel.anchor(right: nextImage.leftAnchor, paddingRight: 0)
        
        view.addSubview(porcentageLabel)
        porcentageLabel.anchor(top: amountLabel.bottomAnchor, right: amountLabel.rightAnchor, paddingTop: 4)
        
        
        view.addSubview(buyButton)
        view.backgroundColor = .white
        buyButton.anchor(top: bitconForShortLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 12, paddingRight: 12, height: 50)
        return view
    }()
    
    private lazy var buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "green_button")
        button.setTitle("Buy", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleToTransaction), for: .touchUpInside)
        return button
    }()
    
    private let iconImageChart: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "bitcoin")
        image.setDimensions(width: 20, height: 20)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let iconImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "bitcoin")
        image.setDimensions(width: 20, height: 20)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let bitconWalletLabelChart: UILabel = {
        let label = UILabel()
        label.text = "Bitcoin"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let bitconWalletLabel: UILabel = {
        let label = UILabel()
        label.text = "BitcoinWallet"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let bitconForShortLabelChart: UILabel = {
        let label = UILabel()
        label.text = "BTC"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .systemGray
        return label
    }()
    
    private let bitconForShortLabel: UILabel = {
        let label = UILabel()
        label.text = "BTC"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .systemGray
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "R$ 170.435,86"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let porcentageLabel: UILabel = {
        let label = UILabel()
        label.text = "5.1 BTC"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .systemGreen
        return label
    }()
    
    private let nextImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = #imageLiteral(resourceName: "right_arrow")
        image.tintColor = UIColor.gray
        image.setDimensions(width: 20, height: 20)
        return image
    }()
    
    private let coinAbout = CoinAboutView()
    
    private let priceAlertView = PriceAlertView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStatusBarHeight()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .systemGray6
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.backgroundColor = .systemGray6
        
        headerView.delegate = self
        view.addSubview(headerView)
        headerView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor,  height: 120)
        
        containerView.addSubview(chartView)
        chartView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 100, paddingLeft: 12, paddingRight: 12, height: 400)
        
        containerView.addSubview(containerBuyView)
        containerBuyView.anchor(top: chartView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 20, paddingLeft: 12, paddingRight: 12, height: 150)
        
        containerView.addSubview(coinAbout)
        coinAbout.anchor(top: containerBuyView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor,
                         paddingTop: 20, paddingLeft: 12, paddingRight: 12, height: 150)
        
        containerView.addSubview(priceAlertView)
        priceAlertView.anchor(top: coinAbout.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 20, paddingLeft: 12,  paddingRight: 12, height: 120)
        
    }
    
    func getStatusBarHeight() {
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            self.statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            self.statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
    }
    
    // MARK: - Selectors
    
    @objc func handleToTransaction() {
        let controller = TransactionController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - HeaderViewDelegate

extension CryptoDetailController: HeaderViewDelegate {
    func tappedBack() {
        navigationController?.popViewController(animated: true)
        print("HERE")
    }
}

