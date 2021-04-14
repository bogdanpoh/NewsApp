//
//  VerticalScrollView.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 12.04.2021.
//

import UIKit

final class VerticalScrollView: View {
    
    // MARK: - UI
    
    let scrollContentStack = makeStackView(.vertical)()
    let innerScrollView = SKitScrollView()
    
    // MARK: - Lifecycle
    
    override func setupSubviews() {
        super.setupSubviews()
        
        addSubview(innerScrollView)
        innerScrollView.addSubview(scrollContentStack)
    }
    
    override func defineLayout() {
        super.defineLayout()
        
        innerScrollView.snp.makeConstraints {
            $0.top.bottom.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        scrollContentStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }
    
}
