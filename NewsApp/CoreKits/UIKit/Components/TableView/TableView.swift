//
//  TableView.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 10.04.2021.
//

import UIKit

class TableView: UITableView {
    
}

extension TableView {
    
    @discardableResult
    func setRowHeight(_ height: CGFloat) -> Self {
        rowHeight = height
        return self
    }
    
    @discardableResult
    func setEstimatedRowHeight(_ height: CGFloat) -> Self {
        estimatedRowHeight = height
        return self
    }
    
}

// MARK: - Table Header & Footer

extension TableView {
    
    @discardableResult
    func setEmptyHeader() -> Self {
        tableHeaderView = makeEmptyView()
        return self
    }
    
    @discardableResult
    func setEmptyFooter() -> Self {
        tableFooterView = makeEmptyView()
        return self
    }
    
    private func makeEmptyView() -> UIView {
        let viewRect = CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude)
        return UIView(frame: viewRect)
    }
    
}
