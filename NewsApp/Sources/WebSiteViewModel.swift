//
//  WebSiteViewModel.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 30.04.2021.
//

import Foundation

private let logger = Logger(identifier: "WebSiteViewModel")

protocol WebSiteViewModelInput {
    
}

protocol WebSiteViewModelOutput {
    
}

typealias WebSiteViewModelProtocol = WebSiteViewModelInput & WebSiteViewModelOutput

final class WebSiteViewModel {
    
    init(coordinator: WebSiteCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    // MARK: - Private
    
    private let coordinator: WebSiteCoordinatorProtocol
    
}

// MARK: - WebSiteViewModelInput

extension WebSiteViewModel: WebSiteViewModelInput {
    
}

// MARK: - WebSiteViewModelOutput

extension WebSiteViewModel: WebSiteViewModelOutput {
    
}
