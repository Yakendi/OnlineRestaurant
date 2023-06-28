//
//  ViewController.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 27.06.2023.
//

import UIKit
import SnapKit

class HomePageViewController: UIViewController {
    
    // MARK: - Private
    private var categoriesModel: [Categories] = []
    private let network = ServiceFactory.shared

    // MARK: - UI
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HomePageTableViewCell.self, forCellReuseIdentifier: HomePageTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        fetchCategories()
    }
    
    // MARK: - Networking
    func fetchCategories() {
        network.allCategories { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.categoriesModel = data.сategories
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.showAlert(title: NetworkErrorTypes.emptyData.errorDescription ?? "Error")
                }
            }
        }
    }
}

// MARK: - Setup views
private extension HomePageViewController {
    func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - Table view data source and delegate
extension HomePageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoriesModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomePageTableViewCell.identifier, for: indexPath) as! HomePageTableViewCell
        let selectedItem = categoriesModel[indexPath.row]
        cell.configure(selectedItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
