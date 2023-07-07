//
//  PopUpView.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 07.07.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class PopUpView: UIView {
    
    // MARK: - Public
//    var model: Dishes!
    
    // MARK: - UI
    private let wrapperView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .systemBackground
        view.clipsToBounds = true
        view.sizeToFit()
        return view
    }()
    
    private let imageWrapperView: UIView = {
        let view = UIView()
        view.backgroundColor = .dishImageColor
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    // image
    private let dishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // labels
    private let dishNameLabel: UILabel = {
        let label = UILabel()
        label.font = .dishName
        return label
    }()
    
    private let dishPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .subtitle
        return label
    }()
    
    private let dishWeightLabel: UILabel = {
        let label = UILabel()
        label.font = .subtitle
        label.textColor = .subtitleColor
        return label
    }()
    
    private let dishDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .subtitle
        label.textColor = .subtitleColor2
        label.numberOfLines = 0
        return label
    }()
    
    // buttons
    private let addToBagButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .mainColor
        button.layer.cornerRadius = 10
        button.setTitle("Добавить в корзину", for: .normal)
        button.titleLabel?.font = .dishName
        return button
    }()
    
    private let addToFavoritesButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favoritesButton"), for: .normal)
        return button
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "closeButton"), for: .normal)
        button.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Constructor
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = UIScreen.main.bounds
        backgroundColor = .popUpShadowColor
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fillElements(_ model: Dishes) {
        // image
        dishImageView.kf.indicatorType = .activity
        dishImageView.kf.setImage(with: URL(string: model.imageURL))
        
        // labels
        dishNameLabel.text = model.name
        dishPriceLabel.text = "\(model.price)₽"
        dishWeightLabel.text = "· \(model.weight)г"
        dishDescriptionLabel.text = model.description
    }
    
    @objc private func dismiss() {
        removeFromSuperview()
    }
}

// MARK: - Setup views
private extension PopUpView {
    func setupViews() {
        addSubview(wrapperView)
        wrapperView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            
        }
        
        wrapperView.addSubview(imageWrapperView)
        imageWrapperView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(232)
        }
        
        imageWrapperView.addSubview(dishImageView)
        dishImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(56)
            make.top.equalToSuperview().offset(14)
            make.trailing.equalToSuperview().offset(-56)
            make.bottom.equalToSuperview().offset(-14)
        }
        
        imageWrapperView.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.width.equalTo(40)
        }
        
        imageWrapperView.addSubview(addToFavoritesButton)
        addToFavoritesButton.snp.makeConstraints { make in
            make.trailing.equalTo(closeButton.snp.leading).offset(-8)
            make.top.equalToSuperview().offset(8)
            make.height.width.equalTo(40)
        }
        
        wrapperView.addSubview(dishNameLabel)
        dishNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageWrapperView.snp.leading)
            make.top.equalTo(imageWrapperView.snp.bottom).offset(8)
            make.trailing.equalTo(imageWrapperView.snp.trailing)
        }
        
        wrapperView.addSubview(dishPriceLabel)
        dishPriceLabel.snp.makeConstraints { make in
            make.leading.equalTo(dishNameLabel.snp.leading)
            make.top.equalTo(dishNameLabel.snp.bottom).offset(8)
        }

        wrapperView.addSubview(dishWeightLabel)
        dishWeightLabel.snp.makeConstraints { make in
            make.leading.equalTo(dishPriceLabel.snp.trailing).offset(3)
            make.top.equalTo(dishPriceLabel.snp.top)
        }
        
        wrapperView.addSubview(dishDescriptionLabel)
        dishDescriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageWrapperView.snp.leading)
            make.top.equalTo(dishPriceLabel.snp.bottom).offset(8)
            make.trailing.equalTo(imageWrapperView.snp.trailing)
        }
        
        wrapperView.addSubview(addToBagButton)
        addToBagButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(dishDescriptionLabel.snp.bottom).offset(16)
            make.trailing.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
    }
}
