//
//  UIScreen.Ext.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 02.04.2021.
//

import UIKit

extension UIScreen {
    
    static var isHeightGreaterIPhone8: Bool {
        let screenHeightOfIphone8: CGFloat = 667
        return main.bounds.height > screenHeightOfIphone8
    }
    
}
