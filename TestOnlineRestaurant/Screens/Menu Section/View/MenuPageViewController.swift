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
    
    // MARK: - Private
    private var categoriesViewModel = CategoriesViewModel()
    private var menuViewModel: MenuViewModel!
    private var sections: [SectionType] = []
    private var categorySelectedIndex = 0
    
    // MARK: - UI
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
        collectionView.register(MenuCollectionViewCell.self)
        collectionView.register(CategoriesCollectionViewCell.self)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

// MARK: - Setup
private extension MenuPageViewController {
    func setup() {
        setupViews()
        setupNavigationBar()
        setupMenuViewModel()
        setupSections()
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
    
    func setupMenuViewModel() {
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
    
    func setupSections() {
        sections = [
            SectionType(type: .categories, data: [categoriesViewModel.categories]),
            SectionType(type: .menu, data: [menuViewModel.menu])
        ]
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
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            switch self.sections[sectionIndex].type {
            case .categories:
                return self.createCategoriesSectionLayout()
            case .menu:
                return self.createMenuSectionLayout()
            }
        })
        return layout
    }
}

// MARK: - Collection view data source and delegate
extension MenuPageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = sections[section].type

        switch sectionType {
        case .categories:
            return categoriesViewModel.categories.count
        case .menu:
            return menuViewModel.menu.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = sections[indexPath.section].type
        
        switch sectionType {
        case .categories:
            let cell = collectionView.dequeue(CategoriesCollectionViewCell.self, indexPath: indexPath)
            let categories = categoriesViewModel.categories[indexPath.item]
            cell.configure(categories, isSelected: indexPath.item == categorySelectedIndex)
            return cell
        case .menu:
            let cell = collectionView.dequeue(MenuCollectionViewCell.self, indexPath: indexPath)
            let selectedItem = menuViewModel.menu[indexPath.item]
            cell.configure(selectedItem)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = sections[indexPath.section].type
        
        switch sectionType {
        case .categories:
            categorySelectedIndex = indexPath.item
            collectionView.reloadData()
        case .menu:
            let selectedItem = menuViewModel.menu[indexPath.item]
            menuViewModel.showPopUp(selectedItem)
        }
    }
}
