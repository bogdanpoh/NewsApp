//
//  FeedViewModel.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import RxSwift
import RxRelay
import PromiseKit

private let logger = Logger(identifier: "FeedViewModel")

protocol FeedViewModelInput {
    func viewDidLoad()
    
    func numberOfRows() -> Int
    func item(for indexPath: IndexPath) -> News
    
    func tapSelectCell(at indexPath: IndexPath)
}

protocol FeedViewModelOutput {
    var reloadCells: Observable<Void> { get }
}

typealias FeedViewModelProtocol = FeedViewModelInput & FeedViewModelOutput

final class FeedViewModel {
    
    init(coordinator: FeedCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    // MARK: - Private
    
    private let coordinator: FeedCoordinatorProtocol
    private var news: [News] = []
    private let reloadCellsSubj = PublishRelay<Void>()
    
}

// MARK: - FeedViewModelInput

extension FeedViewModel: FeedViewModelInput {
    
    func viewDidLoad() {
        fetchNews()
    }
    
    func numberOfRows() -> Int {
        print(news.count)
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
    
    var reloadCells: Observable<Void> {
        return reloadCellsSubj.asObservable()
    }
    
}

// MARK: - Network

private extension FeedViewModel {
    
    func fetchNews() {
        NetworkService().getNews(country: .ua)
            .done { [weak self] news in
                self?.news = news
                self?.reloadCellsSubj.accept(())
            }
            .catch { error in
                print(error)
            }
    }
    
}
