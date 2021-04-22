//
//  NewsCoordinatorFactory.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import Foundation

protocol NewsCoordinatorFactoryProtocol {
    func makeDetailsCoordinator(with router: Routable, article: Article) -> Coordinatable & CoordinatorOutput
}

// MARK: - NewsCoordinatorFactoryProtocol

extension CoordinatorsFactory: NewsCoordinatorFactoryProtocol {
    
    func makeDetailsCoordinator(with router: Routable, article: Article) -> Coordinatable & CoordinatorOutput {
        return DetailsCoordinator(router: router, moduleFactory: modulesFactory, article: article)
    }
    
}
