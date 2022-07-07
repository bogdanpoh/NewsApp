//
//  SettingsView.swift
//  NewsApp
//
//  Created by Bohdan Pokhidnia on 04.07.2022.
//

import UIKit

final class SettingsView: View {
    
    // MARK: - UI
    
    private(set) var settingsTableView = SettingsTableView()
    
    // MARK: - Lifecycle
    
    override func setupSubviews() {
        super.setupSubviews()
        
        addSubview(settingsTableView)
    }
    
    override func defineLayout() {
        super.defineLayout()
        
        settingsTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(layoutMarginsGuide).inset(UIEdgeInsets(aTop: 36))
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Override methods
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        
        backgroundColor(color: theme.components.settings.background)
        backgroundColor = theme.components.settings.background
    }
    
}
