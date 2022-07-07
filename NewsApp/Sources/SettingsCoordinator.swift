//
//  SettingsCoordinator.swift
//  NewsApp
//
//  Created by Bohdan Pokhidnia on 04.07.2022.
//

import Foundation
import RxRelay

protocol SettingsCoordinatorProtocol {
    func openLanguage()
    func back()
}

final class SettingsCoordinator: BaseCoordinator, CoordinatorOutput {
    
    var finishFlow: CompletionBlock?
    
    // MARK: - Initializers
    
    init(router: Routable, moduleFactory: SettingsModuleFactoryProtocol, countrySubject: BehaviorRelay<Country>) {
        self.router = router
        self.moduleFactory = moduleFactory
        self.countrySubject = countrySubject
        
        super.init()
    }
    
    // MARK: - Private
    
    private let router: Routable
    private let moduleFactory: SettingsModuleFactoryProtocol
    private let countrySubject: BehaviorRelay<Country>
    
}

// MARK: - Coordinatable

extension SettingsCoordinator: Coordinatable {
    
    func start() {
        let view = moduleFactory.makeSettingsView(coordinaor: self, countrySubject: countrySubject)
        router.push(view)
    }
    
}

// MARK: - SettingsCoordinatorProtocol

extension SettingsCoordinator: SettingsCoordinatorProtocol {
    
    func openLanguage() {
        let view = moduleFactory.makeCountryView(coordinator: self, countrySubject: countrySubject)
        router.push(view)
    }
    
    func back() {
        router.popModule()
    }
    
}
