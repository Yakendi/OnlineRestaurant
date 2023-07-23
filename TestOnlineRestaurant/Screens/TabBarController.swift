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
    case accountPage
    
    var title: String {
        switch self {
        case .homePage:
            return "Главная"
        case .searchPage:
            return "Поиск"
        case .bagPage:
            return "Корзина"
        case .accountPage:
            return "Аккаунт"
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
        case .accountPage:
            return UIImage(named: "profilePage") ?? UIImage()
        }
    }
}

final class TabBarController: UITabBarController {
    
    // MARK: - Public
    let homePage = HomePageCoordinator()
    let searchPage = SearchPageCoordinator()
    let bagPage = BagPageCoordinator()
    let accountPage = AccountPageCoordinator()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        tabBar.tintColor = .main
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
        
        accountPage.navigationController.tabBarItem = UITabBarItem(
            title: TabBarItems.accountPage.title,
            image: TabBarItems.accountPage.image,
            tag: 4
        )
        
        setViewControllers([homePage.navigationController, searchPage.navigationController, bagPage.navigationController, accountPage.navigationController], animated: true)
    }
}
