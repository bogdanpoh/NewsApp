//
//  NewsCollectionViewCell.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 15.04.2021.
//

import UIKit

final class NewsCollectionViewCell: CollectionViewCell {
    
    struct State {
        var image: UIImage?
        var author: String
        var title: String
    }
    
    // MARK: - UI
    
    private let imageView = ImageView()
        .setContentMode(.scaleToFill)
        .backgroundColor(color: .gray)
    
    private let authorLabel = Label()
        .textColor(.white)
    
    private let titleLabel = Label()
        .set(numberOfLines: 2)
        .textColor(.white)
    
    // MARK: - Lifecycle
    
    override func setupSubviews() {
        super.setupSubviews()
        
        setCornerRadius(20)
        maskToBounds(true)
        
        contentView.addSubview(imageView)
        imageView.addSubviews(authorLabel, titleLabel)
    }

    override func defineLayout() {
        super.defineLayout()
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        authorLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(UIEdgeInsets(aTop: 10))
            $0.leading.equalToSuperview().inset(UIEdgeInsets(aLeft: 10))
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
                .inset(UIEdgeInsets.init(aLeft: 10, aBottom: 10, aRight: 10))
        }
    }
    
}

// MARK: - Set

extension NewsCollectionViewCell {
    
    @discardableResult
    func set(state: State) -> Self {
        imageView.setImage(state.image)
        authorLabel.text(state.author)
        titleLabel.text(state.title)
        return self
    }
    
}
