//
//  FeedViewModel.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import RxSwift
import RxRelay

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
        self.newsAtSubj = BehaviorRelay<[News]>(value: [])
    }
    
    // MARK: - Private
    
    private let coordinator: FeedCoordinatorProtocol
    private var newsAtSubj: BehaviorRelay<[News]>
    private let reloadCellsSubj = PublishRelay<Void>()
    
}

// MARK: - FeedViewModelInput

extension FeedViewModel: FeedViewModelInput {
    
    func viewDidLoad() {
        fetchNews()
    }
    
    func numberOfRows() -> Int {
        return newsAtSubj.value.count
    }
    
    func item(for indexPath: IndexPath) -> News {
        return newsAtSubj.value[indexPath.row]
    }
    
    func tapSelectCell(at indexPath: IndexPath) {
        coordinator.open(news: newsAtSubj.value[indexPath.row])
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
        let newsConstants = Constants.NewsApi.self
        
        NetworkService(
            domainString: newsConstants.domainString,
            country: newsConstants.country,
            apiKey: newsConstants.apiKey
        ).getNews { [weak self] result in
            switch result {
            case .success(let news):
                self?.newsAtSubj.accept(news)
                self?.reloadCellsSubj.accept(())
                
            case .failure(let error):
                print("Error when get news from network: \(error)")
            }
        }
    }
    
}
