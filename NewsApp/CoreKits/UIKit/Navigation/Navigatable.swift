//
//  Navigatable.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 10.04.2021.
//

import Foundation

protocol Navigatable {
    associatedtype Destination
    func navigate(to destination: Destination)
}
