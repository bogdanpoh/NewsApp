//
//  SettingsCountryView.swift
//  NewsApp
//
//  Created by Bohdan Pokhidnia on 06.07.2022.
//

import UIKit

final class SettingsCountryView: View {
    
    // MARK: - UI
    
    private(set) var settingsCountryTableView = SettingsCountryTableView()
    
    // MARK: - Lifecycle
    
    override func setupSubviews() {
        super.setupSubviews()
        
        addSubview(settingsCountryTableView)
    }
    
    override func defineLayout() {
        super.defineLayout()
        
        settingsCountryTableView.snp.makeConstraints {
            $0.edges.equalTo(layoutMarginsGuide).inset(UIEdgeInsets(aTop: 12))
        }
    }
    
    // MARK: - Override methods
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        
        backgroundColor(color: theme.components.settings.background)
        backgroundColor = theme.components.settings.background
    }
    
}
