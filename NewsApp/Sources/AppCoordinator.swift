//
//  AppCoordinator.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import Foundation

final class AppCoordinator: BaseCoordinator {
    typealias CoordinatorFactoryProtocol = AppCoordinatorFactoryProtocol
    
    // MARK: - Lifecycle
    
    init(router: Routable, factory: CoordinatorFactoryProtocol) {
        self.router = router
        self.factory = factory
        
        super.init()
    }
    
    // MARK: - Private
    
    private let router: Routable
    private let factory: CoordinatorFactoryProtocol
    
}

// MARK: - Coordinatable

extension AppCoordinator: Coordinatable {
    
    func start() {
        let coordinator = factory.makeNewsCoordinator(with: router)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            remove(dependency: coordinator)
        }
        add(dependency: coordinator)
        coordinator.start()
    }
    
}
