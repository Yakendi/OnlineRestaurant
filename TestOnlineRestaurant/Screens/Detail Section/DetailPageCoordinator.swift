//
//  DetailPageCoordinator.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 07.07.2023.
//

import UIKit

final class DetailPopUpCoordinator: Coordinator {
    
    // MARK: - Public
    var navigationController: UINavigationController
    
    // MARK: - Constructor
    init() {
        self.navigationController = UINavigationController()
        
        start()
    }
    
    func start() {
    }
}
