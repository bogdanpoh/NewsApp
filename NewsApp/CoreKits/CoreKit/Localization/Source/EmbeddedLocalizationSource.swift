//
//  EmbeddedLocalizationSource.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 02.04.2021.
//

import Foundation

extension Localization {

    final class EmbeddedLocalizationSource: LocalizationSource {
        let defaultLanguage: Language = .uk
        let supportLanguages: [Language]

        init() {
            let mainLocalizations = Bundle.main.localizations
            supportLanguages = mainLocalizations.compactMap { Language(rawValue: $0) }
        }

        func makeReader(for language: Language) throws -> Reader {
            guard let path = Bundle.main.path(forResource: language.rawValue, ofType: "lproj") else {
                throw Error.languageNotSupported
            }
            guard let bundle = Bundle(path: path) else {
                throw Error.languageNotSupported
            }

            return { return NSLocalizedString($0, bundle: bundle, comment: "") }
        }

        func support(_ language: Language) -> Bool {
            return supportLanguages.contains(language)
        }

    }

}
