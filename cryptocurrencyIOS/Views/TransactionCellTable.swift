//
//  TransactionCellTable.swift
//  cryptocurrencyIOS
//
//  Created by Alan Soares de Oliveira on 23/02/21.
//

import UIKit

class TransactionCellTable: UITableViewCell {
    
    // MARK: - Properties
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let yearsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        let stack = UIStackView(arrangedSubviews: [nameLabel, yearsLabel])
        stack.distribution = .fillEqually
        
        addSubview(stack)
        stack.centerY(inView: self)
        stack.anchor(left: leftAnchor, right: rightAnchor)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
}
