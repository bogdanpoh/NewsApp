//
//  SettingsModuleFactory.swift
//  NewsApp
//
//  Created by Bohdan Pokhidnia on 04.07.2022.
//

import Foundation
import RxRelay

protocol SettingsModuleFactoryProtocol {
    func makeSettingsView(coordinaor: SettingsCoordinatorProtocol, countrySubject: BehaviorRelay<Country>) -> Presentable
    func makeCountryView(coordinator: SettingsCoordinatorProtocol, countrySubject: BehaviorRelay<Country>) -> Presentable
}

extension ModulesFactory: SettingsModuleFactoryProtocol {
    
    func makeSettingsView(coordinaor: SettingsCoordinatorProtocol, countrySubject: BehaviorRelay<Country>) -> Presentable {
        let viewModel = SettingsViewModel(
            coordinator: coordinaor,
            watchManager: dependencyContainer.resolve(WatchManagerProtocol.self)!,
                                          countrySubject: countrySubject
        )
        let viewController = SettingsViewController(viewModel: viewModel)
        
        return viewController
    }
    
    func makeCountryView(coordinator: SettingsCoordinatorProtocol, countrySubject: BehaviorRelay<Country>) -> Presentable {
        let viewModel = SettingsViewModel(
            coordinator: coordinator,
            watchManager: dependencyContainer.resolve(WatchManagerProtocol.self)!,
            countrySubject: countrySubject
        )
        let viewController = SettingsCountryViewController(viewModel: viewModel)
        
        return viewController
    }
    
}
