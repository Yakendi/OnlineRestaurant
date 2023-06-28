//
//  SearchPageCoordinator.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 28.06.2023.
//

import UIKit

final class SearchPageCoordinator: Coordinator {
    
    // MARK: - Public
    var navigationController: UINavigationController
    
    // MARK: - Constructor
    init() {
        self.navigationController = UINavigationController()
        
        start()
    }
    
    func start() {
        let controller = SearchPageViewFactory.create()
        self.navigationController.setViewControllers([controller], animated: true)
    }
}
