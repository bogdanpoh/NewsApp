//
//  Themeable.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 10.04.2021.
//

import UIKit

protocol Themeable: class {
    func apply(theme: AppTheme)
}

// MARK: - UITraitEnvironment

extension Themeable where Self: UITraitEnvironment {
    
    var themeProvider: AppThemeProvider {
        return LegacyThemeProvider.shared
    }
    
}
