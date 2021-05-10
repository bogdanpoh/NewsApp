//
//  DetailsModuleFactory.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 16.04.2021.
//

import Foundation

protocol DetailsModuleFactoryProtocol {
    func makeDetailsView(coordinator: DetailsCoordinatorProtocol, article: Article) -> Presentable
}

// MARK: - DetailsModuleFactoryProtocol

extension ModulesFactory: DetailsModuleFactoryProtocol {
    
    func makeDetailsView(coordinator: DetailsCoordinatorProtocol, article: Article) -> Presentable {
        let viewModel = DetailsViewModel(coordinator: coordinator, article: article)
        let viewController = DetailsViewController(viewModel: viewModel)
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
    
}
