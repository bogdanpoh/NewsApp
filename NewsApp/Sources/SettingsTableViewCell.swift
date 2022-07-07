//
//  SettingsTableViewCell.swift
//  NewsApp
//
//  Created by Bohdan Pokhidnia on 06.07.2022.
//

import UIKit

final class SettingsTableViewCell: SettingsTableViewSingleCell {
    
    // MARK: - Lifecycle
    
    override func setup() {
        super.setup()
        
        clipsToBounds = false
        layer.cornerRadius = 0
    }
    
}
