//
//  FullSizedTableView.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 10.04.2021.
//

import UIKit

/// table view height == table view cells
final class FullSizedTableView: TableView {
    /// default value equal infinity
    var maxHeight: CGFloat = .infinity

    override func layoutSubviews() {
        super.layoutSubviews()

        self.invalidateIntrinsicContentSize()
    }

    override func reloadData() {
        super.reloadData()

        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }

    override var intrinsicContentSize: CGSize {
        setNeedsLayout()
        let height = min(contentSize.height, maxHeight)
        return CGSize(width: contentSize.width, height: height)
    }

}
