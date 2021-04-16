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
    
    func getNews() -> [News] {
        return [
            .init(
                source: .init(id: nil, name: "Www.stb.ua"),
                author: nil,
                title: "Холостяк (2021) 11 сезон 7 випуск від 16.04.2021 частина 1 дивитись онлайн | Холостяк - Телеканал СТБ",
                description: "Дивитись онлайн Холостяк 2021 - 11 сезон 7 випуск від 16 квітня 2021 частина 1 - Побачення з Розалі та Юлею. Холостяк 7 ефір від 16.04.2021",
                url: "https://www.stb.ua/holostyak/ua/episode/holostyak-11-sezon-vypusk-7-chast-1-ot-16-04-2021/",
                urlToImage: "https://www.stb.ua/holostyak/wp-content/uploads/sites/19/2021/04/16/thumb_4_1618586276-1024x576.jpg",
                publishedAt: "2021-04-16T14:59:00Z",
                content: nil
            ),
            .init(
                source: .init(id: nil, name: "Pravda.com.ua"),
                author: "Українська правда",
                title: "Викрадення активістів Євромайдану: обвинувачений Волков отримав 9 років тюрми - Українська правда",
                description: "Бориспільський міськрайонний суд засудив до 9 років позбавлення волі Олександра Волкова, обвинуваченого у викраденні та вбивстві Юрія  Вербицького і викраденні Ігоря Луценка під час подій Євромайдану.",
                url: "https://www.pravda.com.ua/news/2021/04/16/7290497/",
                urlToImage: "https://img.pravda.com/images/doc/2/c/2cd4873-volkov.jpg",
                publishedAt: "2021-04-16T13:50:13Z",
                content: nil
            ),
            .init(
                source: .init(id: nil, name: "Ukrinform.ua"),
                author: "Ukrinform",
                title: "Меркель вакцинувалася AstraZeneca - Укрінформ. Новини України та світу",
                description: "Канцлер ФРН Ангела Меркель отримала в п&rsquo;ятницю першу дозу вакцини AstraZeneca проти коронавірусу. — Укрінформ.",
                url: "https://www.ukrinform.ua/rubric-world/3229346-merkel-vakcinuvalasa-astrazeneca.html",
                urlToImage: "https://static.ukrinform.com/photos/2021_03/thumb_files/630_360_1615122033-753.jpg",
                publishedAt: "2021-04-16T13:50:00Z",
                content: nil
            ),
            .init(
                source: .init(id: nil, name: "Pravda.com.ua"),
                author: "Українська правда",
                title: "На вихідних в Україні подекуди дощитиме, але буде тепло - Українська правда",
                description: "У найближчі дні в Україні буде хмарно з проясненням, подекуди пройдуть дощі.",
                url: "https://www.pravda.com.ua/news/2021/04/16/7290452/",
                urlToImage: "https://img.pravda.com/images/doc/9/5/9519270-vesna690.jpg",
                publishedAt: "2021-04-16T10:25:08Z",
                content: nil
            )
        ]
    }
    
    func getNewsResponse() -> Promise<NewsResponse> {
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
