//
//  HomePageTableViewCell.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 27.06.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class HomePageTableViewCell: UITableViewCell {
    
    // MARK: - Identifier
    static var identifier: String {
        return String(describing: self)
    }
    
    // MARK: - UI
    private let wrapperView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = .clear
        return view
    }()
    
    private let categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray6
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.font = .sfpdM20
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Constructor
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configurator
    func configure(_ model: Categories) {
        
        // image
        categoryImageView.kf.indicatorType = .activity
        categoryImageView.kf.setImage(with: URL(string: model.imageURL))
        
        // labels
        categoryNameLabel.text = model.name
    }
}

// MARK: - Setup views
private extension HomePageTableViewCell {
    func setupViews() {
        contentView.addSubview(wrapperView)
        wrapperView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
            make.height.equalTo(148)
        }
        
        wrapperView.addSubview(categoryImageView)
        categoryImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        wrapperView.addSubview(categoryNameLabel)
        categoryNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(12)
        }
    }
}
