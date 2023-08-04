//
//  HomePageCoordinator.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 27.06.2023.
//

import UIKit

protocol MoveToMenu: AnyObject {
    func move(_ pageTitle: String)
}

final class HomePageCoordinator: Coordinator {
    
    // MARK: - Public
    var navigationController: UINavigationController
    
    // MARK: - Constructor
    init() {
        self.navigationController = UINavigationController()
        
        start()
    }
    
    // MARK: -
    func start() {
        let controller = HomePageViewFactory.create()
        controller.delegate = self
        self.navigationController.setViewControllers([controller], animated: true)
    }
}

extension HomePageCoordinator: MoveToMenu {
    func move(_ pageTitle: String) {
        let controller = MenuPageViewFactory.create()
        controller.pageTitle = pageTitle
        self.navigationController.pushViewController(controller, animated: true)
    }
}
