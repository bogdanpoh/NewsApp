//
//  TableViewHeaderFooterView.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 10.04.2021.
//

import UIKit

class TableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setup()
        setupSubviews()
        defineLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - ViewLayoutableProtocol

extension TableViewHeaderFooterView: ViewLayoutableProtocol {
    
    func setup() {
        
    }
    
    func setupSubviews() {
        
    }
    
    func defineLayout() {
        
    }
    
}
