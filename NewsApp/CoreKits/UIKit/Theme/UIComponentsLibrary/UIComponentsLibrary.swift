//
//  UIComponentsLibrary.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 10.04.2021.
//

import UIKit

struct UIComponentsLibrary {
    struct Component {
        var color: UIColor
        var opacity: CGFloat = 1.0
        var cornerRadius: CGFloat = 0.0
    }

    struct TextComponent {
        var color: UIColor
        var font: UIFont
    }
    
    struct NavigationBar {
        var text: TextComponent
        var background: Component
    }

    struct Button {
        var text: TextComponent
        var background: Component
        var highlightedColor: UIColor = .clear
    }
    
    var navigationBar: NavigationBar
    var backgroundColor: UIColor
    var placeholder: TextComponent
    var feed: Feed
    var details: Details
    var settings: Settings
}
