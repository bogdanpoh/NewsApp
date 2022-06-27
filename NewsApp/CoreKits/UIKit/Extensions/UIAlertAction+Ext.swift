//
//  UIAlertAction+Ext.swift
//  NewsApp
//
//  Created by Bohdan Pokhidnia on 27.06.2022.
//

import UIKit
import Rswift

extension UIAlertAction {
    
    static func makeCancelAction(action: (() -> Void)? = nil) -> UIAlertAction {
        return .init(title: R.string.localizable.actionSheetCancel(), style: .cancel) { _ in
            action?()
        }
    }
    
}
