//
//  ButtonsFactory.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 16.04.2021.
//

import UIKit

enum ButtonsFactory {
    
    /// button with corner radius: 24
    static func makeActionButton() -> Button {
        Button()
            .setCornerRadius(24)
            .text(font: .title1)
    }
    
}
