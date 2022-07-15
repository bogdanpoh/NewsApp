//
//  FeedCoordinator.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import Foundation
import RxRelay

protocol FeedCoordinatorProtocol {
    func open(article: Article)
    func openSettings(countrySubject: BehaviorRelay<Country>)
}

final class FeedCoordinator: BaseCoordinator, CoordinatorOutput {
    
    typealias ModuleFactoryProtocol = FeedModuleFactoryProtocol
    typealias NewsCoordinatorFactory = FeedCoordinatorFactoryProtocol
    
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
    private var transitionDelegate: UIViewControllerTransitioningDelegate?
    
}

// MARK: - Coordinatable

extension FeedCoordinator: Coordinatable {
    
    func start() {
        let view = moduleFactory.makeFeedView(coordinator: self)
        transitionDelegate = view.toPresent as? UIViewControllerTransitioningDelegate
        router.setRootModule(view)
    }
    
}

// MARK: - FeedCoordinatorProtocol

extension FeedCoordinator: FeedCoordinatorProtocol {
    
    func open(article: Article) {
        guard let td = transitionDelegate else { return }
        
        let coordinator = coordinatorFactory.makeDetailsCoordinator(with: router, transitionDelegate: td, article: article)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            remove(dependency: coordinator)
        }
        add(dependency: coordinator)
        coordinator.start()
    }
    
    func openSettings(countrySubject: BehaviorRelay<Country>) {
        let coordinator = coordinatorFactory.makeSettingsCoordinator(with: router, countrySubject: countrySubject)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            remove(dependency: coordinator)
        }
        add(dependency: coordinator)
        coordinator.start()
    }
    
}
