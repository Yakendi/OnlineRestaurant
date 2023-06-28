//
//  TabBarController.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 27.06.2023.
//

import UIKit

enum TabBarItems {
    case homePage
    case searchPage
    case bagPage
    
    var title: String {
        switch self {
        case .homePage:
            return "Главная"
        case .searchPage:
            return "Поиск"
        case .bagPage:
            return "Корзина"
        }
    }
    
    var image: UIImage {
        switch self {
        case .homePage:
            return UIImage(named: "homePage") ?? UIImage()
        case .searchPage:
            return UIImage(named: "searchPage") ?? UIImage()
        case .bagPage:
            return UIImage(named: "bagPage") ?? UIImage()
        }
    }
}

final class TabBarController: UITabBarController {
    
    // MARK: - Public
    let homePage = HomePageCoordinator()
    let searchPage = SearchPageCoordinator()
    let bagPage = BagPageCoordinator()
    
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
        
        searchPage.navigationController.tabBarItem = UITabBarItem(
            title: TabBarItems.searchPage.title,
            image: TabBarItems.searchPage.image,
            tag: 2
        )
        
        bagPage.navigationController.tabBarItem = UITabBarItem(
            title: TabBarItems.bagPage.title,
            image: TabBarItems.bagPage.image,
            tag: 3
        )
        
        setViewControllers([homePage.navigationController, searchPage.navigationController, bagPage.navigationController], animated: true)
    }
}
