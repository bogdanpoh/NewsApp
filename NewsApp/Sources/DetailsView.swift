//
//  DetailsView.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 16.04.2021.
//

import UIKit

final class DetailsView: View {
    
    struct State {
        var articleImageUrl: String?
        var title: String
        var author: String?
        var publishedAt: String
        var description: String?
        var sourceName: String
    }
    
    // MARK: - UI
    
    private let articleImage = KFImageView()
        .backgroundColor(color: .gray)
        .setContentMode(.scaleToFill)
        .maskToBounds(true)
    
    private(set) var closeButton = Button()
        .setImage(R.image.icNavBarClose())
    
    private lazy var contentStack = makeStackView(axis: .vertical, spacing: 10) (
        titleLabel,
        authorLabel,
        descriptionLabel,
        emptyView,
        buttonStack
    )
    .make { $0.setCustomSpacing(15, after: authorLabel) }
    
    private let titleLabel = Label()
        .enableMultilines()
    
    private(set) var authorLabel = Label()
    
    private let descriptionLabel = Label()
        .enableMultilines()
    
    private let emptyView = View()
    
    private lazy var buttonStack = makeStackView(axis: .vertical, spacing: 8) (
        shareButton,
        openButton
    )
    
//    private lazy var swipeDown: UISwipeGestureRecognizer = {
//        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipe(_:)))
//        swipe.direction = .down
//        return swipe
//    }()
    
    private(set) var swipeDown = SwipeGestureRecognizer()
        .set(swipeDirection: .down)
    
    private(set) var shareButton = ButtonsFactory.makeActionButton(image: UIImage(systemName: "square.and.arrow.up"))
        .title(R.string.localizable.detailsShareArticle())
    
    private(set) var openButton = ButtonsFactory.makeActionButton(image: R.image.icExternalLink())
    
    // MARK: - Lifecycle
    
    override func setupSubviews() {
        super.setupSubviews()
        
        addSubviews(articleImage, closeButton, contentStack)
        
        addGestureRecognizer(swipeDown)
    }
    
    override func defineLayout() {
        super.defineLayout()
        
        closeButton.snp.makeConstraints {
            $0.top.equalTo(layoutMarginsGuide).inset(UIEdgeInsets(aTop: 8))
            $0.trailing.equalToSuperview().inset(UIEdgeInsets(aRight: 18))
            $0.width.height.equalTo(36)
        }
        
        articleImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(250)
        }
        
        contentStack.snp.makeConstraints {
            $0.top.equalTo(articleImage.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(horizontal: 18))
            $0.bottom.equalTo(layoutMarginsGuide).inset(UIEdgeInsets(aBottom: 10))
        }
        
        [shareButton, openButton].forEach { button in
            button.snp.makeConstraints {
                $0.height.equalTo(60)
            }
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
        
        authorLabel
            .textColor(detailsStyle.author.color)
            .text(font: detailsStyle.author.font)
        
        descriptionLabel
            .textColor(detailsStyle.description.color)
            .text(font: detailsStyle.description.font)
        
        [shareButton, openButton].forEach {
            $0.titleColor(detailsStyle.button.text.color)
            $0.titleColor(detailsStyle.button.text.color.withAlphaComponent(0.6), for: .highlighted)
            $0.text(font: detailsStyle.button.text.font)
            $0.background(color: detailsStyle.button.background.color)
        }
        
        ///bopo: remove after replace upload icon
        shareButton.tint(color: detailsStyle.button.text.color)
    }
    
}

// MARK: - Set

extension DetailsView {
    
    @discardableResult
    func set(state: State) -> Self {
        articleImage.setImage(path: state.articleImageUrl, placeholder: R.image.newsPlaceholder())
        titleLabel.text(state.title)
        authorLabel.text(state.author ?? R.string.localizable.feedWithoutAuthor())
        descriptionLabel.text(state.description ?? R.string.localizable.detailsWithoutDescription())
        openButton.title(R.string.localizable.detailsOpen(state.sourceName.lowercased()))
        return self
    }
    
    @discardableResult
    func set(author: String) -> Self {
        authorLabel.text(author)
        return self
    }
    
}
