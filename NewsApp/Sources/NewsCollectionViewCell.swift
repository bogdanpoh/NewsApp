//
//  NewsCollectionViewCell.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 15.04.2021.
//

import UIKit

final class NewsCollectionViewCell: CollectionViewCell {
    
    struct State {
        var imageUrl: String?
        var author: String
        var title: String
    }
    
    // MARK: - UI
    
    private let imageView = KFImageView()
        .setContentMode(.scaleToFill)
        .backgroundColor(color: .gray)
    
    private let authorLabel = Label()
        .textColor(.black)
    
    private let authorBackgroundView = makeBackgroundView(backgroundColor: .white)
    
    private let titleLabel = Label()
        .set(numberOfLines: 2)
        .textColor(.black)
    
    private let titleBackgroundView = makeBackgroundView(backgroundColor: .white)
    
    // MARK: - Lifecycle
    
    override func setupSubviews() {
        super.setupSubviews()
        
        setCornerRadius(20)
        maskToBounds(true)
        
        contentView.addSubview(imageView)
        imageView.addSubviews(authorBackgroundView, titleBackgroundView)
        authorBackgroundView.addSubview(authorLabel)
        titleBackgroundView.addSubview(titleLabel)
    }

    override func defineLayout() {
        super.defineLayout()
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        authorBackgroundView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(UIEdgeInsets(aTop: 10))
            $0.leading.equalToSuperview().inset(UIEdgeInsets(aLeft: 10))

            $0.width.equalTo(authorLabel.snp.width).offset(10)
            $0.height.equalTo(authorLabel.snp.height).offset(10)
        }

        authorLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        titleBackgroundView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
                .inset(UIEdgeInsets.init(aLeft: 10, aBottom: 10, aRight: 10))

            $0.width.equalTo(titleLabel.snp.width).offset(10)
            $0.height.equalTo(titleLabel.snp.height).offset(10)
        }

        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(UIEdgeInsets(aLeft: 10))
        }
    }
    
}

// MARK: - Set

extension NewsCollectionViewCell {
    
    @discardableResult
    func set(state: State) -> Self {
        imageView.setImage(path: state.imageUrl, placeholder: R.image.newsPlaceholder())
        authorLabel.text(state.author)
        titleLabel.text(state.title)
        return self
    }
    
}

// MARK: - BackgroundView Factory

private extension NewsCollectionViewCell {
    
    static func makeBackgroundView(backgroundColor: UIColor) -> View {
        return View()
            .backgroundColor(color: backgroundColor)
            .setCornerRadius(5)
            .maskToBounds(true)
    }
    
}
