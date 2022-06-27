//
//  Constants.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import Foundation
import Rswift

enum Constants {
    
    enum NewsApi {
        enum Countrys: String, CaseIterable {
            case ua
            case us
            case gb
            
            #if os(iOS)
            var title: String {
                switch self {
                case .ua:
                    return R.string.localizable.countryUa()
                    
                case .us:
                    return R.string.localizable.countryUsa()
                    
                case .gb:
                    return R.string.localizable.countryGb()
                }
            }
            #endif
        }
        
        static let domainString = "https://newsapi.org/v2/top-headlines"
        static let apiKey: String = StorageKeys.newsApiKey
    }
    
}
