//
//  DetailsViewController.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 16.04.2021.
//

import UIKit

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
    }
    
    // MARK: - Private
    
    private let viewModel: DetailViewModel
    
}

// MARK: - Setup

private extension DetailsViewController {
    
    func setupNavigationBar() {
        navigationItem.title = R.string.localizable.detailsTitle()
    }
    
}
