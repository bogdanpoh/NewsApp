//
//  Constants.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import Foundation

enum Constants {
    
    enum NewsApi {
        static let domainString = "https://newsapi.org/v2/top-headlines"
        static let country = "ua"
        static let apiKey = StorageKeys.NewsApiKey.apiKey
    }
    
}
