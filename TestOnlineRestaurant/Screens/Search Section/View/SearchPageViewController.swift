//
//  SearchPageViewController.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 28.06.2023.
//

import UIKit

class SearchPageViewController: UIViewController {
    
    // MARK: - UI
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationItem.title = "Поиск"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
