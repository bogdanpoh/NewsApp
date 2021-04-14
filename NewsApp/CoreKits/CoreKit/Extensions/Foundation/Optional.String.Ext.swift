//
//  Optional.String.Ext.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 02.04.2021.
//

import Foundation

extension Optional where Wrapped == String {
    
    var orEmpty: String {
        return self ?? ""
    }
    
    func or(_ text: String) -> String {
        return self ?? text
    }
    
}
