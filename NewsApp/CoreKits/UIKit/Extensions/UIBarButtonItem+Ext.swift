//
//  UIBarButtonItem+Ext.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import UIKit

extension UIBarButtonItem {
    
    static func makeCloseButton(target: Any, action: Selector) -> Self {
        return .init(
            image: R.image.icNavBarClose(),
            style: .plain,
            target: target,
            action: action
        )
    }
    
    static func makeBackButton(target: Any, action: Selector) -> Self {
        return .init(
            image: R.image.icNavBarBack(),
            style: .plain,
            target: target,
            action: action
        )
    }
    
    static func makeButton(_ button: Button) -> Self {
        return .init(customView: button)
    }
    
    static func makeFlexibleSpaceButton() -> UIBarButtonItem {
        return .init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    }
    
    static func makeButton(title: String, style: UIBarButtonItem.Style = .done, target: Any, selector: Selector) -> UIBarButtonItem {
        return .init(
            title: title,
            style: style,
            target: target,
            action: selector
        )
    }
    
}
