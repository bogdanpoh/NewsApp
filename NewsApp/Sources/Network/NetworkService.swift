//
//  NetworkService.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 19.04.2021.
//

import PromiseKit

typealias Countrys = Constants.NewsApi.Countrys

protocol NetworkNewsProtocol {
    func getNews(country: Countrys, pageNumber: Int) -> Promise<NewsResponse>
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
    
    func getNews(country: Countrys, pageNumber: Int = 1) -> Promise<NewsResponse> {
        return .init { resolver in
            guard var queryComponents = urlComponents else {
                resolver.reject(NetworkError(code: 400, errorType: .unknown, message: "don`t have UrlComponents"))
                return
            }

            queryComponents.queryItems?.append(.init(name: "country", value: country.rawValue))
            queryComponents.queryItems?.append(.init(name: "page", value: String(pageNumber)))

            guard let url = queryComponents.url else {
                resolver.reject(NetworkError(code: 400, errorType: .unknown, message: "don`t give url for fetch"))
                return
            }

            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let errorTask = error {
                    resolver.reject(errorTask)
                    return
                }

                guard let dataTask = data else {
                    resolver.reject(NetworkError(code: 400, errorType: .unknown, message: "don`t fetch data"))
                    return
                }
                
                do {
                    let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: dataTask)
                    resolver.fulfill(newsResponse)
                } catch {
                    resolver.reject(error)
                }
            }
            task.resume()
        }
    }
}
