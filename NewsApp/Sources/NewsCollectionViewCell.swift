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
        var author: String?
        var title: String
    }
    
    let topCellOffset: CGFloat = 18
    let leftCellOffset: CGFloat = 16
    let rightCellOffset: CGFloat = 16
    
    // MARK: - UI
    
    private let containerView = View()
        .backgroundColor(color: UIStyleGuide.ColorPalette.white)
        .setCornerRadius(15)
        .maskToBounds(true)
    
    private(set) var articleImageView = KFImageView()
        .setContentMode(.scaleToFill)
    
    private(set) var titleLabel = Label()
        .set(numberOfLines: 2)
    
    private(set) var authorLabel = Label()
    
    // MARK: - Lifecycle
    
    override func setupSubviews() {
        super.setupSubviews()
        
        contentView.addSubview(containerView)
        containerView.addSubviews(
            articleImageView,
            titleLabel,
            authorLabel
        )
    }
    
    override func defineLayout() {
        super.defineLayout()
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(aTop: topCellOffset, aLeft: leftCellOffset, aRight: rightCellOffset))
        }
        
        articleImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(articleImageView.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(horizontal: 10))
        }
        
        authorLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(horizontal: 10))
            $0.bottom.equalToSuperview().inset(UIEdgeInsets(aBottom: 10))
        }
    }
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        
        let feedCellStyle = theme.components.feed.cell
        backgroundColor(color: theme.components.backgroundColor)
        containerView.backgroundColor(color: feedCellStyle.background)
        
        titleLabel
            .textColor(feedCellStyle.title.color)
            .text(font: feedCellStyle.title.font)
        
        authorLabel
            .textColor(feedCellStyle.author.color)
            .text(font: feedCellStyle.author.font)
    }
    
}

// MARK: - Set

extension NewsCollectionViewCell {
    
    @discardableResult
    func set(state: State) -> Self {

        articleImageView.setImage(path: state.imageUrl, placeholder: R.image.newsPlaceholder()) { [weak articleImageView] result in
            switch result {
            case .failure(_):
                articleImageView?.setImage(R.image.newsPlaceholder())
                
            default:
                break
            }
        }
        
        authorLabel.text(state.author ?? R.string.localizable.feedWithoutAuthor())
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

// MARK: - Setup shadow

private extension NewsCollectionViewCell {
    
    ///Deprecated
    func applyShadow() {
        let shadowWidth = bounds.width
        let shadowHeight = bounds.height / 2
        let rect = CGRect(x: 0, y: shadowHeight, width: shadowWidth, height: shadowHeight)
        layer.shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: 10).cgPath
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIStyleGuide.ColorPalette.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 8
    }
    
}
