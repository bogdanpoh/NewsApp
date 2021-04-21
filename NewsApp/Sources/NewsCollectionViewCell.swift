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
    
    private let containerView = View()
        .backgroundColor(color: UIStyleGuide.ColorPalette.white)
        .setCornerRadius(20)
        .maskToBounds(true)
        
    private let imageView = KFImageView()
        .setContentMode(.scaleToFill)
        .backgroundColor(color: .gray)
    
    private let authorLabel = Label()
        .textColor(.black)
    
    private let titleLabel = Label()
        .set(numberOfLines: 2)
        .textColor(.black)
    
    // MARK: - Lifecycle
    
    override func setup() {
        super.setup()
        
        addShadow()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        contentView.addSubview(containerView)
        containerView.addSubviews(
            imageView,
            titleLabel,
            authorLabel
        )
    }

    override func defineLayout() {
        super.defineLayout()
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(horizontal: 10))
        }
        
        authorLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(horizontal: 10))
            $0.bottom.equalToSuperview().inset(UIEdgeInsets(aBottom: 10))
        }
    }
    
}

// MARK: -

private extension NewsCollectionViewCell {
    
    func addShadow() {
        let shadowWidth = bounds.width
        let shadowHeight = bounds.height / 2 + 5
        let rect = CGRect(x: 0, y: shadowHeight, width: shadowWidth, height: shadowHeight)
        layer.shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: 10).cgPath
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIStyleGuide.ColorPalette.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 6
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
