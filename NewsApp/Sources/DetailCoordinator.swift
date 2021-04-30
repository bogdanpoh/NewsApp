//
//  DetailCoordinator.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 16.04.2021.
//

import Foundation

protocol DetailCoordinatorProtocol {
    func openWebSite(urlString: String)
}

final class DetailCoordinator: BaseCoordinator, CoordinatorOutput {
    
    typealias DetailModuleFactory = DetailModuleFactoryProtocol
    typealias DetailCoordinatorFactory = DetailCoordinatorFactoryProtocol
    var finishFlow: CompletionBlock?
    
    // MARK: - Lifecycle
    
    init(router: Routable, moduleFactory: DetailModuleFactory, coordinatorFactory: DetailCoordinatorFactory, article: Article) {
        self.router = router
        self.moduleFactory = moduleFactory
        self.coordinatorFactory = coordinatorFactory
        self.article = article
    }
    
    // MARK: - Private
    
    private let router: Routable
    private let moduleFactory: DetailModuleFactory
    private let coordinatorFactory: DetailCoordinatorFactory
    private let article: Article
    
}

// MARK: - Coordinatable

extension DetailCoordinator: Coordinatable {
    
    func start() {
        let view = moduleFactory.makeDetailsView(coordinator: self, article: article)
        router.push(view)
    }
    
}

// MARK: - DetailsCoordinatorProtocol

extension DetailCoordinator: DetailCoordinatorProtocol {
    
    func openWebSite(urlString: String) {
        let coordinator = coordinatorFactory.makeWebSiteCoordinator(with: router, urlString: urlString)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            remove(dependency: coordinator)
        }
        add(dependency: coordinator)
        coordinator.start()
    }
    
}
