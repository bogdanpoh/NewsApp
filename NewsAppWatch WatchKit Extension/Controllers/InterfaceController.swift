//
//  InterfaceController.swift
//  NewsAppWatch WatchKit Extension
//
//  Created by Bohdan Pokhidnia on 16.06.2022.
//

import WatchKit

final class InterfaceController: WKInterfaceController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var newsTable: WKInterfaceTable!
    
    // MARK: - Lifecycle
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        Task {
            do {
                let articleResponse = try await networkService.getNews(country: .ua, pageSize: 100)
                articles = articleResponse.articles
                setupTable(articleResponse)
            } catch {
                setupError(error.localizedDescription)
                print("[dev] \(error)")
            }
        }
    }
    
    override func willActivate() {
        super.willActivate()
        
    }
    
    // MARK: - Private
    
    private let networkService = NetworkService()
    private var articles = [Article]()

}

// MARK: - Setup

private extension InterfaceController {
    
    func setupTable(_ articleResponse: ArticleResponse) {
        let tableRows = Array(repeating: NewsRow.className, count: articleResponse.totalResults)
        newsTable.setRowTypes(tableRows)
        
        for (index, article) in articleResponse.articles.enumerated() {
            if let row = newsTable.rowController(at: index) as? NewsRow {
                row.set(name: article.title)
            }
        }
    }
    
    func setupError(_ text: String) {
        newsTable.setNumberOfRows(1, withRowType: ErrorRow.className)
        guard let errorRow = newsTable.rowController(at: 0) as? ErrorRow else { return }
        
        errorRow.setTextError(text)
    }
    
}

// MARK: - User interactions

extension InterfaceController {
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        guard let article = articles[safe: rowIndex] else { return }
        
        pushController(withName: DetailNewsController.className, context: article)
    }
    
}
