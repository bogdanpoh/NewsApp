//
//  DetailsCoordinatorFactory.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 30.04.2021.
//

import Foundation

protocol DetailsCoordinatorFactoryProtocol {
    func makeWebSiteCoordinator(with router: Routable, urlString: String) -> Coordinatable & CoordinatorOutput
}

// MARK: - DetailsCoordinatorFactoryProtocol

extension CoordinatorsFactory: DetailsCoordinatorFactoryProtocol {
    
    func makeWebSiteCoordinator(with router: Routable, urlString: String) -> Coordinatable & CoordinatorOutput {
        return WebSiteCoordinator(router: router, moduleFactory: modulesFactory, coordinator: self, urlString: urlString)
    }
    
}
