//
//  NetworkService.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 19.04.2021.
//

import PromiseKit

typealias Country = Constants.NewsApi.Countrys

protocol NetworkNewsProtocol {
    func getNews(country: Country, pageNumber: Int?, pageSize: Int?) -> Promise<ArticleResponse>
}

final class NetworkService {
    
    // MARK: - Initializers
    
    init() {
        self.urlComponents = URLComponents(string: Constants.NewsApi.domainString)
        self.urlComponents?.queryItems = [
            URLQueryItem(name: "apiKey", value: Constants.NewsApi.apiKey)
        ]
    }
    
    // MARK: - Private
    
    private var urlComponents: URLComponents?
    
}

// MARK: - NetworkNewsProtocol

extension NetworkService: NetworkNewsProtocol {
    
    func getNews(country: Country, pageNumber: Int?, pageSize: Int?) -> Promise<ArticleResponse> {
        return Promise { resolver in
            guard var queryComponents = urlComponents else {
                resolver.reject(NetworkError(code: 400, errorType: .unknown, message: "don`t have UrlComponents"))
                return
            }
            
            if let pageNumber = pageNumber {
                queryComponents.queryItems?.append(.init(name: "page", value: pageNumber.string))
            }
            
            if let pageSize = pageSize {
                queryComponents.queryItems?.append(.init(name: "pageSize", value: pageSize.string))
            }
            
            queryComponents.queryItems?.append(.init(name: "country", value: country.rawValue))
            
            guard let url = queryComponents.url else {
                resolver.reject(NetworkError(code: 400, errorType: .unknown, message: "don`t give url for fetch"))
                return
            }
            
            firstly {
                URLSession.shared.dataTask(.promise, with: url)
            }.map {
                try JSONDecoder().decode(ArticleResponse.self, from: $0.data)
            }.done {
                resolver.fulfill($0)
            }.catch { error in
                resolver.reject(error)
            }
        }
    }
    
}

// MARK: - New features

@available(iOS 15.0, *)
extension NetworkService {
    
    func getNews(country: Country, pageNumber: Int? = nil, pageSize: Int? = nil) async throws -> ArticleResponse {
        guard var urlComponents = urlComponents else {
            throw NetworkError(code: 400, errorType: .unknown, message: "don`t have UrlComponents")
        }
        
        urlComponents.queryItems?.append(.init(name: "page", value: (pageNumber ?? 0).string))
        urlComponents.queryItems?.append(.init(name: "pageSize", value: (pageSize ?? 0).string))
        urlComponents.queryItems?.append(.init(name: "country", value: country.rawValue))
        
        guard let url = urlComponents.url else {
            throw NetworkError(code: 400, errorType: .unknown, message: "don`t have url")
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let articleResponse = try JSONDecoder().decode(ArticleResponse.self, from: data)
        
        return articleResponse
    }
    
    static func getImage(with urlString: String) async throws -> Data {
        guard let url = URL(string: urlString) else {
            throw NetworkError(code: 400, errorType: .unknown, message: "don'nt have url for image")
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
    
}
