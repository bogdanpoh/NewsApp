//
//  CachedProperty.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 02.04.2021.
//

import Foundation

@propertyWrapper
struct CachedProperty<Value: Codable> {

    init(key: CachedPropertyKey, defaultValue: Value, storage: PropertyStorage = UserDefaultsStorage()) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
    }

    var wrappedValue: Value {
        get {
            guard let data = storage.get(for: key) as? Data else {
                return defaultValue
            }
            let value = try? JSONDecoder().decode(Value.self, from: data)
            return value ?? defaultValue
        }
        set {
            guard let value = newValue as? AnyOptional, value.isNil else {
                let data = try? JSONEncoder().encode(newValue)
                storage.set(data, for: key)
                return
            }
            storage.removeValue(for: key)
        }
    }

    // MARK: - Private

    private let key: CachedPropertyKey
    private let defaultValue: Value

    private let storage: PropertyStorage

}

extension CachedProperty where Value: ExpressibleByNilLiteral {

    init(key: CachedPropertyKey, storage: PropertyStorage = UserDefaultsStorage()) {
        self.init(key: key, defaultValue: nil, storage: storage)
    }

}
