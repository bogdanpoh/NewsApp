//
//  NewsTableView.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 15.04.2021.
//

import UIKit

final class NewsTableView: View {
    
    // MARK: - UI
    
    private(set) var refreshControl = UIRefreshControl()
    
    private(set) lazy var tableView: TableView = {
        let tableView = TableView()
        tableView.register(class: NewsTableViewCell.self)
        tableView.setEmptyFooter()
        tableView.refreshControl = refreshControl
        tableView.separatorInset = UIEdgeInsets(horizontal: 16)
        tableView.setRowHeight(310)
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func setupSubviews() {
        super.setupSubviews()
        
        addSubview(tableView)
    }
    
    override func defineLayout() {
        super.defineLayout()
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
//            $0.top.equalTo(layoutMarginsGuide)
//            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Override methods
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        
        backgroundColor(color: theme.components.backgroundColor)
        
        tableView.backgroundColor(color: theme.components.backgroundColor)
    }
    
}
