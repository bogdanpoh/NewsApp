//
//  CollectionViewCell.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 12.04.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell, ViewLayoutableProtocol {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setupSubviews()
        defineLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        // do nothing
    }

    func setupSubviews() {
        // do nothing
    }

    func defineLayout() {
        // do nothing
    }

}
