//
//  WebSiteCoordinatorFactory.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 06.05.2021.
//

import Foundation

protocol WebSiteCoordinatorFactoryProtocol {
    func makeShareToSafariCoordinator(with router: Routable, stringUrl: String) -> Coordinatable & CoordinatorOutput
}

// MARK: - WebSiteCoordinatorFactoryProtocol

extension CoordinatorsFactory: WebSiteCoordinatorFactoryProtocol {
    
    func makeShareToSafariCoordinator(with router: Routable, stringUrl: String) -> Coordinatable & CoordinatorOutput {
        return ShareToSafariCoordinator(router: router, stringUrl: stringUrl)
    }
    
}
