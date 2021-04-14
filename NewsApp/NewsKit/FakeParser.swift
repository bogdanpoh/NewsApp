//
//  FakeParser.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import PromiseKit

final class FakeParsser {
    
}

extension FakeParsser {
    
    func getNews() -> Promise<NewsResponse> {
        return .init { resolver in
            resolver.fulfill(.init(
                status: "ok",
                totalResults: 1,
                articles: [.init(
                    source: .init(id: nil, name: "Sport.ua"),
                    author: "Українська правда",
                    title: "Міноброни РФ заявило, що перекидає війська до кордонів через НАТО - Українська правда",
                    description: "Міністр оборони РФ Сергій Шойгу заявив, що Росія вживає заходів у відповідь на загрозливу військову діяльність НАТО, і що армія РФ показала готовність забезпечити безпеку країни.",
                    url: "https://www.pravda.com.ua/news/2021/04/13/7290055/",
                    urlToImage: "https://img.pravda.com/images/doc/a/8/a822b49-rosiya690.jpg",
                    publishedAt: "2021-04-13T14:08:12Z",
                    content: nil
                )]
            ))
        }
    }
    
}
