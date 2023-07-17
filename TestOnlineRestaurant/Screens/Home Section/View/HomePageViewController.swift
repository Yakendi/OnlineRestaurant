//
//  ViewController.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 27.06.2023.
//

import UIKit
import SnapKit

final class HomePageViewController: UIViewController {
    
    // MARK: - Private
    private var viewModel: HomePageViewModel!
    
    // MARK: - UI
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HomePageTableViewCell.self, forCellReuseIdentifier: HomePageTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

// MARK: - Setup
private extension HomePageViewController {
    func setup() {
        setupViews()
        setupViewModel()
        setupProfileButton()
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: BaseNavigationBar())
    }
    
    func setupViewModel() {
        viewModel = HomePageViewModel()
        
        viewModel.categoriesDidChange = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        viewModel.showError = { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.showAlert(title: NetworkErrorTypes.emptyData.localizedDescription)
            }
        }
        viewModel.fetchCategories()
    }
}

// MARK: - Table view data source and delegate
extension HomePageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomePageTableViewCell.identifier, for: indexPath) as! HomePageTableViewCell
        let selectedItem = viewModel.categories[indexPath.row]
        cell.configure(selectedItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = CategoriesPageViewFactory.create()
        let model = viewModel.categories[indexPath.row].name
        vc.pageTitle = model
        navigationController?.pushViewController(vc, animated: true)
    }
}
