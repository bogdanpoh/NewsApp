//
//  UserManager.swift
//  NewsApp
//
//  Created by Bohdan Pokhidnia on 10.07.2022.
//

import Foundation

protocol UserManagerProtocol {
    var selectedCountry: String? { get set }
    var country: Country { get }
}

class UserManager: UserManagerProtocol {
    @UserDefault("selectedCountry", defaultValue: Country.ua.rawValue) var selectedCountry: String?
    
    var country: Country {
        return Country(rawValue: selectedCountry ?? Country.ua.rawValue) ?? .ua
    }
}
