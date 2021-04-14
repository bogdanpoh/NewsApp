//
//  NumberFormatting.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 02.04.2021.
//

import Foundation

private let numberFormatter = NumberFormatterFabric.makeNumberFormatter()

enum NumberFormatterFabric {
    
    static func makeNumberFormatter(maximumFractionDigits: Int = 2) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSize = 3
        formatter.maximumFractionDigits = maximumFractionDigits
        return formatter
    }
    
}

// MARK: - Number

protocol NumberFormatting {
    func number(minimumFractionDigits: Int, maximumFractionDigits: Int) -> String
}

extension NumberFormatting {
    
    func number(minimumFractionDigits: Int = 0, maximumFractionDigits: Int = 2) -> String {
        guard let number = self as? NSNumber else {
            assertionFailure("required number")
            return ""
        }
        numberFormatter.minimumFractionDigits = minimumFractionDigits
        numberFormatter.maximumFractionDigits = maximumFractionDigits
        return numberFormatter.string(from: number).orEmpty
    }
    
}

extension Int: NumberFormatting {}
extension Double: NumberFormatting {}
extension Float: NumberFormatting {}
