//
//  AnyOptional.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 02.04.2021.
//

import Foundation

protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {

    var isNil: Bool { self == nil }

}
