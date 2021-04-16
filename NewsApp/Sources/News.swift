//
//  News.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import Foundation

struct NewsResponse: Decodable {
    var status: String
    var totalResults: Int
    var articles: [News]
}

struct News: Decodable {
    var source: NewsSource
    var author: String?
    var title: String
    var description: String
    var url: String
    var urlToImage: String?
    var publishedAt: String
    var content: String?
}

struct NewsSource: Decodable {
    var id: Int?
    var name: String
}
