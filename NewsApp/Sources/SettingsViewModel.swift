//
//  SettingsViewModel.swift
//  NewsApp
//
//  Created by Bohdan Pokhidnia on 04.07.2022.
//

import RxSwift
import RxRelay

private let logger = Logger(identifier: "SettingsViewModel")

protocol SettingsViewModelInput {
    func countMenuItems() -> Int
    func menuItem(for indexPath: IndexPath) -> SettingsMenuItem
    func tapSelectMenuItem(at indexPath: IndexPath)
    
    func countCountries() -> Int
    func country(for indexPath: IndexPath) -> Country
    func tapSelectCountry(at indexPath: IndexPath)
}

protocol SettingsViewModelOutput {
    var selectedCountry: Observable<IndexPath> { get }
}

typealias SettingsViewModelProtocol = SettingsViewModelInput & SettingsViewModelOutput

final class SettingsViewModel: ViewModel {
    
    // MARK: - Initializers
    
    init(coordinator: SettingsCoordinatorProtocol, countrySubject: BehaviorRelay<Country>) {
        self.coordinator = coordinator
        countries = Country.allCases
        
        let selectedCountryIndex = countries.firstIndex(of: countrySubject.value) ?? 0
        selectedCountrySubj = .init(value: .init(row: selectedCountryIndex, section: 0))
        
        self.countrySubject = countrySubject
        super.init()
    }
    
    // MARK: - Private
    
    private let coordinator: SettingsCoordinatorProtocol
    private let countries: [Country]
    private let selectedCountrySubj: BehaviorSubject<IndexPath>
    private let countrySubject: BehaviorRelay<Country>
    
}

// MARK: - SettingsViewModelInput

extension SettingsViewModel: SettingsViewModelInput {
    
    func countMenuItems() -> Int {
        return SettingsMenuItem.allCases.count
    }
    
    func menuItem(for indexPath: IndexPath) -> SettingsMenuItem {
        return SettingsMenuItem(rawValue: indexPath.row) ?? .country
    }
    
    func tapSelectMenuItem(at indexPath: IndexPath) {
        guard let menuItem = SettingsMenuItem(rawValue: indexPath.row) else { return }
        
        logger.info("Tapped on \(menuItem.title)")
        
        coordinator.openLanguage()
    }
    
    func countCountries() -> Int {
        return countries.count
    }
    
    func country(for indexPath: IndexPath) -> Country {
        return countries[indexPath.row]
    }
    
    func tapSelectCountry(at indexPath: IndexPath) {
        let country = countries[indexPath.row]
        selectedCountrySubj.onNext(indexPath)
        countrySubject.accept(country)
        
        logger.info("tapped on county: \(country.title)")
    }
    
}

// MARK: - SettingsViewModelOutput

extension SettingsViewModel: SettingsViewModelOutput {
    
    var selectedCountry: Observable<IndexPath> {
        return selectedCountrySubj.asObservable()
    }
    
}
