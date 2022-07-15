//
//  FeedCoordinatorFactory.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import RxRelay

protocol FeedCoordinatorFactoryProtocol {
    func makeDetailsCoordinator(with router: Routable, transitionDelegate: UIViewControllerTransitioningDelegate, article: Article) -> Coordinatable & CoordinatorOutput
    func makeSettingsCoordinator(with router: Routable, countrySubject: BehaviorRelay<Country>) -> Coordinatable & CoordinatorOutput
}

// MARK: - FeedCoordinatorFactoryProtocol

extension CoordinatorsFactory: FeedCoordinatorFactoryProtocol {
    
    func makeDetailsCoordinator(with router: Routable, transitionDelegate: UIViewControllerTransitioningDelegate, article: Article) -> Coordinatable & CoordinatorOutput {
        return DetailsCoordinator(router: router, moduleFactory: modulesFactory, coordinatorFactory: self, transitionDelegate: transitionDelegate, article: article)
    }
    
    func makeSettingsCoordinator(with router: Routable, countrySubject: BehaviorRelay<Country>) -> Coordinatable & CoordinatorOutput {
        return SettingsCoordinator(router: router, moduleFactory: modulesFactory, countrySubject: countrySubject)
    }
    
}
