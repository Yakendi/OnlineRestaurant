//
//  BagPageViewController.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 28.06.2023.
//

import UIKit
import SnapKit

final class CartPageViewController: UIViewController {
    
    // MARK: - Private
    private var viewModel: CartPageViewModel!
    private let cartManager = CartManager.shared
    
    // MARK: - UI
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CartPageTableViewCell.self)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let orderButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = .main
        button.setTitle("Оплатить", for: .normal)
        button.titleLabel?.font = .sfpdM16
        button.isHidden = true
        return button
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

// MARK: - Setup
private extension CartPageViewController {
    
    func setup() {
        setupViews()
        setupViewModel()
        setupProfileButton()
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: BaseNavigationBar())
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(orderButton)
        orderButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(48)
        }        
    }
    
    private func setupViewModel() {
        viewModel = CartPageViewModel()
        viewModel.orderListDidChange = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}

// MARK: - Table view data source and delegate
extension CartPageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !viewModel.orderList.isEmpty {
            orderButton.isHidden = false
        }
        
        return viewModel.orderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CartPageTableViewCell.self, indexPath: indexPath)
        let model = viewModel.orderList[indexPath.row]
        cell.configure(model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] _, _, _ in
            guard let self = self else { return }
            
            let selectedPicture = self.cartManager.cartArray[indexPath.row]
            self.cartManager.removeFromCart(selectedPicture, isNeedReload: false)

            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            if viewModel.orderList.isEmpty {
                orderButton.isHidden = true
            }
        }

        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }
}

