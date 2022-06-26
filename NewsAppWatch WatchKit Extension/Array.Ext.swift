//
//  Array.Ext.swift
//  NewsAppWatch WatchKit Extension
//
//  Created by Bohdan Pokhidnia on 26.06.2022.
//

import Foundation

extension Array {
    
    subscript (safe index: Index) -> Iterator.Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
    
}

