//
//  AppCoordinator.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 27.06.2023.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: - Public
    var window: UIWindow
    var navigationController = UINavigationController()
    
    // MARK: - Constructor
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let controller = TabBarController()
        
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
}
