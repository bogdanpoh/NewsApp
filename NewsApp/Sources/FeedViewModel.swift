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
    func viewWillAppper()
    
    func numberOfRows() -> Int
    func item(for indexPath: IndexPath) -> Article
    
    func tapSelectCell(at indexPath: IndexPath)
    func pullToRefresh(completion: (() -> Void)?)
    func scrollToEnd()
    func settingsTap()
}

protocol FeedViewModelOutput: ViewModelOutput {
    var reloadCells: Observable<Void> { get }
    var scrollToTop: Observable<Void> { get }
}

typealias FeedViewModelProtocol = FeedViewModelInput & FeedViewModelOutput

final class FeedViewModel: ViewModel {
    
    // MARK: - Initializers
    
    init(coordinator: FeedCoordinatorProtocol, networkService: NetworkNewsProtocol, userManager: UserManagerProtocol) {
        self.coordinator = coordinator
        self.networkService = networkService
        self.userManager = userManager
        self.countrySubj = BehaviorRelay<Country>(value: userManager.country)
        
        super.init()
        
        let articlesCount = numberOfRows()
        viewStateSubj.accept(articlesCount == 0 ? .empty : .ready)
    }
    
    // MARK: - Private
    
    private let coordinator: FeedCoordinatorProtocol
    private let networkService: NetworkNewsProtocol
    private var userManager: UserManagerProtocol
    
    private let reloadCellsSubj = PublishRelay<Void>()
    private let scrollToTopSubj = PublishRelay<Void>()
    private let countrySubj: BehaviorRelay<Country>
    
    private var totalResult: Int = -1
    private var articles: [Article] = []
    private var lastCountry: Country?
    
}

// MARK: - FeedViewModelInput

extension FeedViewModel: FeedViewModelInput {
    
    func viewDidLoad() {
        lastCountry = countrySubj.value
        
        fetchArticles(country: countrySubj.value, pageNumber: 1)
    }
    
    func viewWillAppper() {
        let newCountry = countrySubj.value
        guard newCountry != lastCountry else { return }
        
        viewStateSubj.accept(.loading)
        lastCountry = newCountry
        userManager.selectedCountry = newCountry.rawValue
        
        fetchArticles(forNewCountry: newCountry)
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
        fetchArticles(country: countrySubj.value, pageNumber: 1)
        completion?()
    }
    
    func scrollToEnd() {
        fetchArticles(country: countrySubj.value, pageNumber: 2)
    }
    
    func settingsTap() {
        coordinator.openSettings(countrySubject: countrySubj)
    }
    
}

// MARK: - FeedViewModelOutput

extension FeedViewModel: FeedViewModelOutput {
    
    var reloadCells: Observable<Void> {
        return reloadCellsSubj.asObservable()
    }
    
    var scrollToTop: Observable<Void> {
        return scrollToTopSubj.asObservable()
    }
    
}

// MARK: - Network

private extension FeedViewModel {
    
    func fetchArticles(country: Country, pageNumber: Int) {
        if articles.count == totalResult {
            return
        }
        
        //TODO: - code for debug application
        
//        firstly {
//            FakeParsser().getArticlesResponse()
//        }.done { response in
//            self.articles = response.articles
//            self.reloadCellsSubj.accept(())
//            self.viewStateSubj.accept(self.numberOfRows() == 0 ? .empty : .ready)
//        }
//        .catch { error in
//            logger.error(error.localizedDescription)
//            self.viewStateSubj.accept(.error)
//        }

        firstly {
            networkService.getNews(country: country, pageNumber: pageNumber, pageSize: nil)
        }.done { newsResponse in
            if pageNumber > 1 {
                self.articles += newsResponse.articles
            } else {
                self.viewStateSubj.accept(.loading)
                self.articles = newsResponse.articles
            }

            self.totalResult = newsResponse.totalResults
            self.reloadCellsSubj.accept(())
            self.viewStateSubj.accept(self.numberOfRows() == 0 ? .empty : .ready)
        }.catch { error in
            logger.error(error.localizedDescription)
            self.viewStateSubj.accept(.error)
        }
    }
    
    func fetchArticles(forNewCountry country: Country, pageNumber: Int = 1, pageSize: Int? = nil) {
        firstly {
            networkService.getNews(country: country, pageNumber: pageNumber, pageSize: pageSize)
        }.done { newsResponse in
            self.articles.removeAll()
            self.articles = newsResponse.articles
            
            self.totalResult = newsResponse.totalResults
            self.viewStateSubj.accept(self.numberOfRows() == 0 ? .empty : .ready)
            self.reloadCellsSubj.accept(())
            self.scrollToTopSubj.accept(())
        }.catch { error in
            logger.error(error.localizedDescription)
            self.viewStateSubj.accept(.error)
        }
    }
    
}
