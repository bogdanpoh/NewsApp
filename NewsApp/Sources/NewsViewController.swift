//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import UIKit

private let logger = Logger(identifier: "NewsViewController")

final class NewsViewController: ViewController<NewsView> {
    
    // MARK: - Initializers
    
    init(viewModel: NewsViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init()
        
        logger.debug("NewsViewController constructed")
    }
    
    @available(*, unavailable)
    required init() {
        fatalError("init() has not been implemented")
    }
    
    deinit {
        logger.debug("~NewsViewController destructed")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    // MARK: - Private
    
    private let viewModel: NewsViewModelProtocol
    
}

// MARK: -

private extension NewsViewController {
    
    func setupNavigationBar() {
        navigationItem.title = R.string.localizable.newsTitle()
    }
    
}
