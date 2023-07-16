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
    private var bagModel: [Dishes] = []
    private let moveToBagManager = MoveToBagManager.shared
    
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
        button.backgroundColor = .mainColor
        button.setTitle("Оплатить", for: .normal)
        button.titleLabel?.font = .dishName
        return button
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupProfileButton()
        setupViews()
    }
}

// MARK: - Setup views
private extension BagPageViewController {
    func setupViews() {
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: BaseNavigationBar())
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.dataSource = self
        tableView.delegate = self
        moveToBagManager.delegate = self
        
        view.addSubview(orderButton)
        orderButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(48)
        }
    }
}

// MARK: - Table view data source and delegate
extension BagPageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        moveToBagManager.orderListArray.count
        if bagModel.count == 0 {
            orderButton.isHidden = true
        }
        return bagModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BagPageTableViewCell.identifier, for: indexPath) as! BagPageTableViewCell
//        let model = moveToBagManager.orderListArray[indexPath.row]
//        cell.configure(model)
        return cell
    }
}

// MARK: - MoveToBagDelegate
extension BagPageViewController: MoveToBagManagerDelegate {
    func updateOrderList() {
        self.tableView.reloadData()
    }
}
