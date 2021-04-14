//
//  LegacyThemeProvider.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 10.04.2021.
//

import Foundation

final class LegacyThemeProvider {
    static let shared = LegacyThemeProvider()
    
    private(set) var theme: AppTheme = .light
    
    private let observers = NSHashTable<AnyObject>.weakObjects()
}

// MARK: - AppThemeProvider

extension LegacyThemeProvider: AppThemeProvider {
    
    func set(theme: AppTheme) {
        self.theme = theme
        observers.allObjects
            .compactMap { $0 as? Themeable }
            .forEach { $0.apply(theme: theme) }
    }

    func register<Observer: Themeable>(observer: Observer) {
        observers.add(observer)
        observer.apply(theme: theme)
    }
    
    func unregister<Observer: Themeable>(observer: Observer) {
        observers.remove(observer)
    }
    
}
