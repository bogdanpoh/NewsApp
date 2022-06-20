//
//  ErrorRow.swift
//  NewsAppWatch WatchKit Extension
//
//  Created by Bohdan Pokhidnia on 20.06.2022.
//

import WatchKit

final class ErrorRow: NSObject {
    
    @IBOutlet private weak var textLabel: WKInterfaceLabel!
    
}

extension ErrorRow {
    
    func setTextError(_ text: String) {
        textLabel.setText("❌ \(text)")
    }
    
}
