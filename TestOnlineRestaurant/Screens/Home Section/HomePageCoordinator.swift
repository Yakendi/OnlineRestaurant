//
//  HomePageCoordinator.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 27.06.2023.
//

import UIKit

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
        self.navigationController.setViewControllers([controller], animated: true)
    }
}
