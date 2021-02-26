//
//  CryptoDetailView.swift
//  cryptocurrencyIOS
//
//  Created by Alan Soares de Oliveira on 26/02/21.
//

import UIKit

private let reuseIdentifier = "CryptoDetailCell"

class CryptoDetailView: UIView {
    
    // MARK: - Properties
    
    lazy var colletionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .red
        colletionView.register(CryptodetailCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let selectedIndexPath = IndexPath(row: 0, section: 0)
        colletionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .left)
        
        addSubview(colletionView)
        colletionView.addConstraintsToFillView(self)
//        colletionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CryptoDetailView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CryptoDetailOption.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CryptodetailCell
        
        let option = CryptoDetailOption(rawValue: indexPath.row)
        cell.option = option
        
        return cell
    }
}

extension CryptoDetailView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let count = CGFloat(CryptoDetailOption.allCases.count)
        return CGSize(width: frame.width / count, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
