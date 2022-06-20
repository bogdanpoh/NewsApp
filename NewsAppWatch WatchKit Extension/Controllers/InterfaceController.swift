//
//  InterfaceController.swift
//  NewsAppWatch WatchKit Extension
//
//  Created by Bohdan Pokhidnia on 16.06.2022.
//

import WatchKit
import PromiseKit


class InterfaceController: WKInterfaceController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var newsTable: WKInterfaceTable!
    
    // MARK: - Lifecycle
    
    override func willActivate() {
        super.willActivate()
        
        firstly {
            networkManager.getNews(country: .ua, pageNumber: nil, pageSize: 100)
        }.done { [weak self] news in
            self?.setupTable(news)
        }.catch { [weak self] error in
            print("[dev] error fetched news \(error.localizedDescription)")
            
            self?.setupError(error.localizedDescription)
        }
        
    }
    
    // MARK: - Private
    
    private let networkManager = NetworkService()

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
