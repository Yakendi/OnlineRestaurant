//
//  CategoriesModel.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 28.06.2023.
//

import Foundation

struct FoodCategoriesModel: Codable {
    let categories: [Categories]
    
    private enum CodingKeys: String, CodingKey {
        case categories = "Categories"
    }
}

struct Categories: Codable {
    let id: Int
    let name: String
    let imageURL: String
    
    private enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "image_url"
    }
}
