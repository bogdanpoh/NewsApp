//
//  FeedView.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import UIKit

final class FeedView: View {
    
    // MARK: - UI
    
    private(set) var newsCollectionView = NewsCollectionView()
    
    private var placeholderView: PlaceholderView?
    
    // MARK: - Lifecycle
    
    override func setupSubviews() {
        super.setupSubviews()
        
        addSubview(newsCollectionView)
    }
    
    override func defineLayout() {
        super.defineLayout()
        
        newsCollectionView.snp.makeConstraints {
            $0.top.equalTo(layoutMarginsGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Override methods
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        
        backgroundColor(color: theme.components.backgroundColor)
    }
    
}

// MARK: - Set

extension FeedView {
    
    @discardableResult
    func showPlaceholder() -> Self {
        guard placeholderView == nil else {
            return self
        }
        
        let placeholder = PlaceholderView()
            .set(title: R.string.localizable.placeholderLoading())
        newsCollectionView.addSubview(placeholder)
        
        placeholder.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        placeholderView = placeholder
        
        return self
    }
    
    @discardableResult
    func hidePlaceholder() -> Self {
        placeholderView?.removeFromSuperview()
        placeholderView = nil
        return self
    }
    
}
