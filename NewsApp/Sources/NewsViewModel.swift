//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import Foundation

private let logger = Logger(identifier: "NewsViewModel")

protocol NewsViewModelInput {
    
}

protocol NewsViewModelOutput {
    
}

typealias NewsViewModelProtocol = NewsViewModelInput & NewsViewModelOutput

final class NewsViewModel {
    
    init(coordinator: NewsCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    // MARK: - Private
    
    private let coordinator: NewsCoordinatorProtocol
    
}

// MARK: - NewsViewModelInput

extension NewsViewModel: NewsViewModelInput {
    
}

// MARK: - NewsViewModelOutput

extension NewsViewModel: NewsViewModelOutput {
    
}
