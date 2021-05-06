//
//  WebSiteCoordinator.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 30.04.2021.
//

import Foundation

protocol WebSiteCoordinatorProtocol {
    func shareToSafari(stringUrl: String)
}

final class WebSiteCoordinator: BaseCoordinator, CoordinatorOutput {
    
    typealias WebSiteModuleFactory = WebSiteModuleFactoryProtocol
    typealias WebSiteCoordinatorFactory = WebSiteCoordinatorFactoryProtocol
    var finishFlow: CompletionBlock?
    
    // MARK: - Lifecycle
    
    init(router: Routable, moduleFactory: WebSiteModuleFactory, coordinator: WebSiteCoordinatorFactory, urlString: String) {
        self.router = router
        self.moduleFactory = moduleFactory
        self.coordinator = coordinator
        self.urlString = urlString
    }
    
    // MARK: - Private
    
    private let router: Routable
    private let moduleFactory: WebSiteModuleFactory
    private let coordinator: WebSiteCoordinatorFactory
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
    
    func shareToSafari(stringUrl: String) {
        let coordinator = coordinator.makeShareToSafariCoordinator(with: router, stringUrl: stringUrl)
        coordinator.finishFlow = { [unowned coordinator, unowned self] in
            remove(dependency: coordinator)
        }
        add(dependency: coordinator)
        coordinator.start()
    }
    
}
