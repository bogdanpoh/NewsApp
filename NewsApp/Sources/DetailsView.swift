//
//  DetailsView.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 16.04.2021.
//

import UIKit
import UIImageColors

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
    
    private lazy var imageContentStack = makeStackView(axis: .vertical) (
        View(),
        articleImage
    )
    
    private let articleImage = KFImageView()
        .backgroundColor(color: .gray)
        .setContentMode(.scaleToFill)
    
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
    
    private(set) var swipeDown = SwipeGestureRecognizer()
        .set(swipeDirection: .down)
    
    private(set) var shareButton = ButtonsFactory.makeActionButton(image: UIImage(systemName: "square.and.arrow.up"))
        .title(R.string.localizable.detailsShareArticle())
    
    private(set) var openButton = ButtonsFactory.makeActionButton(image: UIImage(systemName: "link"))
    
    // MARK: - Lifecycle
    
    override func setupSubviews() {
        super.setupSubviews()
        
        addSubviews(imageContentStack, closeButton, contentStack)
        addGestureRecognizer(swipeDown)
    }
    
    override func defineLayout() {
        super.defineLayout()
        
        closeButton.snp.makeConstraints {
            $0.top.equalTo(layoutMarginsGuide).inset(UIEdgeInsets(aTop: 16))
            $0.trailing.equalToSuperview().inset(UIEdgeInsets(aRight: 16))
            $0.width.height.equalTo(36)
        }
        
        imageContentStack.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(articleImageHeight + topInstet)
        }
        
        articleImage.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(articleImageHeight)
        }
        
        contentStack.snp.makeConstraints {
            $0.top.equalTo(articleImage.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(horizontal: 16))
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
        
        let detailsStyle = theme.components.details
        backgroundColor(color: detailsStyle.background)
        
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
            $0.tint(color: detailsStyle.button.text.color)
            $0.text(font: detailsStyle.button.text.font)
            $0.background(color: detailsStyle.button.background.color)
            $0.background(color: detailsStyle.button.background.color.withAlphaComponent(0.8), for: .highlighted)
        }
    }
    
    // MARK: - Private
    
    let topInstet = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    let articleImageHeight: CGFloat = 230.0
    
}

// MARK: - Set

extension DetailsView {
    
    @discardableResult
    func set(state: State) -> Self {
        articleImage.setImage(path: state.articleImageUrl, placeholder: R.image.newsPlaceholder()) { [weak self] result in
            switch result {
            case .failure(_):
                self?.articleImage.image = R.image.newsPlaceholder()
                R.image.newsPlaceholder()?.getColors() { colors in
                    self?.imageContentStack.backgroundColor = colors?.background
                }
                
            default:
                break
            }
            
        }
        
        articleImage.image?.getColors { [weak self] colors in
            guard let self = self else { return }
            guard let imageBackgroundColor = colors?.background else { return }
            let isLightImageBackgroundColor = imageBackgroundColor.isLight() ?? false
            
            switch self.traitCollection.userInterfaceStyle {
            case .light:
                if isLightImageBackgroundColor {
                    self.imageContentStack.backgroundColor = imageBackgroundColor
                }
                
            case .dark:
                self.imageContentStack.backgroundColor = imageBackgroundColor
                
            default:
                break
            }
        }
        
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
