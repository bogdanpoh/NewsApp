//
//  AppCoordinatorFactoryProtocol.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import Foundation

protocol AppCoordinatorFactoryProtocol {
    func makeNewsCoordinator(with router: Routable) -> Coordinatable & CoordinatorOutput
}

// MARK: - AppCoordinatorFactoryProtocol

extension CoordinatorsFactory: AppCoordinatorFactoryProtocol {
    
    func makeNewsCoordinator(with router: Routable) -> Coordinatable & CoordinatorOutput {
        return NewsCoordinator(router: router, moduleFactory: modulesFactory, coordinatorFactory: self)
    }
    
}

