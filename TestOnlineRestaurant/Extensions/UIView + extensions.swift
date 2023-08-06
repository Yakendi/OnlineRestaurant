//
//  UIView + extensions.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 06.08.2023.
//

import UIKit

extension UIView {
    
    func zoomIn(duration: TimeInterval = 0.12) {
        self.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
        UIView.animate(withDuration: duration,
                       delay: 0.08,
                       usingSpringWithDamping: 1.5,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            self.transform = .identity
        }
    }
    
    func keyWindow() {
        UIApplication.shared.keyWindow?.addSubview(self)
    }
}
