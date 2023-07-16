//
//  CategoriesViewController.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 28.06.2023.
//

import UIKit
import SnapKit

class CategoriesViewController: UIViewController {
    
    // MARK: - Public
    var pageTitle: String? {
        didSet {
            navigationItem.title = pageTitle
        }
    }
    
    // MARK: - Private
    private var dishesModel: [Dishes] = []
    private let network = ServiceFactory.shared
    
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
        setupNavigationBar()
        fetchDishesList()
    }
    
    // MARK: - Fetch dishes list
    func fetchDishesList() {
        network.allDishes { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.dishesModel = data.dishes
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
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
private extension CategoriesViewController {
    func setup() {
        setupViews()
        setupNavigationBar()
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
}

// MARK: - Collection view data source and delegate
extension CategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dishesModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesPageCollectionViewCell.identifier, for: indexPath) as! CategoriesPageCollectionViewCell
        let selectedItem = dishesModel[indexPath.item]
        cell.configure(selectedItem)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = dishesModel[indexPath.item]
        let view = DetailPopUpViewFactory.create()
        view.fillElements(selectedItem)
        view.show()
    }
}
