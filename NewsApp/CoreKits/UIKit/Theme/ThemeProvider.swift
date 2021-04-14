//
//  ThemeProvider.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 10.04.2021.
//

import Foundation

protocol AppThemeProvider {
    var theme: AppTheme { get }

    func set(theme: AppTheme)

    func register<Observer: Themeable>(observer: Observer)
    func unregister<Observer: Themeable>(observer: Observer)
}
