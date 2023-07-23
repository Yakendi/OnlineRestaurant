//
//  CollectionViewCellModel.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 18.07.2023.
//

import Foundation

enum CollectionViewCellModel {
    case categories(_ model: [ListOfCategories])
    case menu(_ model: [Dishes])
}
