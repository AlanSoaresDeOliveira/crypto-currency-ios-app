//
//  TrendingView.swift
//  cryptocurrencyIOS
//
//  Created by Alan Soares de Oliveira on 21/02/21.
//

import UIKit

class TrendingCell: UICollectionViewCell {
        
    // MARK: - Properties
    
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
        label.text = "R$ 29.455,75"
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
    
    
    // MARK: - Lifecyle
    
    override func layoutSubviews() {
//        self.contentView.layer.cornerRadius = 15.0
//        self.contentView.layer.borderWidth = 5.0
//        self.contentView.layer.borderColor = UIColor.clear.cgColor
//        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 4.65
        self.layer.shadowOpacity = 0.3
//        self.layer.cornerRadius = 15.0
        self.layer.masksToBounds = false
//        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        layer.cornerRadius = 10
        backgroundColor = .white
        
        addSubview(iconImage)
        iconImage.anchor(top: topAnchor, left: leftAnchor, paddingTop: 24, paddingLeft: 24)
        
        addSubview(bitconLabel)
        bitconLabel.centerY(inView: iconImage, leftAnchor: iconImage.rightAnchor, paddingLeft: 12)
        
        addSubview(bitconForShortLabel)
        bitconForShortLabel.anchor(top: bitconLabel.bottomAnchor, left: bitconLabel.leftAnchor, paddingTop: 4)
        
        let stack = UIStackView(arrangedSubviews: [amountLabel, porcentageLabel])
        stack.axis = .vertical
        stack.spacing = 4

        addSubview(stack)
        stack.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 24, paddingBottom: 24)
    
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
}
