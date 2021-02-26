//
//  CryptoDetail.swift
//  cryptocurrencyIOS
//
//  Created by Alan Soares de Oliveira on 21/02/21.
//

import UIKit

private let reuseIdentifier = "CharCell"

class CryptoDetailController: UIViewController {
    
    // MARK: - Properties
    
    let pages = [1, 2 ,3]
    
    private var statusBarHeight = CGFloat(0)
    
    private lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 350)
    
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
    
    private lazy var chartCoinView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ChartViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        cv.isPagingEnabled = true
        return cv
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
        
        view.addSubview(amountLabelChart)
        amountLabelChart.centerY(inView: bitconWalletLabelChart)
        amountLabelChart.anchor(right: view.rightAnchor, paddingRight: 12 )
        
        view.addSubview(porcentageLabelChart)
        porcentageLabelChart.anchor(top: amountLabelChart.bottomAnchor, right: amountLabelChart.rightAnchor, paddingTop: 4)
               
        
        
        view.addSubview(chartCoinView)
        chartCoinView.backgroundColor = UIColor.clear
        chartCoinView.delegate = self
        chartCoinView.dataSource = self
        chartCoinView.showsHorizontalScrollIndicator = false
        chartCoinView.anchor(top: bitconForShortLabelChart.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,paddingLeft: 12, paddingRight: 12, height: 150)
        
        let stack = UIStackView(arrangedSubviews: [chartOptionButton1, chartOptionButton2, chartOptionButton3, chartOptionButton4, chartOptionButton5])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        view.addSubview(stack)
        stack.anchor(top: chartCoinView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 4, paddingLeft: 12, paddingRight: 12, height: 30)
        
        view.addSubview(pageControl)
        pageControl.centerX(inView: view)
        pageControl.anchor(bottom: view.bottomAnchor, paddingBottom: 8)
        
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
    
    private let amountLabelChart: UILabel = {
        let label = UILabel()
        label.text = "R$ 29.455,75"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let porcentageLabelChart: UILabel = {
        let label = UILabel()
        label.text = "+7,24%"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .systemGreen
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
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = UIColor(named: "secondarypurple")?.withAlphaComponent(1)
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        pc.isUserInteractionEnabled = false
//        pc.addTarget(self, action: #selector(tappedPageControl), for: .touchUpInside)
        return pc
    }()
    
    private lazy var chartOptionButton1: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("1 hr", for: .normal)
        button.backgroundColor = .systemGray3
        button.layer.cornerRadius = 30 / 2
        button.setTitleColor(.darkGray, for: .normal)
        return button
    }()
    
    private lazy var chartOptionButton2: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("3 Days", for: .normal)
        button.backgroundColor = .systemGray3
        button.layer.cornerRadius = 30 / 2
        button.setTitleColor(.darkGray, for: .normal)
        return button
    }()
    
    private lazy var chartOptionButton3: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("1 Week", for: .normal)
        button.backgroundColor = .systemGray3
        button.layer.cornerRadius = 30 / 2
        button.setTitleColor(.darkGray, for: .normal)
        return button
    }()
    
    private lazy var chartOptionButton4: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("1 Month", for: .normal)
        button.backgroundColor = .systemGray3
        button.layer.cornerRadius = 30 / 2
        button.setTitleColor(.darkGray, for: .normal)
        return button
    }()
    
    private lazy var chartOptionButton5: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("3 Months", for: .normal)
        button.backgroundColor = .systemGray3
        button.layer.cornerRadius = 30 / 2
        button.setTitleColor(.darkGray, for: .normal)
        return button
    }()
    
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
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int((x / view.frame.width).rounded())
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
        chartView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 100, paddingLeft: 12, paddingRight: 12, height: 300)
        
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
    
    @objc func tappedPageControl() {
        print("Tapped page")
        
    }
    
    @objc func handleToTransaction() {
        let controller = TransactionController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - HeaderViewDelegate

extension CryptoDetailController: HeaderViewDelegate {
    func tappedBack() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension CryptoDetailController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChartViewCell
        cell.backgroundColor = .red
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CryptoDetailController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 48, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

