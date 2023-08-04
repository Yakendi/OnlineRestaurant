//
//  CollectionViewCellModel.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 18.07.2023.
//

import Foundation

enum CollectionSectionType {
    case categories
    case menu
}

struct SectionType {
    let type: CollectionSectionType
    let data: [Any]
}
