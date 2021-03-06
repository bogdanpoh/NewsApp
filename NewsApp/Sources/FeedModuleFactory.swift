//
//  FeedModuleFactory.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import Foundation

protocol FeedModuleFactoryProtocol {
    func makeFeedView(coordinator: FeedCoordinatorProtocol) -> Presentable
}

// MARK: - FeedModuleFactoryProtocol

extension ModulesFactory: FeedModuleFactoryProtocol {
    
    func makeFeedView(coordinator: FeedCoordinatorProtocol) -> Presentable {
        let viewModel = FeedViewModel(
            coordinator: coordinator,
            networkService: dependencyContainer.resolve(NetworkNewsProtocol.self)!,
            userManager: dependencyContainer.resolve(UserManagerProtocol.self)!
        )
        return FeedViewController(viewModel: viewModel)
    }
    
}
