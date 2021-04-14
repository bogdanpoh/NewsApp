//
//  CoordinatorOutput.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 10.04.2021.
//

import Foundation

protocol CoordinatorOutput: class {
    var finishFlow: CompletionBlock? { get set }
}
