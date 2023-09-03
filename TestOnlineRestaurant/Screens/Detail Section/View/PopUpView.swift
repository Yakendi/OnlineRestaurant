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
        
    // MARK: - Private
    private var model: MenuModel!
    private var isFavorite: Bool = false
    private let cartManager = CartManager.shared
    
    // MARK: - UI
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray2
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .systemBackground
        view.clipsToBounds = true
        view.sizeToFit()
        return view
    }()
    
    private let imageWrapperView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray1
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
        label.font = .sfpdM16
        return label
    }()
    
    private let dishPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .sfpdR14
        return label
    }()
    
    private let dishWeightLabel: UILabel = {
        let label = UILabel()
        label.font = .sfpdR14
        label.textColor = .gray2
        return label
    }()
    
    private let dishDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .sfpdR14
        label.textColor = .gray4
        label.numberOfLines = 0
        return label
    }()
    
    // buttons
    private lazy var addToCartButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(addToCartButtonAction), for: .touchUpInside)
        button.backgroundColor = .main
        button.layer.cornerRadius = 10
        button.setTitle("Добавить в корзину", for: .normal)
        button.titleLabel?.font = .sfpdM16
        return button
    }()
    
    private lazy var addToFavoritesButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favoritesButton"), for: .normal)
        button.addTarget(self, action: #selector(favoritesButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "closeButton"), for: .normal)
        button.addTarget(self, action: #selector(dismissPopUp), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Constructor
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = UIScreen.main.bounds
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configurator
    func configure(_ model: MenuModel) {
        // image
        dishImageView.kf.indicatorType = .activity
        dishImageView.kf.setImage(with: URL(string: model.image))
        
        // labels
        dishNameLabel.text = model.name
        dishPriceLabel.text = "\(model.price)₽"
        dishWeightLabel.text = "· \(model.weight)г"
        dishDescriptionLabel.text = model.description
    }
    
    // MARK: - Actions
    @objc func favoritesButtonAction() {
        if isFavorite {
            addToFavoritesButton.setImage(UIImage(named: "favoritesButton"), for: .normal)
            isFavorite = false
        } else {
            addToFavoritesButton.setImage(UIImage(named: "favoritesButtonRed"), for: .normal)
            isFavorite = true
        }
    }
    
    @objc func addToCartButtonAction() {
        addToCartButton.zoomIn()
        
        guard let model = model else {
            print("Model is nil")
            return
        }
        cartManager.addToCart(model)
    }
    
    @objc private func dismissPopUp() {
        removeFromSuperview()
    }
}

// MARK: - Setup views
private extension PopUpView {
    func setup() {
        setupViews()
        setupGestureRecognizer()
    }
    func setupViews() {
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            
        }
        
        contentView.addSubview(imageWrapperView)
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
        
        contentView.addSubview(dishNameLabel)
        dishNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageWrapperView.snp.leading)
            make.top.equalTo(imageWrapperView.snp.bottom).offset(8)
            make.trailing.equalTo(imageWrapperView.snp.trailing)
        }
        
        contentView.addSubview(dishPriceLabel)
        dishPriceLabel.snp.makeConstraints { make in
            make.leading.equalTo(dishNameLabel.snp.leading)
            make.top.equalTo(dishNameLabel.snp.bottom).offset(8)
        }

        contentView.addSubview(dishWeightLabel)
        dishWeightLabel.snp.makeConstraints { make in
            make.leading.equalTo(dishPriceLabel.snp.trailing).offset(3)
            make.top.equalTo(dishPriceLabel.snp.top)
        }
        
        contentView.addSubview(dishDescriptionLabel)
        dishDescriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageWrapperView.snp.leading)
            make.top.equalTo(dishPriceLabel.snp.bottom).offset(8)
            make.trailing.equalTo(imageWrapperView.snp.trailing)
        }
        
        contentView.addSubview(addToCartButton)
        addToCartButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(dishDescriptionLabel.snp.bottom).offset(16)
            make.trailing.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
    }
    
    func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        backgroundView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        removeFromSuperview()
    }
}
