//
//  DetailsCoordinator.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 16.04.2021.
//

import Foundation

protocol DetailsCoordinatorProtocol {
    
}

final class DetailsCoordinator: BaseCoordinator, CoordinatorOutput {
    typealias DetailsModuleFactory = DetailsModuleFactoryProtocol
    
    var finishFlow: CompletionBlock?
    
    // MARK: - Lifecycle
    
    init(router: Routable, moduleFactory: DetailsModuleFactory, article: Article) {
        self.router = router
        self.moduleFactory = moduleFactory
        self.news = article
    }
    
    // MARK: - Private
    
    private let router: Routable
    private let moduleFactory: DetailsModuleFactory
    private let news: Article
    
}

// MARK: - Coordinatable

extension DetailsCoordinator: Coordinatable {
    
    func start() {
        let view = moduleFactory.makeDetailsView(coordinator: self, news: news)
        router.push(view)
    }
    
}

// MARK: - DetailsCoordinatorProtocol

extension DetailsCoordinator: DetailsCoordinatorProtocol {
    
}
