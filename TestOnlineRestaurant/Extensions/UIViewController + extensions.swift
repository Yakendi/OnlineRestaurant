//
//  UIViewController + extensions.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 28.06.2023.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    
    func setupNavigationBar() {
        setupBackButton()
        setupTitle()
        setupProfileButton()
    }
    
    func setupBackButton() {
        let backButton = UIImage(named: "backButton")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButton, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func setupTitle() {
        let titleAttributes = [NSAttributedString.Key.font: UIFont.navigationBarTitle]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes as [NSAttributedString.Key : Any]
    }
    
    func setupProfileButton() {
        let profileButton = UIButton(type: .custom)
        profileButton.setImage(UIImage(named: "profileImage"), for: .normal)
        profileButton.snp.makeConstraints { make in
            make.height.width.equalTo(44)
        }
        let profileBarButtonItem = UIBarButtonItem(customView: profileButton)
        navigationItem.rightBarButtonItem = profileBarButtonItem
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
