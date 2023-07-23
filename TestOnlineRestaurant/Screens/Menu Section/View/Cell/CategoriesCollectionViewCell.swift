//
//  CategoriesCollectionViewCell.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 19.07.2023.
//

import UIKit
import SnapKit

final class CategoriesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Identifier
    static var identifier: String {
        return String(describing: self)
    }
    
    // MARK: - UI
    private let categoryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .main
        button.titleLabel?.font = .sfpdR14
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    let categoryButtonLabel: UILabel = {
        let label = UILabel()
        label.font = .sfpdR14
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Constructor
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configurator
    func configure(_ model: ListOfCategories) {
        categoryButtonLabel.text = model.name
    }
}

// MARK: - Setup views
private extension CategoriesCollectionViewCell {
    func setupViews() {
        contentView.addSubview(categoryButton)
        categoryButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        categoryButton.addSubview(categoryButtonLabel)
        categoryButtonLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}
