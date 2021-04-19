//
//  NetworkService.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 19.04.2021.
//

import Foundation

protocol NetworkNewsProtocol {
    func fetchNews(completion: @escaping (Result<Data, Error>) -> Void)
    
    func getNews(completion: @escaping (Result<[News], Error>) -> Void)
}

final class NetworkService {
    
    init(domainString: String, country: String, apiKey: String) {
        self.urlComponents = URLComponents(string: domainString)
        self.urlComponents?.queryItems = [
            URLQueryItem(name: "country", value: country),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
    }
    
    private var urlComponents: URLComponents?
}

// MARK: - NetworkNewsProtocol

extension NetworkService: NetworkNewsProtocol {
    
    func fetchNews(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let queryComponents = urlComponents,
              let url = queryComponents.url
        else {
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
    
    func getNews(completion: @escaping (Result<[News], Error>) -> Void) {
        fetchNews { result in
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
