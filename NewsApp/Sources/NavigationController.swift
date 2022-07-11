//
//  NavigationController.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import UIKit

final class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

// MARK: - Themeable

extension NavigationController: Themeable {
    
    func apply(theme: AppTheme) {
        navigationBar.backgroundColor = theme.components.navigationBar.background
    }
    
}
