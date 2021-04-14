//
//  LogOutput.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 02.04.2021.
//

import Foundation

protocol LogOutput {
    func log(level: Logger.Level, message: @autoclosure () -> String)
}
