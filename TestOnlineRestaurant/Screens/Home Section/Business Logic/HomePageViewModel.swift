//
//  HomePageViewModel.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 17.07.2023.
//

import Foundation

final class HomePageViewModel {
    
    // MARK: - Public
    var categoriesDidChange: (() -> Void)?
    var showError: ((Error) -> Void)?
    
    // MARK: - Private
    private let network = ServiceFactory.shared
    private(set) var categories: [Categories] = [] {
        didSet {
            categoriesDidChange?()
        }
    }
    
    // MARK: - Networking
    func fetchCategories() {
        network.allCategories { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.categories = data.сategories
            case .failure(let error):
                self.showError?(error)
            }
        }
    }
}

