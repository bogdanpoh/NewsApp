//
//  TappableView.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 12.04.2021.
//

import UIKit

final class TappableView: View {
    
    var onTap: (() -> Void)?
    
    // MARK: - UI Components
    
    private lazy var tapEvent = UITapGestureRecognizer(target: self, action: #selector(tapView))
        
    // MARK: - Lifecycle
    
    override func setup() {
        super.setup()
        
        addGestureRecognizer(tapEvent)
    }
    
}

// MARK: - User interactions

private extension TappableView {
    
    @objc
    func tapView() {
        onTap?()
    }
    
}
