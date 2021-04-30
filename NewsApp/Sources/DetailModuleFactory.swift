//
//  DetailModuleFactory.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 16.04.2021.
//

import Foundation

protocol DetailModuleFactoryProtocol {
    func makeDetailsView(coordinator: DetailCoordinatorProtocol, news: Article) -> Presentable
}

// MARK: - DetailModuleFactoryProtocol

extension ModulesFactory: DetailModuleFactoryProtocol {
    
    func makeDetailsView(coordinator: DetailCoordinatorProtocol, news: Article) -> Presentable {
        let viewModel = DetailViewModel(coordinator: coordinator, article: news)
        return DetailsViewController(viewModel: viewModel)
    }
    
}
