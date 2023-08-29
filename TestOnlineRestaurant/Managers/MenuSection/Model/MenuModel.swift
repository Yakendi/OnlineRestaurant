//
//  MenuModel.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 06.08.2023.
//

import Foundation

struct MenuModel: Equatable {
    let id: Int
    let name: String
    let price: Int
    let weight: Int
    let description: String
    let image: String
    let isFavorite: Bool = false
}
