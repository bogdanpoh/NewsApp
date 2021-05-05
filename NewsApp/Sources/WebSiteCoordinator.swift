//
//  WebSiteCoordinator.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 30.04.2021.
//

import Foundation

protocol WebSiteCoordinatorProtocol {
    
}

final class WebSiteCoordinator: BaseCoordinator, CoordinatorOutput {
    
    typealias WebSiteModuleFactory = WebSiteModuleFactoryProtocol
    var finishFlow: CompletionBlock?
    
    // MARK: - Lifecycle
    
    init(router: Routable, moduleFactory: WebSiteModuleFactory, urlString: String) {
        self.router = router
        self.moduleFactory = moduleFactory
        self.urlString = urlString
    }
    
    // MARK: - Private
    
    private let router: Routable
    private let moduleFactory: WebSiteModuleFactory
    private let urlString: String
    
}

// MARK: - Coordinatable

extension WebSiteCoordinator: Coordinatable {
    
    func start() {
        let view = moduleFactory.makeWebSiteView(coordinator: self, urlString: urlString)
        router.push(view)
    }
    
}

// MARK: - WebSiteCoordinatorProtocol

extension WebSiteCoordinator: WebSiteCoordinatorProtocol {
    
}
