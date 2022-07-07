//
//  SettingsMenuItem.swift
//  NewsApp
//
//  Created by Bohdan Pokhidnia on 06.07.2022.
//

import UIKit

enum SettingsMenuItem: Int, CaseIterable {
    case country
}

// MARK: - UI-items

extension SettingsMenuItem {
    
    var title: String {
        switch self {
        case .country:
            return R.string.localizable.settingsCountry()
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .country:
            return UIImage(systemName: "globe.europe.africa.fill")
        }
    }
    
    var accessoryType: UITableViewCell.AccessoryType {
        switch self {
        case .country:
            return .disclosureIndicator
        }
    }
    
}
