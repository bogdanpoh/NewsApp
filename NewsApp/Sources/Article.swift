//
//  Article.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import Foundation

struct ArticleResponse: Decodable {
    var status: String
    var totalResults: Int
    var articles: [Article]
}

struct Article: Decodable {
    var source: ArticleSource
    var author: String?
    var title: String
    var description: String?
    var url: String
    var urlToImage: String?
    var publishedAt: String
    var content: String?
}

struct ArticleSource: Decodable {
    var id: String?
    var name: String
}
