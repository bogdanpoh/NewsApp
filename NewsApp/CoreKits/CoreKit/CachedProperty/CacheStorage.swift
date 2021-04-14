//
//  CacheStorage.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 02.04.2021.
//

import Foundation

enum CachedPropertyKey: String {
    case lastUsedLanguageCode
    case isUserSeenOnboarding
    case isUserSeenTrialPremium
    case isLoadedHashtagsLibrary
    case userCopyTutorialStep
    case activeUserId
    case hasUserPremiumSubscription
}

protocol PropertyStorage {
    func get(for key: CachedPropertyKey) -> Any?
    func set(_ value: Any?, for key: CachedPropertyKey)
    func removeValue(for key: CachedPropertyKey)
}

final class UserDefaultsStorage: PropertyStorage {

    func get(for key: CachedPropertyKey) -> Any? {
        return UserDefaults.standard.value(forKey: key.rawValue)
    }

    func set(_ value: Any?, for key: CachedPropertyKey) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
    }

    func removeValue(for key: CachedPropertyKey) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }

}
