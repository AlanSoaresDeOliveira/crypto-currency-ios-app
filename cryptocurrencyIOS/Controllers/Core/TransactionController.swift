//
//  TransactionController.swift
//  cryptocurrencyIOS
//
//  Created by Alan Soares de Oliveira on 21/02/21.
//

import UIKit

private let cellHistoryIdentifier = "HistoryCell"

class TransactionController: UIViewController {
    
    // MARK: - Properties
    
    private var statusBarHeight = CGFloat(0)
    
    private lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 200)
    
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
        
//        view.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: -statusBarHeight, height: 50)
        
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
        
        view.addSubview(bitconLabel)
        bitconLabel.centerY(inView: iconImage, leftAnchor: iconImage.rightAnchor, paddingLeft: 8)
        
        view.addSubview(bitconForShortLabel)
        bitconForShortLabel.anchor(top: bitconLabel.bottomAnchor, left: bitconLabel.leftAnchor, paddingTop: 4)
        
        view.addSubview(porcentageLabel)
        porcentageLabel.centerY(inView: view)
        porcentageLabel.centerX(inView: view)
        
        view.addSubview(amountLabel)
        amountLabel.centerX(inView: porcentageLabel)
        amountLabel.anchor(top: porcentageLabel.bottomAnchor)
        view.addSubview(buyButton)
        view.backgroundColor = .white
        buyButton.anchor( left: view.leftAnchor, bottom: view.bottomAnchor,right: view.rightAnchor, paddingLeft: 24, paddingBottom: 24, paddingRight: 24, height: 50)
        return view
    }()
    
    private lazy var buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "green_button")
        button.setTitle("Trade", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
//        button.addTarget(self, action: #selector(handleToTransaction), for: .touchUpInside)
        return button
    }()
    
    private let iconImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "bitcoin")
        image.setDimensions(width: 25, height: 25)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let bitconLabel: UILabel = {
        let label = UILabel()
        label.text = "Bitcoin"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
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
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .systemGray
        return label
    }()
    
    private let porcentageLabel: UILabel = {
        let label = UILabel()
        label.text = "5.1 BTC"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        return label
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
        
        containerView.addSubview(containerBuyView)
        containerBuyView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 100, paddingLeft: 12, paddingRight: 12, height: 280)
        
        containerView.addSubview(viewTransaction)
        viewTransaction.anchor(top: containerBuyView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 20, paddingLeft: 12, paddingRight: 12, height: 650)
    }
    
    func getStatusBarHeight() {
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            self.statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            self.statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
    }
}

// MARK: - HeaderViewDelegate

extension TransactionController: HeaderViewDelegate {
    func tappedBack() {
        navigationController?.popViewController(animated: true)
        print("HERE")
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TransactionController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 24, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return CGFloat(0)
    }
}

// MARK: - UICollectionViewDelegate

extension TransactionController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellHistoryIdentifier, for: indexPath) as! TransactionHistoryCell
        return cell
    }
}
