//
//  Localization.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 02.04.2021.
//

import Foundation

enum Language: String, Codable {
    case uk
    case ru
}

final class Localization {
    typealias Source = LocalizationSource
    typealias Reader = (String) -> String
    
    var language: Language { manager.language }
    
    // MARK: - Initializers

    init(manager: LocalizableManagerProtocol = Manager.shared) {
        self.manager = manager
    }

    subscript(_ key: String) -> String {
        return manager[key]
    }

    // MARK: - Private

    private let manager: LocalizableManagerProtocol
}
