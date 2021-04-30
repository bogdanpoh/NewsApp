//
//  WebSiteViewController.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 30.04.2021.
//

import UIKit

private let logger = Logger(identifier: "WebSiteViewController")

final class WebSiteViewController: ViewController<WebSiteView> {
    
    // MARK: - Initializers
    
    init(viewModel: WebSiteViewModel) {
        self.viewModel = viewModel
        
        super.init()
        
        logger.debug("WebSiteViewController constructed")
    }
    
    @available(*, unavailable)
    required init() {
        fatalError("init() has not been implemented")
    }
    
    deinit {
        logger.debug("~WebSiteViewController destructed")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    // MARK: - Private
    
    private let viewModel: WebSiteViewModel
    
}

// MARK: - Setup

private extension WebSiteViewController {
    
    func setupNavigationBar() {
        navigationItem.title = R.string.localizable.webSiteTitle()
    }
    
}
