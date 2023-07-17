//
//  BagPageViewModel.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 17.07.2023.
//

import Foundation

final class BagPageViewModel {
    
    // MARK: - Public
    var orderList: [Dishes] {
        return moveToBagManager.orderListArray
    }
    var orderListDidChange: (() -> Void)?
    
    // MARK: - Private
    private let moveToBagManager = MoveToBagManager.shared
    
    // MARK: - Constructor
    init() {
        moveToBagManager.delegate = self
    }
    
    // MARK: - Public Methods
    func placeOrder() {
        // Place order logic
    }
}

// MARK: - MoveToBagDelegate
extension BagPageViewModel: MoveToBagManagerDelegate {
    func updateOrderList() {
        orderListDidChange?()
    }
}

