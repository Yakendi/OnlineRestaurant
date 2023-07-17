//
//  CategoriesPageViewModel.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 17.07.2023.
//

import Foundation

final class CategoriesPageViewModel {
    
    // MARK: - Public
    var dishesListDidChange: (() -> Void)?
    var showError: ((Error) -> Void)?
    
    // MARK: - Private
    private let network = ServiceFactory.shared
    private(set) var dishesList: [Dishes] = [] {
        didSet {
            dishesListDidChange?()
        }
    }
    
    // MARK: - Public Methods
    func fetchDishesList() {
        network.allDishes { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.dishesList = data.dishes
            case .failure(let error):
                self.showError?(error)
            }
        }
    }
}

