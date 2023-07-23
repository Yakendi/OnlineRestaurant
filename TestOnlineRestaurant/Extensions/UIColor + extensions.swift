//
//  UIColor + extensions.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 28.06.2023.
//

import UIKit

extension UIColor {
    
    // MARK: - Hex converter
    convenience init?(hex: String) {
            var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
            
            let length = hexSanitized.count
            
            var rgb: UInt64 = 0
            
            var red: CGFloat = 0.0
            var green: CGFloat = 0.0
            var blue: CGFloat = 0.0
            var alpha: CGFloat = 1.0
            
            guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
            
            if length == 6 {
                red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
                green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
                blue = CGFloat(rgb & 0x0000FF) / 255.0
            } else if length == 8 {
                red = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
                green = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
                blue = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
                alpha = CGFloat(rgb & 0x000000FF) / 255.0
            } else {
                return nil
            }
            
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        }
    
    // MARK: - Custom colors
    static let main = UIColor(hex: "3364E0")
    static let gray1 = UIColor(hex: "F8F7F5")
    static let gray2 = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
    static let gray3 = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    static let gray4 = UIColor(red: 0, green: 0, blue: 0, alpha: 0.65)
    static let gray5 = UIColor(hex: "EFEEEC")
}
