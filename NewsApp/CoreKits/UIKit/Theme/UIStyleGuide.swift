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

            case .semibold:
                return "Semibold"

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
        static let dBlack: UIColor = .init(hex: "#090909")
    }
    
}

extension UIFont {
    
    ///roboto, .bold, size: 18
    static let title1 = UIStyleGuide.Typography.roboto(weight: .bold, size: 18)
    
}
