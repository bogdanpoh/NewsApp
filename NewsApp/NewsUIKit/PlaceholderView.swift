//
//  PlaceholderView.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 06.05.2021.
//

import UIKit

final class PlaceholderView: View {
    
    // MARK: - UI
    
    private lazy var contentStack = makeStackView(axis: .vertical) (
        spinner,
        placeholderLabel
    )
    
    private var spinner = UIActivityIndicatorView(style: .large)
    
    private let placeholderLabel = Label()
        .text(alignment: .center)
    
    // MARK: - Lifecycle
    
    override func setup() {
        super.setup()
        
        spinner.startAnimating()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        addSubview(contentStack)
    }
    
    override func defineLayout() {
        super.defineLayout()
        
        contentStack.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: - Override methods
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        
        backgroundColor(color: theme.components.backgroundColor)
        
        let placeholderStyle = theme.components.placeholder
        
        placeholderLabel
            .textColor(placeholderStyle.color)
            .text(font: placeholderStyle.font)
    }
    
}

// MARK: - Set

extension PlaceholderView {
    
    @discardableResult
    func set(title: String) -> Self {
        placeholderLabel.text(title)
        return self
    }
    
}
