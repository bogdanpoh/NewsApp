//
//  Logger.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 02.04.2021.
//

import Foundation

protocol Loggable {
    func debug(_ message: @autoclosure () -> String)
    func info(_ message: @autoclosure () -> String)
    func mark()
    func error(_ message: @autoclosure () -> String)
    func network(_ message: @autoclosure () -> String)
}

struct Logger {
    init(identifier: String = "") {
        self.identifier = identifier
    }
    
    private func log(level: Level, message: @autoclosure () -> String) {
        outputs.forEach {
            $0.log(level: level, message: identifier + ": " + message())
        }
    }
    
    // MARK: - Private
    
    private var identifier: String
    private let outputs: [LogOutput] = [ConsoleOutput()]
}

// MARK: - Logger level

extension Logger {
    
    enum Level {
        case debug
        case info
        case error
        case network
        
        var icon: String {
            switch self {
            case .debug:
                return "👀"
                
            case .info:
                return "ℹ️"
                
            case .error:
                return "❗️"
                
            case .network:
                return "📶"
            }
        }
    }
    
}

// MARK: - Loggable

extension Logger: Loggable {
    
    func debug(_ message: @autoclosure () -> String) {
        log(level: .debug, message: message())
    }
    
    func info(_ message: @autoclosure () -> String) {
        log(level: .info, message: message())
    }
    
    func mark() {
        log(level: .info, message: "\(#function)")
    }
    
    func error(_ message: @autoclosure () -> String) {
        log(level: .error, message: message())
    }
    
    func network(_ message: @autoclosure () -> String) {
        log(level: .network, message: message())
    }
    
}
