//
//  DetailsViewModel.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 16.04.2021.
//

import RxSwift
import RxRelay

private let logger = Logger(identifier: "DetailsViewModel")

protocol DetailsViewModelInput {
    func viewDidLoad()
    
    func tapClose()
    func tapOpenWebSite()
}

protocol DetailsViewModelOutput {
    var article: Observable<Article> { get }
    var formattedPublishAt: Observable<String> { get }
}

typealias DetailsViewModelProtocol = DetailsViewModelInput & DetailsViewModelOutput

final class DetailsViewModel {
    
    // MARK: - Lifecycle
    
    init(coordinator: DetailsCoordinatorProtocol, article: Article) {
        self.coordinator = coordinator
        self.articleSubj = BehaviorRelay<Article>(value: article)
    }
    
    // MARK: - Private
    
    private let coordinator: DetailsCoordinatorProtocol
    private let articleSubj: BehaviorRelay<Article>
    private let publishAtSubj = PublishRelay<String>()
    
}

// MARK: - DetailsViewModelInput

extension DetailsViewModel: DetailsViewModelInput {
    
    func viewDidLoad() {
        formatTime()
    }
    
    func tapClose() {
        coordinator.close()
    }
    
    func tapOpenWebSite() {
        coordinator.openWebSite(urlString: articleSubj.value.url)
    }
    
}

// MARK: - DetailsViewModelOutput

extension DetailsViewModel: DetailsViewModelOutput {
    
    var article: Observable<Article> {
        return articleSubj.asObservable()
    }
    
    var formattedPublishAt: Observable<String> {
        return publishAtSubj.asObservable()
    }
    
}

// MARK: -

private extension DetailsViewModel {
    
    func formatTime() {
        let stringTime = articleSubj.value.publishedAt
        let formattedTime = DateFormatter.formatISO8601(string: stringTime)
        publishAtSubj.accept(formattedTime)
    }
    
}
