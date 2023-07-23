//
//  BagPageViewController.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 28.06.2023.
//

import UIKit
import SnapKit

final class BagPageViewController: UIViewController {
    
    // MARK: - Private
    private var viewModel: BagPageViewModel!
    
    // MARK: - UI
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            BagPageTableViewCell.self,
            forCellReuseIdentifier: BagPageTableViewCell.identifier
        )
        tableView.rowHeight = UITableView.automaticDimension
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
        return button
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

// MARK: - Setup
private extension BagPageViewController {
    
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
        
        orderButton.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
    }
    
    private func setupViewModel() {
        viewModel = BagPageViewModel()
        viewModel.orderListDidChange = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    @objc private func orderButtonTapped() {
        viewModel.placeOrder()
    }
}

// MARK: - Table view data source and delegate
extension BagPageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.orderList.count == 0 {
            orderButton.isHidden = true
        }
        
        return viewModel.orderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BagPageTableViewCell.identifier, for: indexPath) as! BagPageTableViewCell
        return cell
    }
}

