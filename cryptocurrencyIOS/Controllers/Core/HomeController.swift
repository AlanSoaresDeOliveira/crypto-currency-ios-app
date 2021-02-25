//
//  HomeController.swift
//  cryptocurrencyIOS
//
//  Created by Alan Soares de Oliveira on 21/02/21.
//

import UIKit

private let reuseIdentifier = "TrendingCell"
private let cellHistoryIdentifier = "CellIdentifier"
private let headerIdentifier = "HeaderIdentifier"

class HomeController: UIViewController, UICollectionViewDelegate {
       
    
    // MARK: - Porperties
    
    private var statusBarHeight = CGFloat(0)
        
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 500)
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .systemGray6
        view.frame = self.view.bounds
        view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.showsHorizontalScrollIndicator = true
        view.bounces = true
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = contentViewSize
        return view
    }()
    
    private lazy var trendingTable: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(TrendingCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        return cv
    }()
    
    private lazy var transactionHistoryColletion: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.layer.cornerRadius = 15
        cv.register(TransactionHistoryCell.self, forCellWithReuseIdentifier: cellHistoryIdentifier)
        
        return cv
    }()
    
    private lazy var transactionTable: UITableView = {
        let table = UITableView()
        
        return table
    }()
    
    private lazy var backgroundImageHeader: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "banner")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var header: UIView = {
        let view = UIView()
        
        view.addSubview(backgroundImageHeader)
        backgroundImageHeader.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: -statusBarHeight, height: 290)
        
        view.addSubview(bellIconNotificationButton)
        bellIconNotificationButton.anchor(top: view.topAnchor, right: view.rightAnchor, paddingRight: 24)
        
        view.addSubview(titleLabel)
        titleLabel.centerX(inView: view)
        titleLabel.anchor(top: bellIconNotificationButton.bottomAnchor, paddingTop: 6)
        
        view.addSubview(amountLabel)
        amountLabel.centerX(inView: view)
        amountLabel.anchor(top: titleLabel.bottomAnchor, paddingTop: 6)
        
        view.addSubview(lastHourLabel)
        lastHourLabel.centerX(inView: view)
        lastHourLabel.anchor(top: amountLabel.bottomAnchor, paddingTop: 6)
        
        view.addSubview(trendingLabel)
        trendingLabel.anchor(top: lastHourLabel.bottomAnchor, left: view.leftAnchor , paddingTop: 8, paddingLeft: 12)
        
        return view
    }()
    
    private lazy var bellIconNotificationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "notification_white"), for: .normal)
        button.setDimensions(width: 35, height: 35)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleBell), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sua Cateira de Balanço"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.text = "R$ 12.724,33"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        return label
    }()
    
    private lazy var lastHourLabel: UILabel = {
        let label = UILabel()
        label.text = "Últimas 24 horas"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    
    private lazy var trendingLabel: UILabel = {
        let label = UILabel()
        label.text = "Trending"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private let priceAlertView = PriceAlertView()
    
    private let noticeView = NoticeView()
    
    private lazy var viewTransaction: UIView = {
        let view = UIView()
        view.backgroundColor = .white        
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 4.65
        view.layer.shadowOpacity = 0.3
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = false
       
        view.addSubview(titleTransactionLabel)
        titleTransactionLabel.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8 , paddingLeft:  24,height: 50)
        
        transactionHistoryColletion.isScrollEnabled = false
        view.addSubview(transactionHistoryColletion)
        transactionHistoryColletion.delegate = self
        transactionHistoryColletion.dataSource = self
        transactionHistoryColletion.anchor(top: titleTransactionLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, height: 600)
        
        return view
    }()
    
    private lazy var titleTransactionLabel: UILabel = {
        let label = UILabel()
        label.text = "Histórico de Transação"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        return label
    }()
   
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStatusBarHeight()
        configeUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Helpers
        
    func configeUI() {
        view.backgroundColor = .systemGray6
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.backgroundColor = .systemGray6
        
        containerView.addSubview(header)
        header.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, height: 290)
        
        containerView.addSubview(trendingTable)
        trendingTable.backgroundColor = UIColor.clear
        trendingTable.delegate = self
        trendingTable.dataSource = self
        trendingTable.showsHorizontalScrollIndicator = false
        trendingTable.anchor(top: header.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: -(statusBarHeight + 15 + 75), height: 180)
        
        containerView.addSubview(priceAlertView)
        priceAlertView.anchor(top: trendingTable.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 5, paddingLeft: 12,  paddingRight: 12, height: 120)

        containerView.addSubview(noticeView)
        noticeView.anchor(top: priceAlertView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 20, paddingLeft: 12, paddingRight: 12, height: 150)
        
        containerView.addSubview(viewTransaction)
        viewTransaction.anchor(top: noticeView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 20, paddingLeft: 12, paddingRight: 12, height: 650)
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
    
    @objc func handleBell() {
        print("BELL")
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.transactionHistoryColletion {
            return CGSize(width: view.frame.width - 24, height: 60)
        }
        return CGSize(width: 180, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == self.transactionHistoryColletion {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == self.transactionHistoryColletion {
            return CGFloat(0)
        }
        return CGFloat(10)
    }
}

// MARK: - UICollectionViewDelegate

extension HomeController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.transactionHistoryColletion {
            return 10
        }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.transactionHistoryColletion {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellHistoryIdentifier, for: indexPath) as! TransactionHistoryCell
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TrendingCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.trendingTable {
            let controller = CryptoDetailController()
            navigationController?.pushViewController(controller, animated: true)
        }
        
    }
}
