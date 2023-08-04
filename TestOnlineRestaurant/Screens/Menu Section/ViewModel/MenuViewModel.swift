//
//  CategoriesPageViewModel.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 17.07.2023.
//

import Foundation

final class MenuViewModel {
    
    // MARK: - Public
    var menuDidChange: (() -> Void)?
    var showError: ((Error) -> Void)?
    
    // MARK: - Private
    private let network = ServiceFactory.shared
    private(set) var menu: [Dishes] = [] {
        didSet {
            menuDidChange?()
        }
    }
    
    // MARK: - Binding
    func fetchMenu() {
        network.allMenu { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.menu = data.dishes
            case .failure(let error):
                self.showError?(error)
            }
        }
    }
}

extension MenuViewModel {
    func showPopUp(_ model: Dishes) {
        let view = DetailPopUpViewFactory.create()
        view.fillElements(model)
        view.show()
    }
}
