//
//  Router.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 10.04.2021.
//

import UIKit

final class Router: Routable {
    
    var toPresent: UIViewController? { rootController }
    
    // MARK: - Lifecycle
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
    }
    
    // MARK: - Private
    
    private let rootController: UINavigationController
    
}

// MARK: - Present

extension Router {
    
    func topPresent(_ module: Presentable?) {
        guard let viewController = toPresent?.topmostViewController() else {
            assertionFailure("expected `toPresent`")
            return
        }
        
        guard let vc = module?.toPresent else {
            assertionFailure("expected `toPresent` in module")
            return
        }
        
        viewController.present(vc, animated: true, completion: nil)
    }
    
    func present(_ module: Presentable?) {
        present(module, animated: true)
    }
    
    func present(_ module: Presentable?, animated: Bool) {
        guard let viewController = toPresent else {
            assertionFailure("expected `toPresent`")
            return
        }

        guard let vc = module?.toPresent else {
            assertionFailure("expected `toPresent` in module")
            return
        }
        
        viewController.present(vc, animated: animated, completion: nil)
    }
    
}

// MARK: - Push

extension Router {
    
    func push(_ module: Presentable?) {
        push(module, animated: true, completion: nil)
    }
    
    func push(_ module: Presentable?, animated: Bool) {
        push(module, animated: animated, completion: nil)
    }

    func push(_ module: Presentable?, animated: Bool, completion: CompletionBlock?) {
        assert(completion == nil, "hasn't been implemented")

        guard let navigationController = toPresent as? UINavigationController else {
            assertionFailure("expected `UINavigationController`")
            return
        }

        guard let vc = module?.toPresent else {
            assertionFailure("expected `toPresent` in module")
            return
        }

        navigationController.pushViewController(vc, animated: animated)
    }
    
}

// MARK: - Pop

extension Router {
    
    func popModule() {
        popModule(animated: true)
    }

    func popModule(animated: Bool) {
        guard let navigationController = toPresent as? UINavigationController else {
            assertionFailure("expected `UINavigationController`")
            return
        }
        navigationController.popViewController(animated: animated)
    }
    
}

// MARK: - Dismiss

extension Router {
    
    func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }
    
    func dismissTopmost(animated: Bool, completion: CompletionBlock?) {
        guard let viewController = toPresent?.topmostViewController() else {
            assertionFailure("expected `toPresent`")
            return
        }
        viewController.dismiss(animated: animated, completion: completion)
    }
    
    func dismissModule(animated: Bool, completion: CompletionBlock?) {
        guard let viewController = toPresent else {
            assertionFailure("expected `toPresent`")
            return
        }
        viewController.dismiss(animated: animated, completion: completion)
    }
    
}

// MARK: - Root

extension Router {
    
    func setRootModule(_ module: Presentable?) {
        setRootModule(module, hideBar: false)
    }

    func setRootModule(_ module: Presentable?, hideBar: Bool) {
        guard let navigationController = toPresent as? UINavigationController else {
            assertionFailure("expected `UINavigationController`")
            return
        }

        guard let vc = module?.toPresent else {
            assertionFailure("expected `toPresent` in module")
            return
        }
        navigationController.setViewControllers([vc], animated: true)
    }

    func popToRootModule(animated: Bool) {
        guard let navigationController = toPresent as? UINavigationController else {
            assertionFailure("expected `UINavigationController`")
            return
        }
        navigationController.popToRootViewController(animated: animated)
    }
    
}
