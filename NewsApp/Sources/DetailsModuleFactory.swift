//
//  DetailsModuleFactory.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 16.04.2021.
//

import Foundation

protocol DetailsModuleFactoryProtocol {
    func makeDetailsView(coordinator: DetailsCoordinatorProtocol, news: Article) -> Presentable
}

extension ModulesFactory: DetailsModuleFactoryProtocol {
    
    func makeDetailsView(coordinator: DetailsCoordinatorProtocol, news: Article) -> Presentable {
        let viewModel = DetailViewModel(coordinator: coordinator, article: news)
        return DetailsViewController(viewModel: viewModel)
    }
    
}
