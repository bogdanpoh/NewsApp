//
//  UILabel+Ext.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import UIKit

extension UILabel {
    
    @discardableResult
    func adjustsFontSizeToFitWidth(scale: CGFloat) -> Self {
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = scale
        return self
    }
    
}
