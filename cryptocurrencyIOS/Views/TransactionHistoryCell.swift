//
//  TransactionHistoryCell.swift
//  cryptocurrencyIOS
//
//  Created by Alan Soares de Oliveira on 22/02/21.
//

import UIKit

class TransactionHistoryCell: UICollectionViewCell {
        
    // MARK: - Properties
    
    private let transactionIconImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        let imageV = UIImage(named: "transaction")
        let tinta = imageV?.withRenderingMode(.alwaysTemplate)
        image.image = tinta
        image.tintColor = UIColor(named: "primarypurple")
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Sold Ethereum"
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "14:20 12 Apr"
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "-2.000,34 ETH"
        return label
    }()
    
    private let nextImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = #imageLiteral(resourceName: "right_arrow")
        image.tintColor = UIColor.gray
        return image
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        transactionIconImage.setDimensions(width: 30, height: 30)
        nextImage.setDimensions(width: 20, height: 20)
        
        addSubview(transactionIconImage)
        transactionIconImage.centerY(inView: self)
        transactionIconImage.anchor(left: leftAnchor, paddingLeft: 24)
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, timeLabel])
        stack.axis = .vertical
        stack.spacing = 4
        
        addSubview(stack)
        stack.centerY(inView: transactionIconImage)
        stack.anchor(left: transactionIconImage.rightAnchor, paddingLeft: 12)
        
        addSubview(nextImage)
        nextImage.centerY(inView: self)
        nextImage.anchor(right: rightAnchor, paddingRight: 24)
        
        addSubview(amountLabel)
        amountLabel.centerY(inView: nextImage)
        amountLabel.anchor(right: nextImage.leftAnchor, paddingLeft: 8 , paddingRight: 0)
        
        let underlineView = UIView()
        underlineView.backgroundColor = .systemGroupedBackground
        addSubview(underlineView)
        underlineView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 24, paddingRight: 24, height: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
