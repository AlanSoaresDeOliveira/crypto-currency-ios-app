//
//  CoinAboutView.swift
//  cryptocurrencyIOS
//
//  Created by Alan Soares de Oliveira on 24/02/21.
//

import UIKit

class CoinAboutView: UIView {
    
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Bitcoin"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Bitcoin is a cryptocurrency invented in 2008 by an unknown person or group of people using the name Satoshi Nakamoto. The currency began use in 2009 when its implementation was released as open-source software."
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 4.65
        self.layer.shadowOpacity = 0.3
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 16)
        
        addSubview(descriptionLabel)
        descriptionLabel.anchor( left: leftAnchor, bottom: bottomAnchor,right: rightAnchor, paddingLeft: 16, paddingBottom: 16, paddingRight: 16, height: 100)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
}
