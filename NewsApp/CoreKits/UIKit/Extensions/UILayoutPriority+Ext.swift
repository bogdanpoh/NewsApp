//
//  UILayoutPriority+Ext.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import UIKit

extension UILayoutPriority {
    
    static var lowest: Self {
        return .init(rawValue: 1)
    }
    
    static var almostRequired: Self {
        return .init(rawValue: 999)
    }
    
}
