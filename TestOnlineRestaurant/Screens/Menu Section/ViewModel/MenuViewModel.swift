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
    private let menuManager = MenuManager.shared
    private(set) var menu: [MenuModel] = [] {
        didSet {
            menuDidChange?()
        }
    }
    
    // MARK: - Binding
    func fetchMenu() {
//        network.allMenu { [weak self] result in
//            guard let self = self else { return }
//
//            switch result {
//            case .success(let data):
//                self.menu = data.dishes
//            case .failure(let error):
//                self.showError?(error)
//            }
//        }
        
        menuManager.getMenuList { [weak self] menuArray in
            guard let self = self else { return }
            
            self.menu = menuArray
        }
    }
}

extension MenuViewModel {
    func showPopUp(_ model: MenuModel) {
        let view = DetailPopUpViewFactory.create()
        view.keyWindow()
        view.configure(model)
    }
}
