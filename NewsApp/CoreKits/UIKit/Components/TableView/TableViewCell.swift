//
//  TableViewCell.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 10.04.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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

extension TableViewCell: ViewLayoutableProtocol {
    
    func setup() {
        
    }
    
    func setupSubviews() {
        
    }
    
    func defineLayout() {
        
    }
    
}
