//
//  SettingsTableViewSingleCell.swift
//  NewsApp
//
//  Created by Bohdan Pokhidnia on 06.07.2022.
//

import UIKit

class SettingsTableViewSingleCell: TableViewCell {
    
    struct State {
        let title: String
        let image: UIImage?
        let accesoryType: UITableViewCell.AccessoryType?
    }
    
    // MARK: - UI
    
    private var config: UIListContentConfiguration?
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        config = defaultContentConfiguration()
    }
    
    // MARK: - Initializers
    
    override func setup() {
        super.setup()
        
        layer.cornerRadius = 12
        clipsToBounds = true
    }
    
    // MARK: - Override methods
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        
        backgroundColor(color: theme.components.settings.backgroundCell)
    }
    
}

// MARK: - Set

extension SettingsTableViewSingleCell {
    
    @discardableResult
    func set(state: State) -> Self {
        config?.text = state.title
        config?.image = state.image
        
        if let accecoryView = state.accesoryType {
            accessoryType = accecoryView
        }
        
        contentConfiguration = config
        return self
    }
    
}
