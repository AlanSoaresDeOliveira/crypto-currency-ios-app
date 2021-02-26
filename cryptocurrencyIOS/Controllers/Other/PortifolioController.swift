//
//  PortifolioController.swift
//  cryptocurrencyIOS
//
//  Created by Alan Soares de Oliveira on 21/02/21.
//

import UIKit
import Charts

private let reuseIdentifier = "ChartCell"

class PortifolioController: UIViewController {
    
    // MARK: - Lifecycle
    
    let pages = [1, 2 ,3]
    
    private lazy var chartCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ChartViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        cv.isPagingEnabled = true
        return cv
    }()
    
    private lazy var previusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.systemPink, for: .normal)
        button.addTarget(self, action: #selector(hadlePrev), for: .touchUpInside)
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = .systemPink
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        return pc
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.systemPink, for: .normal)
        button.addTarget(self, action: #selector(hadleNext), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupBottomControlls()
        view.backgroundColor = .systemGray6
        
        let bottomControlsStackView = UIStackView(arrangedSubviews: [previusButton, pageControl, nextButton])
        bottomControlsStackView.distribution = .fillEqually
        view.addSubview(bottomControlsStackView)
//        bottomControlsStackView.anchor( left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingBottom: 250,height: 50)
        
        view.addSubview(chartCollection)
        chartCollection.backgroundColor = UIColor.clear
        chartCollection.delegate = self
        chartCollection.dataSource = self
        chartCollection.showsHorizontalScrollIndicator = false
        chartCollection.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor,
                             paddingTop: 100, paddingLeft: 12, paddingRight: 12, height: 350)
        
        bottomControlsStackView.anchor( top: chartCollection.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                                        paddingTop: 20, height: 50)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int((x / view.frame.width).rounded())
    }
    
    // MARK: - Helpers
    
    fileprivate func setupBottomControlls() {
        let bottomControlsStackView = UIStackView(arrangedSubviews: [previusButton, pageControl, nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    // MARK: - Actions
    
    @objc func hadleNext() {
        print("Trying to the next page")
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        chartCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc func hadlePrev() {
        print("Trying to the next page")
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        chartCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
}

// MARK: - UICollectionViewDataSourcefecycle

extension PortifolioController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChartViewCell
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PortifolioController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 24, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
