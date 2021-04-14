//
//  Localization.Manager.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 02.04.2021.
//

import Foundation

extension Localization {

    final class Manager: LocalizableManagerProtocol {
        static let shared = Manager()
        
        private(set) var language: Language
        private(set) var locale: Locale = Locale(identifier: "uk_UA")

        // MARK: -

        subscript(_ key: String) -> String {
            return reader(key)
        }

        func set(language: Language) throws {
            reader = try source.makeReader(for: language)
            Self.lastUsedLanguage = language
        }

        // MARK: - Private

        private let source: Source
        private var reader: Reader

        private init() {
            let embeddedSource = EmbeddedLocalizationSource()

            if let lastLanguage = Self.lastUsedLanguage, embeddedSource.support(lastLanguage) {
                language = lastLanguage
            } else {
                language = embeddedSource.defaultLanguage
            }

            source = embeddedSource
            reader = try! source.makeReader(for: language)
        }

        // MARK: - Private static

        @CachedProperty(key: .lastUsedLanguageCode)
        private static var lastUsedLanguage: Language?

    }

}

