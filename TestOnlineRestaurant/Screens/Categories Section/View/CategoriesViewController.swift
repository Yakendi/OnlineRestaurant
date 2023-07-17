//
//  CategoriesViewController.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 28.06.2023.
//

import UIKit
import SnapKit

final class CategoriesViewController: UIViewController {
    
    // MARK: - Public
    var pageTitle: String? {
        didSet {
            navigationItem.title = pageTitle
        }
    }
    
    // MARK: - Private
    private var viewModel: CategoriesPageViewModel!
    
    // MARK: - UI
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 14
        layout.itemSize = CGSize(
            width: (view.frame.size.width - 48) / 3,
            height: (view.frame.size.width) / 2.55
        )
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(
            CategoriesPageCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoriesPageCollectionViewCell.identifier
        )
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

// MARK: - Setup views
private extension CategoriesViewController {
    func setup() {
        setupViews()
        setupNavigationBar()
        setupViewModel()
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupViewModel() {
        viewModel = CategoriesPageViewModel()
        
        viewModel.dishesListDidChange = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        viewModel.showError = { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.showAlert(title: error.localizedDescription)
            }
        }
        
        viewModel.fetchDishesList()
    }
}

// MARK: - Collection view data source and delegate
extension CategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.dishesList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesPageCollectionViewCell.identifier, for: indexPath) as! CategoriesPageCollectionViewCell
        let selectedItem = viewModel.dishesList[indexPath.item]
        cell.configure(selectedItem)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = viewModel.dishesList[indexPath.item]
        let view = DetailPopUpViewFactory.create()
        view.fillElements(selectedItem)
        view.show()
    }
}
