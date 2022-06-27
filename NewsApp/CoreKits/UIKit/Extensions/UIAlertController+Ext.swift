//
//  UIAlertController+Ext.swift
//  NewsApp
//
//  Created by Bohdan Pokhidnia on 27.06.2022.
//

import UIKit

extension UIAlertController {
    
    func addActions(_ actions: [UIAlertAction]) {
        actions.forEach { addAction($0) }
    }
    
    func addDefaultAction(title: String, action: (() -> Void)? = nil) {
        addAction(.init(title: title, style: .default) { _ in
            action?()
        })
    }
    
}
