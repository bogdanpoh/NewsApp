//
//  WebSiteViewModel.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 30.04.2021.
//

import Foundation
import WebKit

private let logger = Logger(identifier: "WebSiteViewModel")

protocol WebSiteViewModelInput {
    func tapClose()
    func loadPage(with webView: WKWebView)
    func openSafari()
}

protocol WebSiteViewModelOutput {
    
}

typealias WebSiteViewModelProtocol = WebSiteViewModelInput & WebSiteViewModelOutput

final class WebSiteViewModel {
    
    init(coordinator: WebSiteCoordinatorProtocol, urlString: String) {
        self.coordinator = coordinator
        self.urlString = urlString
    }
    
    // MARK: - Private
    
    private let coordinator: WebSiteCoordinatorProtocol
    private let urlString: String
    
}

// MARK: - WebSiteViewModelInput

extension WebSiteViewModel: WebSiteViewModelInput {
    
    func loadPage(with webView: WKWebView) {
        guard let url = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func openSafari() {
        coordinator.shareToSafari(urlString: urlString)
    }
    
    func tapClose() {
        coordinator.close()
    }
    
}

// MARK: - WebSiteViewModelOutput

extension WebSiteViewModel: WebSiteViewModelOutput {
    
}
