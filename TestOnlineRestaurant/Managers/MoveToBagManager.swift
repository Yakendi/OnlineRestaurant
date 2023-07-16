//
//  MoveToBagManager.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 09.07.2023.
//

import Foundation

protocol MoveToBagManagerDelegate: AnyObject {
    func updateOrderList()
}

final class MoveToBagManager {
    
    // MARK: - Singletone
    static let shared = MoveToBagManager()
    
    // MARK: - Public
    var orderListArray: [Dishes] = []
    weak var delegate: MoveToBagManagerDelegate?
    
    func addToBag(_ model: Dishes) {
        self.orderListArray.append(model)
        self.delegate?.updateOrderList()
    }
}
