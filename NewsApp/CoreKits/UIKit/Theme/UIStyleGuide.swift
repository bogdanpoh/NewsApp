//
//  UIStyleGuide.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 10.04.2021.
//

import UIKit

enum UIStyleGuide {
    
    enum Typography {
        static func roboto(weight: UIFont.Weight, size: CGFloat) -> UIFont {
            let sWeight = stringFrom(weight: weight)
            guard let font = UIFont(name: "Roboto-" + sWeight, size: size) else {
                assertionFailure("missing required font")
                return UIFont.systemFont(ofSize: size)
            }
            return font
        }
        
        private static func stringFrom(weight: UIFont.Weight) -> String {
            switch weight {
            case .light:
                return "Light"

            case .regular:
                return "Regular"

            case .medium:
                return "Medium"

            case .bold:
                return "Bold"

            default:
                assertionFailure("missing required weight")
                return stringFrom(weight: .regular)
            }
        }
    }

}

extension UIStyleGuide {
    
    struct ColorPalette {
        static let white: UIColor = .white
        static let black: UIColor = .init(hex: "#080808")
        static let tblack: UIColor = .init(hex: "#000000")
        static let dBlack: UIColor = .init(hex: "#090909")
        static let tinyBlack: UIColor = .init(hex: "#212226")
        static let blue: UIColor = .init(hex: "#007AFF")
        static let gray: UIColor = .init(hex: "#C4C4C4")
        static let lightGray: UIColor = .init(hex: "#767676")
        static let spaceGray: UIColor = .init(hex: "#F2F2F6")
        static let darkGray: UIColor = .init(hex: "#2C2C2E")
        static let systemGray: UIColor = .init(hex: "#929299")
    }
    
}

extension UIFont {
    
    ///roboto, .bold, size: 18
    static let title1 = UIStyleGuide.Typography.roboto(weight: .bold, size: 18)
    
    ///roboto, .regular, size: 18
    static let titleFeed = UIStyleGuide.Typography.roboto(weight: .regular, size: 20)
    
    ///roboto, .light, size: 14
    static let authorFeed = UIStyleGuide.Typography.roboto(weight: .light, size: 14)
    
    ///roboto, .medium, size: 18
    static let titleDetails = UIStyleGuide.Typography.roboto(weight: .medium, size: 18)
    
    ///roboto, .light, size: 12
    static let authorDetails = UIStyleGuide.Typography.roboto(weight: .light, size: 14)
    
    ///roboto, .regular, size: 16
    static let descriptionDetails = UIStyleGuide.Typography.roboto(weight: .regular, size: 16)
    
    ///roboto, .medium, size: 18
    static let buttonDetails = UIStyleGuide.Typography.roboto(weight: .medium, size: 18)
    
}
