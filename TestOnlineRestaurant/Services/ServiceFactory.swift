//
//  ServiceFactory.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 28.06.2023.
//

import Foundation

final class ServiceFactory {
    
    // MARK: - Singleton
    static let shared = ServiceFactory()
    
    // MARK: - Public
    let networkLayer: NetworkLayer
    
    // MARK: - Constructor
    init(networkLayer: NetworkLayer = .init()) {
        self.networkLayer = networkLayer
    }
    
    // MARK: - Requests
    func allCategories(completion: @escaping Handler<FoodCategoriesModel>) {
        networkLayer.makeRequest(to: .categories(), completion: completion)
    }
    
    func allMenu(completion: @escaping Handler<[DishesModel]>) {
        networkLayer.makeRequest(to: .menu(), completion: completion)
    }
}
