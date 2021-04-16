//
//  FeedCoordinator.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import Foundation

protocol FeedCoordinatorProtocol {
    func open(news: News)
}

final class FeedCoordinator: BaseCoordinator, CoordinatorOutput {
    typealias ModuleFactoryProtocol = FeedModuleFactoryProtocol
    typealias NewsCoordinatorFactory = NewsCoordinatorFactoryProtocol
    
    var finishFlow: CompletionBlock?
    
    // MARK: - Lifecycle
    
    init(router: Routable, moduleFactory: ModuleFactoryProtocol, coordinatorFactory: NewsCoordinatorFactory) {
        self.router = router
        self.moduleFactory = moduleFactory
        self.coordinatorFactory = coordinatorFactory
        
        super.init()
    }
    
    // MARK: - Private
    
    private let router: Routable
    private let moduleFactory: ModuleFactoryProtocol
    private let coordinatorFactory: NewsCoordinatorFactory
    
}

// MARK: - Coordinatable

extension FeedCoordinator: Coordinatable {
    
    func start() {
        let view = moduleFactory.makeFeedView(coordinator: self)
        router.setRootModule(view)
    }
    
}

// MARK: - FeedCoordinatorProtocol

extension FeedCoordinator: FeedCoordinatorProtocol {
    
    func open(news: News) {
        let coordinator = coordinatorFactory.makeDetailsCoordinator(with: router, news: news)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            remove(dependency: coordinator)
        }
        add(dependency: coordinator)
        coordinator.start()
    }
    
}
