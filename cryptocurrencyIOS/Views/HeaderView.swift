//
//  HeaderView.swift
//  cryptocurrencyIOS
//
//  Created by Alan Soares de Oliveira on 24/02/21.
//

import UIKit

protocol HeaderViewDelegate: class {
    func tappedBack()
}

class HeaderView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: HeaderViewDelegate?
    
    private var statusBarHeight = CGFloat(0)
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "back_arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        return button
    }()
    
    private lazy var backLabel: UILabel = {
        let label = UILabel()
        label.text = "Back"
        label.tintColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        getStatusBarHeight()
        
        backgroundColor = .systemGray6
        backButton.setDimensions(width: 25, height: 25)
        
        addSubview(backButton)
        backButton.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 24, paddingBottom: 20)
        
        addSubview(backLabel)
        backLabel.centerY(inView: backButton)
        backLabel.anchor(left: backButton.rightAnchor, paddingLeft: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleDismissal() {
        print("BACK")
        delegate?.tappedBack()
    }
    
    // MARK: - Helpers
    
    func getStatusBarHeight() {
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            self.statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            self.statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        
        print("DEBUG: Height of status bar is \(statusBarHeight)")
    }
}
