//
//  CryptoDetail.swift
//  cryptocurrencyIOS
//
//  Created by Alan Soares de Oliveira on 21/02/21.
//

import UIKit

class CryptoDetailController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 500)
    
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
    
    private lazy var chartView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 4.65
        view.layer.shadowOpacity = 0.3
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = false
        
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
        
        view.addSubview(buyButton)
        view.backgroundColor = .white
        buyButton.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 12, paddingRight: 12, height: 50)
        return view
    }()
    
    private lazy var buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "green_button")
        button.setTitle("Buy", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
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
        label.text = "BitcoinWallet"
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
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    private let porcentageLabel: UILabel = {
        let label = UILabel()
        label.text = "+7,24%"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .systemGreen
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .systemGray6
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.backgroundColor = .systemGray6
        
        containerView.addSubview(chartView)
        chartView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 24, paddingLeft: 12, paddingRight: 12, height: 300)
        
        containerView.addSubview(containerBuyView)
        containerBuyView.anchor(top: chartView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 20, paddingLeft: 12, paddingRight: 12, height: 150)
        
    }
}

