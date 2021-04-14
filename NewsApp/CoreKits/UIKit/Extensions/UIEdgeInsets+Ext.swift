//
//  UIEdgeInsets+Ext.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import UIKit

public extension UIEdgeInsets {
    
    init(aTop: CGFloat = 0, aLeft: CGFloat = 0, aBottom: CGFloat = 0, aRight: CGFloat = 0) {
        self.init(top: aTop, left: aLeft, bottom: aBottom, right: aRight)
    }
    
    init(all: CGFloat = 0) {
        self.init()
        if all != 0 {
            (top, bottom, left, right) = (all, all, all, all)
        }
    }
    
    init(vertical: CGFloat = 0, horizontal: CGFloat = 0) {
        self.init()
        (top, bottom, left, right) = (vertical, vertical, horizontal, horizontal)
    }
    
}
