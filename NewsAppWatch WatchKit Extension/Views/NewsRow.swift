//
//  NewsRow.swift
//  NewsAppWatch WatchKit Extension
//
//  Created by Bohdan Pokhidnia on 20.06.2022.
//

import WatchKit

final class NewsRow: NSObject {
    
    @IBOutlet private weak var nameLabel: WKInterfaceLabel!
    
}

extension NewsRow {
    
    func set(name: String) {
        nameLabel.setText(name)
    }
    
}
