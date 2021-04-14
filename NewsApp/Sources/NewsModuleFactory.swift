//
//  NewsModuleFactory.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import Foundation

protocol NewsModuleFactoryProtocol {
    func makeNewsView(coordinator: NewsCoordinatorProtocol) -> Presentable
}

// MARK: - NewsModuleFactoryProtocol

extension ModulesFactory: NewsModuleFactoryProtocol {
    
    func makeNewsView(coordinator: NewsCoordinatorProtocol) -> Presentable {
        let viewModel = NewsViewModel(coordinator: coordinator)
        return FeedViewController(viewModel: viewModel)
    }
    
}
