//
//  BaseCoordinator.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 10.04.2021.
//

import Foundation

protocol BaseCoordinatorProtocol {
    func add(dependency coordinator: Coordinatable)
    func remove(dependency coordinator: Coordinatable)
}

class BaseCoordinator {
    var childCoordinators: [Coordinatable] = []
}

extension BaseCoordinator: BaseCoordinatorProtocol {
    
    func add(dependency coordinator: Coordinatable) {
        if childCoordinators.contains(where: { $0 === coordinator }) {
            return
        }
        childCoordinators.append(coordinator)
    }
    
    func remove(dependency coordinator: Coordinatable) {
        if childCoordinators.isEmpty {
            return
        }
        
        guard let index = childCoordinators.firstIndex(where: { $0 === coordinator }) else {
            return
        }
        
        childCoordinators.remove(at: index)
    }
    
}
