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
    
    init(viewModel: DetailViewModel) {
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
        
        contentView.openButton.whenTap { [unowned self] in
            viewModel.tapOpenWebSite()
        }
        
        setupNavigationBar()
        setupBindingToViewModel()
        
        viewModel.viewDidLoad()
    }
    
    // MARK: - Private
    
    private let viewModel: DetailViewModel
    private let disposeBag = DisposeBag()
    
}

// MARK: - Setup

private extension DetailsViewController {
    
    func setupNavigationBar() {
        navigationItem.title = R.string.localizable.detailsTitle()
    }
    
    func setupBindingToViewModel() {
        viewModel.article
            .subscribe(onNext: { [weak self] article in
                self?.contentView.set(state: DetailsView.State.init(
                    articleImageUrl: article.urlToImage,
                    title: article.title,
                    author: article.author,
                    publishedAt: article.publishedAt,
                    description: article.description,
                    sourceName: article.source.name
                ))
            })
        .disposed(by: disposeBag)
        
        viewModel.formattedPublishAt
            .subscribe(onNext: { [weak self] time in
                self?.contentView.set(publishAt: time)
            })
            .disposed(by: disposeBag)
    }
    
}
