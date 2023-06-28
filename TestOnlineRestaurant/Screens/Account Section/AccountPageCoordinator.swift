//
//  AccountPageCoordinator.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 28.06.2023.
//

import UIKit

final class AccountPageCoordinator: Coordinator {
    
    // MARK: - Public
    var navigationController: UINavigationController
    
    // MARK: - Constructor
    init() {
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let controller = AccountPageViewFactory.create()
        self.navigationController.setViewControllers([controller], animated: true)
    }
}
