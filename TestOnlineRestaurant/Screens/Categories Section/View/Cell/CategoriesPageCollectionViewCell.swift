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
    private let wrapperView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = .dishImageColor
        return view
    }()
    
    private let dishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let dishNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .subtitle
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
        contentView.addSubview(wrapperView)
        wrapperView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(contentView.snp.width)
        }
        
        wrapperView.addSubview(dishImageView)
        dishImageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(10)
            make.trailing.bottom.equalToSuperview().offset(-10)
        }
        
        contentView.addSubview(dishNameLabel)
        dishNameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(wrapperView.snp.bottom).offset(5)
        }
    }
}
