//
//  FeedViewModel.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import Foundation

private let logger = Logger(identifier: "FeedViewModel")

protocol FeedViewModelInput {
    func viewDidLoad()
    
    func numberOfRows() -> Int
    func item(for indexPath: IndexPath) -> News
    
    func tapSelectCell(at indexPath: IndexPath)
}

protocol FeedViewModelOutput {
    
}

typealias FeedViewModelProtocol = FeedViewModelInput & FeedViewModelOutput

final class FeedViewModel {
    
    init(coordinator: FeedCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    // MARK: - Private
    
    private let coordinator: FeedCoordinatorProtocol
    private var news: [News] = []
    
}

// MARK: - FeedViewModelInput

extension FeedViewModel: FeedViewModelInput {
    
    func viewDidLoad() {
        fetchNews()
    }
    
    func numberOfRows() -> Int {
        return news.count
    }
    
    func item(for indexPath: IndexPath) -> News {
        return news[indexPath.row]
    }
    
    func tapSelectCell(at indexPath: IndexPath) {
        coordinator.open(news: news[indexPath.row])
    }
    
}

// MARK: - FeedViewModelOutput

extension FeedViewModel: FeedViewModelOutput {
    
}

// MARK: - Network

private extension FeedViewModel {
    
    func fetchNews() {
        self.news = FakeParsser().getNews()
    }
    
}
