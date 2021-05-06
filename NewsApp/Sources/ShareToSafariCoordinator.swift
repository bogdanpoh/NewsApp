//
//  ShareToSafariCoordinator.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 06.05.2021.
//

import UIKit

final class ShareToSafariCoordinator: CoordinatorOutput {
    
    var finishFlow: CompletionBlock?
    
    // MARK: - Lifecycle
    
    init(router: Routable, stringUrl: String) {
        self.router = router
        self.stringUrl = stringUrl
    }
    
    // MARK: - Private
    
    private let router: Routable
    private let stringUrl: String
    
}

// MARK: - Coordinatable

extension ShareToSafariCoordinator: Coordinatable {
    
    func start() {
        if let url = URL(string: stringUrl) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:]) { [weak self] _ in
                    self?.finishFlow?()
                }
            }
        }
    }
    
}
