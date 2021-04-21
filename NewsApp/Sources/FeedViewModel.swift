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
    func scrollToEnd()
}

protocol FeedViewModelOutput {
    var reloadCells: Observable<Void> { get }
}

typealias FeedViewModelProtocol = FeedViewModelInput & FeedViewModelOutput

final class FeedViewModel {
    
    // MARK: - Lifecycle
    
    init(coordinator: FeedCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    // MARK: - Private
    
    private let coordinator: FeedCoordinatorProtocol
    private var news: [News] = []
    private var isLoadingFull: Bool = false
    private var currentLoadingPage: Int = 1
    private let reloadCellsSubj = PublishRelay<Void>()
    
}

// MARK: - FeedViewModelInput

extension FeedViewModel: FeedViewModelInput {
    
    func viewDidLoad() {
        fetchNews(for: currentLoadingPage)
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
    
    func scrollToEnd() {
        fetchNews(for: currentLoadingPage)
    }
    
}

// MARK: - FeedViewModelOutput

extension FeedViewModel: FeedViewModelOutput {
    
    var reloadCells: Observable<Void> {
        return reloadCellsSubj.asObservable()
    }
    
}

// MARK: -

private extension FeedViewModel {
    
    func addNews(newsResponse: NewsResponse) {
        let newCount = news.count + newsResponse.articles.count
        guard newCount <= newsResponse.totalResults else {
            isLoadingFull = true
            return
        }
        
        news += newsResponse.articles
    }
    
}

// MARK: - Network

private extension FeedViewModel {
    
    func fetchNews(for pagNumber: Int = 1) {
        guard !isLoadingFull else {
            return
        }
        
        NetworkService().getNews(country: .ua, pageNumber: pagNumber)
            .done { [weak self] newsResponse in
                self?.addNews(newsResponse: newsResponse)
            }
            .catch { error in
                logger.debug(error.localizedDescription)
            }
            .finally { [weak self] in
                self?.reloadCellsSubj.accept(())
                self?.currentLoadingPage += 1
            }
    }
    
}
