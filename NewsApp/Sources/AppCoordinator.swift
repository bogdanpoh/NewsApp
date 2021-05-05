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
    
    init(router: Routable, coordinatorFactory: CoordinatorFactoryProtocol) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        
        super.init()
    }
    
    // MARK: - Private
    
    private let router: Routable
    private let coordinatorFactory: CoordinatorFactoryProtocol
    
}

// MARK: - Coordinatable

extension AppCoordinator: Coordinatable {
    
    func start() {
        let coordinator = coordinatorFactory.makeNewsCoordinator(with: router)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            remove(dependency: coordinator)
        }
        add(dependency: coordinator)
        coordinator.start()
    }
    
}
