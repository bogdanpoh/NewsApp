//
//  DateFormatting.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 02.04.2021.
//

import Foundation

private let dateFormatter = DateFormatterFabric.makeNumberFormatter(for: .ddMMMyyyy)

enum DateFormatStyle: String {
    /// 09:15
    case HHmm = "HH:mm"
    
    /// 20 Jan 2000
    case ddMMMyyyy = "dd MMM yyyy"
    
    /// 20.012000 - 09:15:00
    case full = "dd.MM.yyyy - HH:mm:ss"
    
    /// Jan 20, 2000 - 09:15
    case mayDayYear = "MMM dd, yyyy - HH:mm"
}

enum DateFormatterFabric {
    
    static func makeNumberFormatter(for dateStyle: DateFormatStyle) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateStyle.rawValue
        return dateFormatter
    }
    
}

// MARK: - Date

protocol DateFormatting {
    func format(for style: DateFormatStyle) -> String
}

extension Date: DateFormatting {
    
    func format(for style: DateFormatStyle) -> String {
        dateFormatter.dateFormat = style.rawValue
        return dateFormatter.string(from: self)
    }
    
}
