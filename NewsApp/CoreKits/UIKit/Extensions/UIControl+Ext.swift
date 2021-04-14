//
//  UIControl+Ext.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 12.04.2021.
//

import UIKit

extension UIControl {
    
    func addTarget(_ target: Any, action: Selector) {
        self.addTarget(target, action: action, for: .touchUpInside)
    }
    
}
