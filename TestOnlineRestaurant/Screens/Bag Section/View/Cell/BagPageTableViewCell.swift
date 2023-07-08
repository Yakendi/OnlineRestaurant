//
//  BagPageTableViewCell.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 08.07.2023.
//

import UIKit
import SnapKit

final class BagPageTableViewCell: UITableViewCell {
    
    // MARK: - Identifier
    static var identifier: String {
        return String(describing: self)
    }
    
    // MARK: - UI
    // image
    private let imageWrapperView: UIView = {
        let view = UIView()
        view.backgroundColor = .dishImageColor
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        return view
    }()
    
    private let dishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    
    // labels
    private let labelsWrapperView = UIView()
    
    private let dishNameLabel = UILabel()
    private let dishPriceLabel = UILabel()
    private let dishWeightLabel = UILabel()
    private let orderCountLabel = UILabel()
    
    // buttons
    private let buttonsWrapperView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .orderCountColor
        return view
    }()
    
    private let decreaseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "decreaseButton"), for: .normal)
        return button
    }()
    
    private let increaseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "increaseButton"), for: .normal)
        return button
    }()
    
    // MARK: - Constructor
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        fillElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    func fillElements() {
        dishNameLabel.text = "Рис с овощами"
        dishPriceLabel.text = "490 ₽"
        dishWeightLabel.text = "· 550г"
        dishWeightLabel.textColor = .subtitleColor
        [dishNameLabel, dishPriceLabel, dishWeightLabel].forEach {
            $0.font = .subtitle
        }
        orderCountLabel.text = "1"
        orderCountLabel.font = .orderCount
    }
}

// MARK: - Setup views
private extension BagPageTableViewCell {
    func setupViews() {
        
        // image
        contentView.addSubview(imageWrapperView)
        imageWrapperView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(8)
            make.width.height.equalTo(62)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        imageWrapperView.addSubview(dishImageView)
        dishImageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(6)
            make.trailing.bottom.equalToSuperview().offset(-6)
        }
        
        // labels
        contentView.addSubview(labelsWrapperView)
        labelsWrapperView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(imageWrapperView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-140)
        }
        
        labelsWrapperView.addSubview(dishNameLabel)
        dishNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        labelsWrapperView.addSubview(dishPriceLabel)
        dishPriceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(dishNameLabel.snp.bottom).offset(4)
        }
        
        labelsWrapperView.addSubview(dishWeightLabel)
        dishWeightLabel.snp.makeConstraints { make in
            make.leading.equalTo(dishPriceLabel.snp.trailing).offset(3)
            make.top.equalTo(dishPriceLabel.snp.top)
            make.bottom.equalToSuperview()
        }
        
        // buttons
        contentView.addSubview(buttonsWrapperView)
        buttonsWrapperView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(99)
            make.height.equalTo(32)
        }
        
        buttonsWrapperView.addSubview(decreaseButton)
        decreaseButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(6)
            make.top.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
            make.width.height.equalTo(24)
        }
        
        buttonsWrapperView.addSubview(increaseButton)
        increaseButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(-6)
            make.bottom.equalToSuperview().offset(-4)
            make.width.height.equalTo(24)
        }
        
        buttonsWrapperView.addSubview(orderCountLabel)
        orderCountLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
