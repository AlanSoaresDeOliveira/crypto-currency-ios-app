//
//  HomeController.swift
//  cryptocurrencyIOS
//
//  Created by Alan Soares de Oliveira on 21/02/21.
//

import UIKit

private let reuseIdentifier = "TrendingCell"

class HomeController: UIViewController, UICollectionViewDelegate {
    
    // MARK: - Porperties
    
    private lazy var trendingTable: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(TrendingCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        return cv
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
        backgroundImageHeader.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 290)
        
        view.addSubview(bellIconNotificationButton)
        bellIconNotificationButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingRight: 24)
        
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
        
        view.addSubview(trendingTable)
        trendingTable.backgroundColor = UIColor.clear
//        trendingTable.backgroundColor = .blue
        trendingTable.delegate = self
        trendingTable.dataSource = self
        trendingTable.showsHorizontalScrollIndicator = false
        trendingTable.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingBottom: -90, height: 180)
        
        return view
    }()
    
    private lazy var bellIconNotificationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "notification_white"), for: .normal)
        button.setDimensions(width: 35, height: 35)
        button.tintColor = .white
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
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        view.addSubview(header)
        header.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 290)
        
        view.addSubview(priceAlertView)
        priceAlertView.anchor(top: header.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 100, paddingLeft: 12,  paddingRight: 12, height: 120)
        
        
    }
}

// MARK: - UICollectionViewDelegate

extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
    }
}

// MARK: - UICollectionViewDelegate

extension HomeController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TrendingCell
        return cell
    }
}