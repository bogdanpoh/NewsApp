//
//  SettingsTableView.swift
//  NewsApp
//
//  Created by Bohdan Pokhidnia on 06.07.2022.
//

import UIKit

final class SettingsTableView: View {
    
    // MARK: - UI
    
    private(set) lazy var tableView = TableView(frame: .zero, style: .insetGrouped)
        .make {
            $0.register(class: SettingsTableViewCell.self)
            $0.register(classForHeaderFooter: SettingsHeaderFooterView.self)
            $0.sectionFooterHeight = 30
            $0.separatorStyle = .none
            $0.showsVerticalScrollIndicator = false
            $0.isScrollEnabled = false
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
