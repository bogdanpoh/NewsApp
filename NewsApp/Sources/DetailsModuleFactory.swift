//
//  DetailsModuleFactory.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 16.04.2021.
//

import UIKit

protocol DetailsModuleFactoryProtocol {
    func makeDetailsView(coordinator: DetailsCoordinatorProtocol, transitioningDelegate: UIViewControllerTransitioningDelegate , article: Article) -> Presentable
}

// MARK: - DetailsModuleFactoryProtocol

extension ModulesFactory: DetailsModuleFactoryProtocol {
    
    func makeDetailsView(coordinator: DetailsCoordinatorProtocol, transitioningDelegate: UIViewControllerTransitioningDelegate , article: Article) -> Presentable {
        let viewModel = DetailsViewModel(coordinator: coordinator, article: article)
        let viewController = DetailsViewController(viewModel: viewModel)
        viewController.transitioningDelegate = transitioningDelegate
        viewController.modalPresentationStyle = .overCurrentContext
        
        return viewController
    }
    
}
