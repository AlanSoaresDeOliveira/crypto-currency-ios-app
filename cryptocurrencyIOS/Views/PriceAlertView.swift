//
//  PriceAlertView.swift
//  cryptocurrencyIOS
//
//  Created by Alan Soares de Oliveira on 21/02/21.
//

import UIKit

class PriceAlertView: UIView {
    
    private let alertIconImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = #imageLiteral(resourceName: "notification_color")
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Habilite Alerta de Preço"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Obtenha notificações quando sua carteira for atualizada."
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private let nextImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = #imageLiteral(resourceName: "right_arrow")
        image.tintColor = UIColor.gray
        return image
    }()
    
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
        alertIconImage.setDimensions(width: 30, height: 30)
        nextImage.setDimensions(width: 24, height: 30)
        
        addSubview(alertIconImage)
        alertIconImage.centerY(inView: self)
        alertIconImage.anchor(left: leftAnchor, paddingLeft: 12)
        
        let stack1 = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stack1.axis = .vertical
        stack1.distribution = .equalSpacing
        stack1.spacing = 4
        addSubview(stack1)
        
        stack1.centerY(inView: alertIconImage)
        stack1.anchor(left: alertIconImage.rightAnchor, paddingLeft: 12, paddingRight: 12 )
        
        addSubview(nextImage)
        nextImage.centerY(inView: alertIconImage)
        nextImage.anchor(left: stack1.rightAnchor, right: rightAnchor, paddingRight: 12)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
