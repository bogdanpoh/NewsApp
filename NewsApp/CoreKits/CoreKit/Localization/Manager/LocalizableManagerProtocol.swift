//
//  LocalizableManagerProtocol.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 02.04.2021.
//

import Foundation

protocol LocalizableManagerProtocol {
    var language: Language { get }
    var locale: Locale { get }

    subscript(_ key: String) -> String { get }
    
    func set(language: Language) throws
}
