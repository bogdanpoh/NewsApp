//
//  SettingsTableView.swift
//  NewsApp
//
//  Created by Bohdan Pokhidnia on 06.07.2022.
//

import UIKit

final class SettingsTableView: View {
    
    // MARK: - UI

    private lazy var footerView = SettingsHeaderFooterView()
        .set(R.string.localizable.settingsCountryFooter(), style: .footer)
        .make {
            $0.frame.size.height = 50
        }
    
    private(set) lazy var tableView = TableView()
        .make {
            $0.register(class: SettingsTableViewSingleCell.self)
            $0.sectionHeaderHeight = 30
            $0.sectionFooterHeight = 50
            $0.separatorStyle = .none
            $0.showsVerticalScrollIndicator = false
            $0.isScrollEnabled = false
            $0.tableFooterView = footerView
        }
    
    // MARK: - Lifecycle
    
    override func setupSubviews() {
        super.setupSubviews()
        
        addSubview(tableView)
    }
    
    override func defineLayout() {
        super.defineLayout()
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Override methods
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        
        backgroundColor(color: theme.components.backgroundColor)
        tableView.backgroundColor = .systemGroupedBackground
    }
    
}
