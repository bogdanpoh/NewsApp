//
//  DetailsView.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 16.04.2021.
//

import UIKit

final class DetailsView: View {
    
    // MARK: - UI
    
    private lazy var contentStack = makeStackView(axis: .vertical, spacing: 10) (
        titleLabel,
        articleImage,
        publishedAtLabel,
        descriptionLabel,
        emptyView,
        openButton
    )
    
    private let titleLabel = Label()
        .enableMultilines()
        .text(alignment: .center)
    
    private let articleImage = ImageView()
        .backgroundColor(color: .gray)
        .setContentMode(.scaleToFill)
        .setCornerRadius(20)
        .maskToBounds(true)
    
    private let publishedAtLabel = Label()
        .text(alignment: .center)
    
    private let descriptionLabel = Label()
        .enableMultilines()
    
    private let emptyView = View()
    
    private let openButton = ButtonsFactory.makeActionButton()
        .titleColor(.black)
    
    // MARK: - Lifecycle
    
    override func setupSubviews() {
        super.setupSubviews()
        
        addSubview(contentStack)
    }
    
    override func defineLayout() {
        super.defineLayout()
        
        contentStack.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(UIEdgeInsets(aTop: 20, aLeft: 18, aRight: 18))
            $0.bottom.equalTo(layoutMarginsGuide).inset(UIEdgeInsets(aBottom: 10))
        }
        
        articleImage.snp.makeConstraints {
            $0.height.equalTo(200)
        }
        
        openButton.snp.makeConstraints {
            $0.height.equalTo(60)
        }
    }
    
    // MARK: - Override methods
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        
        backgroundColor(color: theme.components.backgroundColor)
        
        let detailsStyle = theme.components.details
        
        titleLabel
            .textColor(detailsStyle.title.color)
            .text(font: detailsStyle.title.font)
        
        publishedAtLabel
            .textColor(detailsStyle.publishedAt.color)
            .text(font: detailsStyle.publishedAt.font)
        
        descriptionLabel
            .textColor(detailsStyle.description.color)
            .text(font: detailsStyle.description.font)
        
        openButton
            .titleColor(detailsStyle.button.text.color)
            .titleColor(detailsStyle.button.text.color.withAlphaComponent(0.6), for: .highlighted)
            .background(color: detailsStyle.button.background.color)
    }
    
}

// MARK: - Set

extension DetailsView {
    
    @discardableResult
    func set(news: News) -> Self {
        titleLabel.text(news.title)
//        articleImage.setImage(news.urlToImage)
        articleImage.setImage(UIImage(named: "testImg"))
        publishedAtLabel.text(news.publishedAt)
        descriptionLabel.text(news.description)
        openButton.title(R.string.localizable.detailsOpen(news.source.name))
        return self
    }
    
}
