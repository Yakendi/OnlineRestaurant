//
//  BagPageViewModel.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 17.07.2023.
//

import Foundation

final class CartPageViewModel {
    
    // MARK: - Public
    var orderList: [MenuModel] {
        return addToCartManager.cartArray
    }
    var orderListDidChange: (() -> Void)?
    
    // MARK: - Private
    private let addToCartManager = CartManager.shared
    
    // MARK: - Constructor
    init() {
        addToCartManager.delegate = self
    }
}

// MARK: - MoveToBagDelegate
extension CartPageViewModel: CartManagerDelegate {
    func updateOrderList() {
        orderListDidChange?()
    }
}
