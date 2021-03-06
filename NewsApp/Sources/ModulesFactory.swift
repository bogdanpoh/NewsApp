//
//  ModulesFactory.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import Swinject

final class ModulesFactory {
    
    let dependencyContainer: Container = {
        let container = Container()
        container.register(NetworkNewsProtocol.self) { _ in NetworkService() }
        container.register(UserManagerProtocol.self) { _ in UserManager() }
        container.register(WatchManagerProtocol.self) { _ in WatchManager() }
        container.register(Loggable.self) { _ in Logger() }
        return container
    }()
    
}

