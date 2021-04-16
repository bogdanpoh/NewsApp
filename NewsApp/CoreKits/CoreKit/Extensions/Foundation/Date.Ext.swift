//
//  Date.Ext.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 02.04.2021.
//

import Foundation

extension Date {
    
    var dayNumber: Int {
        let calendar = Calendar(identifier: .gregorian)
        let monthComponent = (calendar as NSCalendar).component(.day, from: self)
        return monthComponent
    }
    
    var monthNumber: Int {
        let calendar = Calendar(identifier: .gregorian)
        let monthComponent = (calendar as NSCalendar).component(.month, from: self)
        return monthComponent
    }
    
    var yearNumber: Int {
        let calendar = Calendar(identifier: .gregorian)
        let monthComponent = (calendar as NSCalendar).component(.year, from: self)
        return monthComponent
    }
    
    var monthName: String {
        let monthName = DateFormatter.localizedFormatter.monthSymbols[monthNumber - 1]
        return monthName
    }
    
    static var now: Date { Date() }
    static var today: Date { Date() }
    
    var firstDayOfMonth: Date {
        let components = Calendar(identifier: .gregorian).dateComponents([.month, .year], from: self)
        return Calendar(identifier: .gregorian).date(from: components) ?? .today
    }
    
    var lastDayOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: firstDayOfMonth)!
    }
    
}

extension DateFormatter {
    
    static var localizedFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Localization.Manager.shared.locale
        return formatter
    }
    
    static func formatISO8601(_ string: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateFormatterPrint = DateFormatterFabric.makeNumberFormatter(for: .full)
        let date = dateFormatterGet.date(from: string)
        
        guard let dateFromString = date else {
            return string
        }
        
        return dateFormatterPrint.string(from: dateFromString)
    }
    
}
