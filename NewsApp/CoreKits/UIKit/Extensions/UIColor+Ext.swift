//
//  UIColor+Ext.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 10.04.2021.
//

import UIKit

// MARK: - Custom initializers

extension UIColor {
    
    convenience init(rgb: CGFloat, a: CGFloat = 1.0) {
        self.init(red: rgb / 255.0, green: rgb / 255.0, blue: rgb / 255.0, alpha: a)
    }
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
        let r = (hex >> 16) & UInt32(0xff)
        let g = (hex >> 8)  & UInt32(0xff)
        let b = hex         & UInt32(0xff)
        
        self.init(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b), a: alpha)
    }
    
}

extension UIColor {
    
    /// return random color
    static var rnd: UIColor {
        return UIColor(hex: arc4random())
    }
    
}

extension UIColor {

    convenience init(hex: String, alpha: CGFloat = 1.0) {
        guard hex.hasPrefix("#") else {
            self.init(red: 0, green: 0, blue: 0, alpha: alpha)
            return
        }

        let start = hex.index(hex.startIndex, offsetBy: 1)
        let hexColor = String(hex[start...])

        if hexColor.count == 6 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0

            if scanner.scanHexInt64(&hexNumber) {
                let r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                let g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                let b = CGFloat(hexNumber & 0x0000ff) / 255

                self.init(red: r, green: g, blue: b, alpha: alpha)
                return
            }
        }

        self.init(red: 0, green: 0, blue: 0, alpha: alpha)
    }
    
}

extension UIColor {
    
    func isLight(threshold: Float = 0.5) -> Bool? {
        let originalCGColor = self.cgColor
        let RGBCGColor = originalCGColor.converted(to: CGColorSpaceCreateDeviceRGB(),
                                                   intent: .defaultIntent, options: nil)
        guard let components = RGBCGColor?.components else { return nil }
        guard components.count >= 3 else { return nil }
        
        let brightness = Float(((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000)
        let isLight = brightness > threshold
        
        return isLight
    }
    
}
