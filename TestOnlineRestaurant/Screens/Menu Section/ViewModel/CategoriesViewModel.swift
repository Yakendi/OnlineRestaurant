//
//  CategoriesViewModel.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 20.07.2023.
//

import Foundation

final class CategoriesViewModel {
    
    // MARK: - Private
    private(set) var categories: [ListOfCategories] = [
        ListOfCategories(name: "Всё меню"),
        ListOfCategories(name: "Салаты"),
        ListOfCategories(name: "C рисом"),
        ListOfCategories(name: "C рыбой"),
        ListOfCategories(name: "Роллы")
    ]
}
