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
    
    private(set) lazy var tableView = TableView()
        .make {
            $0.register(class: NewsTableViewCell.self)
            $0.setEmptyFooter()
            $0.refreshControl = refreshControl
            $0.separatorInset = UIEdgeInsets(horizontal: 16)
            $0.setRowHeight(310)
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
        tableView.backgroundColor(color: theme.components.backgroundColor)
    }
    
}
