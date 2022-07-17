//
//  NewsTableView.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 15.04.2021.
//

import UIKit

final class NewsCollectionView: View {
    
    // MARK: - UI
    
    private(set) var refreshControl = UIRefreshControl()
    
    private let collectionViewFlowLayout = UICollectionViewFlowLayout()
    
    private(set) lazy var collectionView =  UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        .make {
            $0.register(class: NewsCollectionViewCell.self)
            $0.refreshControl = refreshControl
        }
    
    // MARK: - Lifecycle
    
    override func setupSubviews() {
        super.setupSubviews()
        
        addSubview(collectionView)
    }
    
    override func defineLayout() {
        super.defineLayout()
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Override methods
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        
        collectionView.backgroundColor(color: theme.components.backgroundColor)
    }
    
}
