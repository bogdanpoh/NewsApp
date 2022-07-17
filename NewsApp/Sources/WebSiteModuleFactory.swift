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
        guard let url = urlString.asURL else { return UIViewController() }
        
        let configuration = SFSafariViewController.Configuration()
        configuration.entersReaderIfAvailable = true
        let safariViewController = SFSafariViewController(url: url, configuration: configuration)
        
        return safariViewController
    }
    
}
