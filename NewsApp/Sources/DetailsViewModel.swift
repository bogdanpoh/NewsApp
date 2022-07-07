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
    
    func close()
    func tapOpenWebSite()
    func tapShareArticle()
}

protocol DetailsViewModelOutput {
    var article: Observable<Article> { get }
    var authorCopyright: Observable<String> { get }
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
    private let authorCopyrightSubj = PublishRelay<String>()
    
}

// MARK: - DetailsViewModelInput

extension DetailsViewModel: DetailsViewModelInput {
    
    func viewDidLoad() {
        makeAuthorCopyright()
    }
    
    func close() {
        coordinator.close()
    }
    
    func tapOpenWebSite() {
        coordinator.openWebSite(urlString: articleSubj.value.url)
    }
    
    func tapShareArticle() {
        coordinator.shareText(text: articleSubj.value.url)
    }
    
}

// MARK: - DetailsViewModelOutput

extension DetailsViewModel: DetailsViewModelOutput {
    
    var article: Observable<Article> {
        return articleSubj.asObservable()
    }
    
    var authorCopyright: Observable<String> {
        return authorCopyrightSubj.asObservable()
    }
    
}

// MARK: - Formatted copyright

private extension DetailsViewModel {
    
    func makeAuthorCopyright() {
        let stringTime = articleSubj.value.publishedAt
        let formattedTime = DateFormatter.formatISO8601(string: stringTime)
        let author = articleSubj.value.author ?? R.string.localizable.feedWithoutAuthor()
        let authorCopyrightWithTime = "\(author) | \(formattedTime)"
        
        authorCopyrightSubj.accept(authorCopyrightWithTime)
    }
    
}
