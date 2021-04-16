//
//  DetailViewModel.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 16.04.2021.
//

import Foundation

private let logger = Logger(identifier: "DetailViewModel")

protocol DetailViewModelInput {
    
}

protocol DetailViewModelOutput {
    
}

typealias DetailViewModelProtocol = FeedViewModelInput & FeedViewModelOutput

final class DetailViewModel {
    
    init(coordinator: DetailsCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    // MARK: - Private
    
    private let coordinator: DetailsCoordinatorProtocol
    
}

// MARK: - DetailViewModelInput

extension DetailViewModel: DetailViewModelInput {
    
}

// MARK: - DetailViewModelOutput

extension DetailViewModel: DetailViewModelOutput {
    
}
