//
//  TransactionHistoryHeader.swift
//  cryptocurrencyIOS
//
//  Created by Alan Soares de Oliveira on 22/02/21.
//

import UIKit

class TransactionHistoryHeader: UICollectionReusableView {

    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Histórico de Transação"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = .black
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor,paddingTop: 24, paddingLeft: 24)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
