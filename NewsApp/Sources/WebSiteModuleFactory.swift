//
//  WebSiteModuleFactory.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 30.04.2021.
//

import SafariServices

protocol WebSiteModuleFactoryProtocol {
    func makeWebSiteView(coordinator: WebSiteCoordinator, urlString: String) -> Presentable
}

// MARK: - WebSiteModuleFactoryProtocol

extension ModulesFactory: WebSiteModuleFactoryProtocol {
    
    func makeWebSiteView(coordinator: WebSiteCoordinator, urlString: String) -> Presentable {
        guard let url = URL(string: urlString) else {
            let viewModel = WebSiteViewModel(coordinator: coordinator, urlString: urlString)
            let navigation = NavigationController(rootViewController: WebSiteViewController(viewModel: viewModel))
            navigation.modalPresentationStyle = .fullScreen
            return navigation
        }

        return SFSafariViewController(url: url)
    }
    
}
