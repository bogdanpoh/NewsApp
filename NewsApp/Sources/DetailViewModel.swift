//
//  DetailViewModel.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 16.04.2021.
//

import RxSwift
import RxRelay

private let logger = Logger(identifier: "DetailViewModel")

protocol DetailViewModelInput {
    func viewDidLoad()
    
    func tapOpenWebSite()
}

protocol DetailViewModelOutput {
    var news: Observable<News> { get }
    var formattedPublishAt: Observable<String> { get }
}

typealias DetailViewModelProtocol = FeedViewModelInput & FeedViewModelOutput

final class DetailViewModel {
    
    // MARK: - Lifecycle
    
    init(coordinator: DetailsCoordinatorProtocol, news: News) {
        self.coordinator = coordinator
        self.newsSubj = BehaviorRelay<News>(value: news)
    }
    
    // MARK: - Private
    
    private let coordinator: DetailsCoordinatorProtocol
    private let newsSubj: BehaviorRelay<News>
    private let publishAtSubj = PublishRelay<String>()
    
}

// MARK: - DetailViewModelInput

extension DetailViewModel: DetailViewModelInput {
    
    func viewDidLoad() {
        let stringTime = newsSubj.value.publishedAt
        let formattedTime = DateFormatter.formatISO8601(string: stringTime)
        publishAtSubj.accept(formattedTime)
    }
    
    func tapOpenWebSite() {
//        print("tap open: \(news.url)")
    }
    
}

// MARK: - DetailViewModelOutput

extension DetailViewModel: DetailViewModelOutput {
    
    var news: Observable<News> {
        return newsSubj.asObservable()
    }
    
    var formattedPublishAt: Observable<String> {
        return publishAtSubj.asObservable()
    }
    
}
