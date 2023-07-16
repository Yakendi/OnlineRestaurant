//
//  UIApplication + extensions.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 16.07.2023.
//

import UIKit

extension UIApplication {
    var keyWindow: UIWindow? {
        if #available(iOS 13, *) {
            return connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .map { $0 as? UIWindowScene }
                .compactMap { $0 }
                .first?.windows
                .filter { $0.isKeyWindow }
                .first
        } else {
            return delegate?.window ?? windows.first(where: { $0.isKeyWindow })
        }
    }
}
