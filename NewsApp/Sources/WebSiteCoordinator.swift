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
    
    init(router: Routable, moduleFactory: WebSiteModuleFactory) {
        self.router = router
        self.moduleFactory = moduleFactory
    }
    
    // MARK: - Private
    
    private let router: Routable
    private let moduleFactory: WebSiteModuleFactory
    
}

// MARK: - Coordinatable

extension WebSiteCoordinator: Coordinatable {
    
    func start() {
        let view = moduleFactory.makeWebSiteView(coordinator: self)
        router.push(view)
    }
    
}

// MARK: - WebSiteCoordinatorProtocol

extension WebSiteCoordinator: WebSiteCoordinatorProtocol {
    
}
