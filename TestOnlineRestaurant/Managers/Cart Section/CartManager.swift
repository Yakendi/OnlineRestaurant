//
//  MoveToBagManager.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 09.07.2023.
//

import Foundation

protocol CartManagerDelegate: AnyObject {
    func updateOrderList()
}

final class CartManager {
    
    // MARK: - Singletone
    static let shared = CartManager()
    
    // MARK: - Public
    weak var delegate: CartManagerDelegate?
    
    // MARK: - Private
    private let storageManager = DataBaseManager()
    private(set) var cartArray: [MenuModel] = []
    
    // MARK: - Constructor
    init() {
        cartArray = storageManager.fetchCartArray()
    }
    
    // MARK: - Update order list
    func addToCart(_ model: MenuModel) {
        cartArray.append(model)
        delegate?.updateOrderList()
        storageManager.saveToCartModel(model)
    }
    
    func removeFromCart(_ model: MenuModel, isNeedReload: Bool) {
        cartArray.removeAll { $0 == model }
        storageManager.removeFromCartModel(model)
        
        if isNeedReload {
            delegate?.updateOrderList()
        }
    }
    
    func changeFavoriteStatus(_ model: MenuModel) {
        storageManager.updateFavoriteStatus(model)
    }
}
