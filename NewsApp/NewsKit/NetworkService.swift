//
//  NetworkService.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 19.04.2021.
//

import Foundation

typealias Countrys = Constants.NewsApi.Countrys

protocol NetworkNewsProtocol {
    func fetchNews(country: Countrys, completion: @escaping (Result<Data, Error>) -> Void)
    
    func getNews(country: Countrys, completion: @escaping (Result<[News], Error>) -> Void)
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
    
    func fetchNews(country: Countrys, completion: @escaping (Result<Data, Error>) -> Void) {
        guard var queryComponents = urlComponents else {
            return
        }
        
        queryComponents.queryItems?.append(.init(name: "country", value: country.rawValue))
        
        guard let url = queryComponents.url else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let errorTask = error {
                completion(.failure(errorTask))
                return
            }
            
            guard let dataTask = data else {
                return
            }
            completion(.success(dataTask))
        }
        task.resume()
    }
    
    func getNews(country: Countrys, completion: @escaping (Result<[News], Error>) -> Void) {
        fetchNews(country: country) { result in
            switch result {
            case .success(let data):
                do {
                    let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                    completion(.success(newsResponse.articles))
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
