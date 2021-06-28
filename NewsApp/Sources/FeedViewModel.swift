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
    func item(for indexPath: IndexPath) -> Article
    
    func tapSelectCell(at indexPath: IndexPath)
    func pullToRefresh(completion: (() -> Void)?)
    func scrollToEnd()
}

protocol FeedViewModelOutput: ViewModelOutput {
    var reloadCells: Observable<Void> { get }
}

typealias FeedViewModelProtocol = FeedViewModelInput & FeedViewModelOutput

final class FeedViewModel: ViewModel {
    
    // MARK: - Lifecycle
    
    init(coordinator: FeedCoordinatorProtocol, networkService: NetworkNewsProtocol) {
        self.coordinator = coordinator
        self.networkService = networkService
        
        super.init()
        
        let articlesCount = numberOfRows()
        viewStateSubj.accept(articlesCount == 0 ? .empty : .ready)
    }
    
    // MARK: - Private
    
    private let coordinator: FeedCoordinatorProtocol
    private let networkService: NetworkNewsProtocol
    private var articles: [Article] = []
    private let reloadCellsSubj = PublishRelay<Void>()
    private var totalResult: Int = -1
    
}

// MARK: - FeedViewModelInput

extension FeedViewModel: FeedViewModelInput {
    
    func viewDidLoad() {
        fetchArticles(country: .ua, pageNumber: 1)
    }
    
    func numberOfRows() -> Int {
        return articles.count
    }
    
    func item(for indexPath: IndexPath) -> Article {
        return articles[indexPath.row]
    }
    
    func tapSelectCell(at indexPath: IndexPath) {
        let article = articles[indexPath.row]
        coordinator.open(article: article)
    }
    
    func pullToRefresh(completion: (() -> Void)?) {
        totalResult = -1
        fetchArticles(country: .ua, pageNumber: 1)
        completion?()
    }
    
    func scrollToEnd() {
        fetchArticles(country: .ua, pageNumber: 2)
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
    
    func fetchArticles(country: Countrys, pageNumber: Int) {
        if articles.count == totalResult {
            return
        }
        
        //TODO: - code for debug application
        
        firstly {
            FakeParsser().getArticlesResponse()
        }.done { response in
            self.articles = response.articles
            self.reloadCellsSubj.accept(())
            self.viewStateSubj.accept(self.numberOfRows() == 0 ? .empty : .ready)
        }
        .catch { error in
            logger.error(error.localizedDescription)
            self.viewStateSubj.accept(.error)
        }

//        firstly {
//            networkService.getNews(country: country, pageNumber: pageNumber)
//        }.done { newsResponse in
//            if pageNumber > 1 {
//                self.articles += newsResponse.articles
//            } else {
//                self.viewStateSubj.accept(.loading)
//                self.articles = newsResponse.articles
//            }
//
//            self.totalResult = newsResponse.totalResults
//            self.reloadCellsSubj.accept(())
//            self.viewStateSubj.accept(self.numberOfRows() == 0 ? .empty : .ready)
//        }.catch { error in
//            logger.error(error.localizedDescription)
//            self.viewStateSubj.accept(.error)
//        }
    }
    
}
