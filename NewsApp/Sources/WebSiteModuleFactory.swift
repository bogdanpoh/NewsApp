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
        let webSiteViewModel = WebSiteViewModel(coordinator: coordinator, urlString: urlString)
        return WebSiteViewController(viewModel: webSiteViewModel)
    }
    
}
