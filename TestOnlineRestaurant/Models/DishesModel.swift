//
//  DishesModel.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 28.06.2023.
//

import Foundation

struct DishesModel: Codable {
    let dishes: [Dishes]
}

struct Dishes: Codable, Equatable {
    let id: Int
    let name: String
    let price: Int
    let weight: Int
    let description: String
    let imageURL: String
    
    private enum CodingKeys: String, CodingKey {
        case id, name, price, weight, description
        case imageURL = "image_url"
    }
}
