//
//  NSObject.swift
//  NewsApp
//
//  Created by Bohdan Pokhidnia on 20.06.2022.
//

import Foundation

extension NSObject {
    
    static var className: String {
        return String(describing: self)
    }
    
}
