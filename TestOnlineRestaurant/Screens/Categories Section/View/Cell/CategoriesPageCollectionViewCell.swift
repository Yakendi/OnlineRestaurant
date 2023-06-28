//
//  CategoriesPageCollectionViewCell.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 28.06.2023.
//

import UIKit
import UIKit

final class CategoriesPageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Identifier
    static var identifier: String {
        return String(describing: self)
    }
    
    // MARK: - UI
    private let dishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = Constants.Colors.dishImageColor
        return imageView
    }()
    
    private let dishNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.blue.cgColor
        label.font = Constants.Fonts.subtitle
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
    
    func configure(_ model: Dishes) {
        
        // image
        dishImageView.kf.indicatorType = .activity
        dishImageView.kf.setImage(with: URL(string: model.imageURL))
        
        // label
        dishNameLabel.text = model.name
    }
}

// MARK: - Setup views
private extension CategoriesPageCollectionViewCell {
    func setupViews() {
        contentView.addSubview(dishImageView)
        dishImageView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(contentView.snp.width)
        }
        
        contentView.addSubview(dishNameLabel)
        dishNameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(dishImageView.snp.bottom).offset(5)
        }
    }
}
