//
//  MenuManager.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 29.08.2023.
//

import Foundation

typealias MenuListCompletion = ([MenuModel]) -> Void

final class MenuManager {
    
    // MARK: - Singletone
    static var shared = MenuManager()
    
    // MARK: - Private
    private let network = ServiceFactory.shared
    private(set) var menuListArray: [MenuModel] = []
    
    // MARK: -
    private func convertData(_ response: [DishesModel]) {
        menuListArray = response.flatMap { item in
            item.dishes.map { dish in
                MenuModel(
                    id: dish.id,
                    name: dish.name,
                    price: dish.price,
                    weight: dish.weight,
                    description: dish.description,
                    image: dish.imageURL
                )
            }
        }
    }
    
    func getMenuList(completion: @escaping MenuListCompletion) {
        network.allMenu { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                convertData([data])
                completion(self.menuListArray)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
