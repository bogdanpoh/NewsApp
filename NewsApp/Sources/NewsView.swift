//
//  NewsView.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import UIKit

final class NewsView: View {
    
    // MARK: - UI
    
    private lazy var contentStack = makeStackView(axis: .vertical) (
        label
    )
    
    private let label = Label()
        .text("Hello")
        .text(alignment: .center)
    
    // MARK: - Lifecycle
    
    override func setupSubviews() {
        super.setupSubviews()
        
        addSubview(contentStack)
    }
    
    override func defineLayout() {
        super.defineLayout()
        
        contentStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Override methods
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        
        backgroundColor(color: theme.components.backgroundColor)
    }
    
}
