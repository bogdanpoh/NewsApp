//
//  DetailViewModel.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 16.04.2021.
//

import Foundation

private let logger = Logger(identifier: "DetailViewModel")

protocol DetailViewModelInput {
    func tapOpenWebSite()
}

protocol DetailViewModelOutput {
    var news: News { get }
    var formattedPublishAt: String { get }
}

typealias DetailViewModelProtocol = FeedViewModelInput & FeedViewModelOutput

final class DetailViewModel {
    
    let news: News
    
    init(coordinator: DetailsCoordinatorProtocol, news: News) {
        self.coordinator = coordinator
        self.news = news
    }
    
    // MARK: - Private
    
    private let coordinator: DetailsCoordinatorProtocol
    
}

// MARK: - DetailViewModelInput

extension DetailViewModel: DetailViewModelInput {
    
    func tapOpenWebSite() {
        print("tap open: \(news.url)")
    }
    
}

// MARK: - DetailViewModelOutput

extension DetailViewModel: DetailViewModelOutput {
    
    var formattedPublishAt: String {
        return DateFormatter.formatISO8601(news.publishedAt)
    }
    
}
