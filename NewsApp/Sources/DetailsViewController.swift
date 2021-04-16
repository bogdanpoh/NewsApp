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
        viewModel.news
            .subscribe(onNext: { [weak self] news in
                self?.contentView.set(news: news)
            })
        .disposed(by: disposeBag)
        
        viewModel.formattedPublishAt
            .subscribe(onNext: { [weak self] time in
                self?.contentView.set(publishAt: time)
            })
            .disposed(by: disposeBag)
    }
    
}
