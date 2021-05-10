//
//  WebSiteModuleFactory.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 30.04.2021.
//

import Foundation

protocol WebSiteModuleFactoryProtocol {
    func makeWebSiteView(coordinator: WebSiteCoordinator, urlString: String) -> Presentable
}

// MARK: - WebSiteModuleFactoryProtocol

extension ModulesFactory: WebSiteModuleFactoryProtocol {
    
    func makeWebSiteView(coordinator: WebSiteCoordinator, urlString: String) -> Presentable {
        let viewModel = WebSiteViewModel(coordinator: coordinator, urlString: urlString)
        let viewController = WebSiteViewController(viewModel: viewModel)
        let navigation = NavigationController(rootViewController: viewController)
        navigation.modalPresentationStyle = .fullScreen
        return navigation
    }
    
}
