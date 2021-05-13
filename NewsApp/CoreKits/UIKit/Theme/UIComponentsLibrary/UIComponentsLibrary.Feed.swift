//
//  UIComponentsLibrary.Feed.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 21.04.2021.
//

import UIKit

extension UIComponentsLibrary {
    
    struct Feed {
        var cell: FeedCell
    }
    
    struct FeedCell {
        var title: TextComponent
        var author: TextComponent
        var background: UIColor
    }
    
}
