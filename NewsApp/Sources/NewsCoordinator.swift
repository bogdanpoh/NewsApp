//
//  NewsCoordinator.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import Foundation

protocol NewsCoordinatorProtocol {
    func open(news: News)
}

final class NewsCoordinator: BaseCoordinator, CoordinatorOutput {
    typealias ModuleFactoryProtocol = NewsModuleFactoryProtocol
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

extension NewsCoordinator: Coordinatable {
    
    func start() {
        let view = moduleFactory.makeNewsView(coordinator: self)
        router.setRootModule(view)
    }
    
}

extension NewsCoordinator: NewsCoordinatorProtocol {
    
    func open(news: News) {
        print("open news")
    }
    
}
