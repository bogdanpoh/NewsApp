//
//  NewsErrorType.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 20.04.2021.
//

import Foundation

enum NetworkErrorType {
    case unknown
}

struct NetworkError: Error {
    var code: Int
    var errorType: NetworkErrorType
    var message: String
}
