//
//  DetailsView.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 16.04.2021.
//

import UIKit

final class DetailsView: View {
    
    // MARK: - UI
    
    private lazy var contentStack = makeStackView(axis: .vertical) (
        label
    )
    
    private let label = Label()
        .text("Details")
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
