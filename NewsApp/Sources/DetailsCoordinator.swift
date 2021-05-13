//
//  DetailsCoordinator.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 16.04.2021.
//

import Foundation

protocol DetailsCoordinatorProtocol {
    func close()
    func openWebSite(urlString: String)
    func shareText(text: String)
}

final class DetailsCoordinator: BaseCoordinator, CoordinatorOutput {
    
    typealias DetailsModuleFactory = DetailsModuleFactoryProtocol
    typealias DetailsCoordinatorFactory = DetailsCoordinatorFactoryProtocol
    var finishFlow: CompletionBlock?
    
    // MARK: - Lifecycle
    
    init(router: Routable, moduleFactory: DetailsModuleFactory, coordinatorFactory: DetailsCoordinatorFactory, article: Article) {
        self.router = router
        self.moduleFactory = moduleFactory
        self.coordinatorFactory = coordinatorFactory
        self.article = article
    }
    
    // MARK: - Private
    
    private let router: Routable
    private let moduleFactory: DetailsModuleFactory
    private let coordinatorFactory: DetailsCoordinatorFactory
    private let article: Article
    
}

// MARK: - Coordinatable

extension DetailsCoordinator: Coordinatable {
    
    func start() {
        let view = moduleFactory.makeDetailsView(coordinator: self, article: article)
        router.present(view)
    }
    
}

// MARK: - DetailsCoordinatorProtocol

extension DetailsCoordinator: DetailsCoordinatorProtocol {
    
    func shareText(text: String) {
        let coordinator = coordinatorFactory.makeShareTextCoordinator(with: router, text: text)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            remove(dependency: coordinator)
        }
        add(dependency: coordinator)
        coordinator.start()
    }
    
    func openWebSite(urlString: String) {
        let coordinator = coordinatorFactory.makeWebSiteCoordinator(with: router, urlString: urlString)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            remove(dependency: coordinator)
        }
        add(dependency: coordinator)
        coordinator.start()
    }
    
    func close() {
        router.dismissModule(animated: true, completion: finishFlow)
    }
    
}
