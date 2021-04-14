//
//  UIApplication+Ext.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 10.04.2021.
//

import UIKit

extension UIApplication {
    
    var mainWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            return windows.first(where: { $0.isKeyWindow })
        } else {
            return keyWindow
        }
    }
    
}

extension UIApplication {
    
    static func topmostViewController(controller: UIViewController? = UIApplication.shared.mainWindow?.rootViewController) -> UIViewController? {
        return controller?.topmostViewController()
    }
    
}
