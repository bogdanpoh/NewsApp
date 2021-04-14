//
//  LocalizationSource.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 02.04.2021.
//

import Foundation

protocol LocalizationSource {
    var defaultLanguage: Language { get }
    var supportLanguages: [Language] { get }

    func makeReader(for language: Language) throws -> Localization.Reader
    func support(_ language: Language) -> Bool
}
