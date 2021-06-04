//
//  DetailsViewController.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 16.04.2021.
//

import UIKit
import RxSwift

private let logger = Logger(identifier: "DetailsViewController")

final class DetailsViewController: ViewController<DetailsView> {
    
    // MARK: - Initializers
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        
        super.init()
        
        logger.debug("DetailsViewController constructed")
    }
    
    @available(*, unavailable)
    required init() {
        fatalError("init() has not been implemented")
    }
    
    deinit {
        logger.debug("~DetailsViewController destructed")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupActionHandlers()
        setupBindingToViewModel()
        
        viewModel.viewDidLoad()
    }
    
    // MARK: - Private
    
    private let viewModel: DetailsViewModel
    private let disposeBag = DisposeBag()
    
}

// MARK: - Setup

private extension DetailsViewController {
    
    func setupActionHandlers() {
        contentView.closeButton.whenTap { [unowned self] in
            viewModel.close()
        }
        
        contentView.shareButton.whenTap { [unowned self] in
            viewModel.tapShareArticle()
        }
        
        contentView.openButton.whenTap { [unowned self] in
            viewModel.tapOpenWebSite()
        }
        
        contentView.swipeDown.whenSwipe { [unowned self] in
            viewModel.close()
        }
    }
    
    func setupBindingToViewModel() {
        viewModel.article
            .subscribe(onNext: { [weak self] article in
                self?.contentView.set(state: .init(
                    articleImageUrl: article.urlToImage,
                    title: article.title,
                    author: article.author,
                    publishedAt: article.publishedAt,
                    description: article.description,
                    sourceName: article.source.name
                ))
            })
        .disposed(by: disposeBag)
        
        viewModel.authorCopyright
            .bind(to: contentView.authorLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
}
