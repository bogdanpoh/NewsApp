//
//  DetailsModuleFactory.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 16.04.2021.
//

import Foundation

protocol DetailsModuleFactoryProtocol {
    func makeDetailsView(coordinator: DetailsCoordinatorProtocol, news: News) -> Presentable
}

extension ModulesFactory: DetailsModuleFactoryProtocol {
    
    func makeDetailsView(coordinator: DetailsCoordinatorProtocol, news: News) -> Presentable {
        let viewModel = DetailViewModel(coordinator: coordinator)
        return DetailsViewController(viewModel: viewModel)
    }
    
}
