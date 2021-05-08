//
//  FeedCoordinatorFactory.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import Foundation

protocol FeedCoordinatorFactoryProtocol {
    func makeDetailsCoordinator(with router: Routable, article: Article) -> Coordinatable & CoordinatorOutput
}

// MARK: - FeedCoordinatorFactoryProtocol

extension CoordinatorsFactory: FeedCoordinatorFactoryProtocol {
    
    func makeDetailsCoordinator(with router: Routable, article: Article) -> Coordinatable & CoordinatorOutput {
        return DetailsCoordinator(router: router, moduleFactory: modulesFactory, coordinatorFactory: self, article: article)
    }
    
}
