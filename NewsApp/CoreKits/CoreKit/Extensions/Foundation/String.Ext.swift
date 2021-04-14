//
//  String.Ext.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 02.04.2021.
//

import Foundation

extension String {
    
    var isNotEmpty: Bool { !isEmpty }
    var asURL: URL? { URL(string: self) }
    var asLocalURL: URL? { URL(fileURLWithPath: self) }
    
}
