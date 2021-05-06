//
//  DetailCoordinatorFactory.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 30.04.2021.
//

import Foundation

protocol DetailCoordinatorFactoryProtocol {
    func makeWebSiteCoordinator(with router: Routable, urlString: String) -> Coordinatable & CoordinatorOutput
}

// MARK: - DetailCoordinatorFactoryProtocol

extension CoordinatorsFactory: DetailCoordinatorFactoryProtocol {
    
    func makeWebSiteCoordinator(with router: Routable, urlString: String) -> Coordinatable & CoordinatorOutput {
        return WebSiteCoordinator(router: router, moduleFactory: modulesFactory, coordinator: self, urlString: urlString)
    }
    
}
