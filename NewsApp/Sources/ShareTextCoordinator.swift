//
//  ShareTextCoordinator.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 10.05.2021.
//

import Foundation

private let logger = Logger(identifier: "ShareTextCoordinator")

protocol ShareTextCoordinatorProtocol {
    
}

final class ShareTextCoordinator: CoordinatorOutput {
    
    typealias ModuleFactoryProtocol = ShareTextModuleFactoryProtocol
    var finishFlow: CompletionBlock?
    
    // MARK: - Lifecycle
    
    init(router: Routable, moduleFactory: ModuleFactoryProtocol, text: String) {
        self.router = router
        self.moduleFactory = moduleFactory
        self.text = text
    }
    
    // MARK: - Private
    
    private let router: Routable
    private let moduleFactory: ModuleFactoryProtocol
    private let text: String
    
}

// MARK: - Coordinatable

extension ShareTextCoordinator: Coordinatable {
    
    func start() {
        let view = moduleFactory.makeShareTextView(text: text)
        router.topPresent(view)
    }
    
}

// MARK: - ShareTextCoordinatorProtocol

extension ShareTextCoordinator: ShareTextCoordinatorProtocol {
    
}
