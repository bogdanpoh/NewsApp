//
//  DetailCoordinator.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 16.04.2021.
//

import Foundation

protocol DetailCoordinatorProtocol {
    func openWebSite()
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
        self.news = article
    }
    
    // MARK: - Private
    
    private let router: Routable
    private let moduleFactory: DetailModuleFactory
    private let coordinatorFactory: DetailCoordinatorFactory
    private let news: Article
    
}

// MARK: - Coordinatable

extension DetailCoordinator: Coordinatable {
    
    func start() {
        let view = moduleFactory.makeDetailsView(coordinator: self, news: news)
        router.push(view)
    }
    
}

// MARK: - DetailsCoordinatorProtocol

extension DetailCoordinator: DetailCoordinatorProtocol {
    
    func openWebSite() {
        let coordinator = coordinatorFactory.makeWebSiteCoordinator(with: router)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            remove(dependency: coordinator)
        }
        add(dependency: coordinator)
        coordinator.start()
    }
    
}
