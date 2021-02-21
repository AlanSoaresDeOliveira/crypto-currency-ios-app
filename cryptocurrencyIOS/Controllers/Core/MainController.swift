//
//  ViewController.swift
//  cryptocurrencyIOS
//
//  Created by Alan Soares de Oliveira on 21/02/21.

//

import UIKit

class MainController: UITabBarController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .white
        
        
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = .black
        itemAppearance.selected.iconColor = UIColor(named: "primarypurple")
        itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "primarypurple")!]
        
        appearance.stackedLayoutAppearance = itemAppearance
        appearance.inlineLayoutAppearance = itemAppearance
        appearance.compactInlineLayoutAppearance = itemAppearance
        
        tabBar.standardAppearance = appearance
    }
    
    // MARK: - Helpers
    
    func configureViewController() {
        
        let home = HomeController()
        let nav1 = templateNavigationController(image: UIImage(named: "home"), rootViewController: home, title: "Home")
        
        let portifolio = PortifolioController()
        let nav2 = templateNavigationController(image: UIImage(named: "pie_chart") , rootViewController: portifolio, title: "Portifólio")
        
        let transaction = TransactionCenterController()
        let nav3 = templateNavigationController(image: UIImage(named: "transaction"), rootViewController: transaction, title: "Tranferência")
        
        let prices = PricesController()
        let nav4 = templateNavigationController(image: UIImage(named: "line_graph"), rootViewController: prices, title: "valores")
        
        let settings = SettingsController()
        let nav5 = templateNavigationController(image: UIImage(named: "settings"), rootViewController: settings, title: "Ajustes")
        
        viewControllers = [nav1, nav2, nav3, nav4, nav5]
        
    }
    
    func templateNavigationController(image: UIImage?, rootViewController: UIViewController, title: String) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.navigationBar.isHidden = true
        nav.tabBarItem.image = image        
        nav.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        nav.title = title
        return nav
    }
}


