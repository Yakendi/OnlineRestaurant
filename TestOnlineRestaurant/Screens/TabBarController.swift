//
//  TabBarController.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 27.06.2023.
//

import UIKit

enum TabBarItems {
    case homePage
    
    var title: String {
        switch self {
        case .homePage:
            return "Главная"
        }
    }
    
    var image: UIImage {
        switch self {
        case .homePage:
            return UIImage(named: "homePage") ?? UIImage()
        }
    }
}

final class TabBarController: UITabBarController {
    
    // MARK: - Public
    let homePage = HomePageCoordinator()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupTabs()
    }
}

// MARK: - Setup tabs
private extension TabBarController {
    func setupTabs() {
        homePage.navigationController.tabBarItem = UITabBarItem(
            title: TabBarItems.homePage.title,
            image: TabBarItems.homePage.image,
            tag: 1
        )
        
        setViewControllers([homePage.navigationController], animated: true)
    }
}
