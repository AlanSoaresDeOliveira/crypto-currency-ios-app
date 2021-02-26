//
//  CryptoDetailCell.swift
//  cryptocurrencyIOS
//
//  Created by Alan Soares de Oliveira on 26/02/21.
//

import UIKit

class CryptodetailCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var option: CryptoDetailOption! {
        didSet { chartOptionButton.text = option.description}
    }
    
    private lazy var chartOptionButton: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.backgroundColor = .systemGray3
        label.text = "1 Month"
        label.layer.cornerRadius = 30 / 2
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            chartOptionButton.backgroundColor = isSelected ? UIColor(named: "secondarypurple") : .systemGray3
            chartOptionButton.textColor = isSelected ? .white : .darkGray
        }
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(chartOptionButton)
        chartOptionButton.center(inView: self)
        chartOptionButton.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 2,paddingRight: 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
