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
    var article: Observable<Article> { get }
    var formattedPublishAt: Observable<String> { get }
}

typealias DetailViewModelProtocol = FeedViewModelInput & FeedViewModelOutput

final class DetailViewModel {
    
    // MARK: - Lifecycle
    
    init(coordinator: DetailCoordinatorProtocol, article: Article) {
        self.coordinator = coordinator
        self.articleSubj = BehaviorRelay<Article>(value: article)
    }
    
    // MARK: - Private
    
    private let coordinator: DetailCoordinatorProtocol
    private let articleSubj: BehaviorRelay<Article>
    private let publishAtSubj = PublishRelay<String>()
    
}

// MARK: - DetailViewModelInput

extension DetailViewModel: DetailViewModelInput {
    
    func viewDidLoad() {
        formatTime()
    }
    
    func tapOpenWebSite() {
        coordinator.openWebSite()
    }
    
}

// MARK: - DetailViewModelOutput

extension DetailViewModel: DetailViewModelOutput {
    
    var article: Observable<Article> {
        return articleSubj.asObservable()
    }
    
    var formattedPublishAt: Observable<String> {
        return publishAtSubj.asObservable()
    }
    
}

// MARK: -

private extension DetailViewModel {
    
    func formatTime() {
        let stringTime = articleSubj.value.publishedAt
        let formattedTime = DateFormatter.formatISO8601(string: stringTime)
        publishAtSubj.accept(formattedTime)
    }
    
}
