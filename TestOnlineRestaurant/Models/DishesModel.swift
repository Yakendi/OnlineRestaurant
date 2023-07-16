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

struct Dishes: Codable {
    let id: Int
    let name: String
    let price: Int
    let weight: Int
    let desscription: String
    let imageURL: String
    
    private enum CodingKeys: String, CodingKey {
        case id, name, price, weight
        case desscription = "description"
        case imageURL = "image_url"
    }
}
