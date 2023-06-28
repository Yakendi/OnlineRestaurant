//
//  Constants.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 27.06.2023.
//

import UIKit

enum Constants {
    
    enum Fonts {
        static var heading: UIFont {
            UIFont(name: "SFProDisplay-Regular", size: 20) ?? UIFont()
        }
        
        static var subtitle: UIFont {
            UIFont(name: "SFProDisplay-Regular", size: 14) ?? UIFont()
        }
    }
    
    enum Colors {
        static var mainColor: UIColor {
            UIColor(hex: "3364E0") ?? UIColor()
        }
        
        static var dishImageColor: UIColor {
            UIColor(hex: "F8F7F5") ?? UIColor()
        }
    }
}
