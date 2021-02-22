//
//  NoticeView.swift
//  cryptocurrencyIOS
//
//  Created by Alan Soares de Oliveira on 22/02/21.
//

import UIKit

class NoticeView: UIView {
    
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Investimento Seguro"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "É muito difícil cronometrar investimento, especialmente quando o mercado é volátil. Aprenda como usar o custo médio para seu dinheiro."
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    private let learnMoreButton: UIButton = {
        let button = UIButton(type: .system)
        let attr: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 14),
            .foregroundColor: UIColor.green,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributeString = NSMutableAttributedString(string: "Aprenda mais", attributes: attr)
        
        button.setAttributedTitle(attributeString, for: .normal)
        return button
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
        backgroundColor = UIColor(named: "secondarypurple")
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 16)
        
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 16, paddingRight: 16)
        
        addSubview(learnMoreButton)
        learnMoreButton.anchor(top: descriptionLabel.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
}
