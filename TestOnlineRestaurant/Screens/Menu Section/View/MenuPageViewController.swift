//
//  CategoriesViewController.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 28.06.2023.
//

import UIKit
import SnapKit

final class MenuPageViewController: UIViewController {
    
    // MARK: - Public
    var pageTitle: String? {
        didSet {
            navigationItem.title = pageTitle
        }
    }
    var model: [CollectionViewCellModel] = []
    
    // MARK: - Private
    private var categoriesViewModel: CategoriesViewModel!
    private var menuViewModel: MenuViewModel!
    
    // MARK: - UI
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
        collectionView.register(
            MenuCollectionViewCell.self,
            forCellWithReuseIdentifier: MenuCollectionViewCell.identifier
        )
        collectionView.register(
            CategoriesCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier
        )
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private var categories: [ListOfCategories] = [
        ListOfCategories(name: "Всё меню"),
        ListOfCategories(name: "Салаты"),
        ListOfCategories(name: "C рисом"),
        ListOfCategories(name: "C рыбой"),
        ListOfCategories(name: "Роллы")
    ]
}

// MARK: - Setup views
private extension MenuPageViewController {
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
        menuViewModel = MenuViewModel()
        menuViewModel.fetchMenu()
        
        menuViewModel.menuDidChange = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        menuViewModel.showError = { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.showAlert(title: error.localizedDescription)
            }
        }
    }
}

// MARK: - Setup collection view layout
private extension MenuPageViewController {

    func createCategoriesSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .absolute(35))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(itemSize.widthDimension.dimension), heightDimension: .absolute(35))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16)
        section.interGroupSpacing = 8

        return section
    }

    func createMenuSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute((view.frame.size.width - 48) / 3), heightDimension: .absolute(view.frame.size.width / 2.55))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(itemSize.heightDimension.dimension))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(8)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 14
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16)

        return section
    }
    
    func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, _ in
            return sectionIndex == 0 ? self.createCategoriesSectionLayout() : self.createMenuSectionLayout()
        })
        return layout
    }
}

// MARK: - Collection view data source and delegate
extension MenuPageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
        //        model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        menuViewModel.menu.count
        if section == 0 {
            return categories.count
        } else {
            return menuViewModel.menu.count
        }
        //        switch model[section] {
        //        case .categories(_):
        //            return categoriesViewModel.categories.count
        //        case .menu(_):
        //            return menuViewModel.menu.count
        //        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        switch model[indexPath.section] {
        //        case .categories(_):
        //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: indexPath) as! CategoriesCollectionViewCell
        //            let categories = categoriesViewModel.categories[indexPath.item]
        //            cell.configure(categories)
        //            return cell
        //        case .menu(_):
        //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as! MenuCollectionViewCell
        //            let selectedItem = menuViewModel.menu[indexPath.item]
        //            cell.configure(selectedItem)
        //            return cell
        //        }
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: indexPath) as! CategoriesCollectionViewCell
//            let categories = categoriesViewModel.categories[indexPath.item]
            let categories = categories[indexPath.item]
            cell.configure(categories)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as! MenuCollectionViewCell
            let selectedItem = menuViewModel.menu[indexPath.item]
            cell.configure(selectedItem)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = menuViewModel.menu[indexPath.item]
        let view = DetailPopUpViewFactory.create()
        view.fillElements(selectedItem)
        view.show()
    }
}
