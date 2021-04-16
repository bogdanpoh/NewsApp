//
//  AppTheme.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 10.04.2021.
//

import UIKit

struct AppTheme {
    let components: UIComponentsLibrary
}

extension AppTheme {
    
    static let light = AppTheme(components: .init(
        navigationBar: .init(
            text: .init(
                color: UIStyleGuide.ColorPalette.black,
                font: .title1
            ),
            background: .init(color: UIStyleGuide.ColorPalette.white)
        ),
        backgroundColor: UIStyleGuide.ColorPalette.white,
        details: .init(
            title: .init(color: UIStyleGuide.ColorPalette.black, font: .title1),
            publishedAt: .init(color: UIStyleGuide.ColorPalette.black, font: .title1),
            description: .init(color: UIStyleGuide.ColorPalette.black, font: .title1),
            button: .init(
                text: .init(color: UIStyleGuide.ColorPalette.blue, font: .title1),
                background: .init(color: UIStyleGuide.ColorPalette.lightGray)
            )
        )
    ))
    
}

extension AppTheme {
    
    static let dark = AppTheme(components: .init(
        navigationBar: .init(
            text: .init(
                color: UIStyleGuide.ColorPalette.white,
                font: .title1
            ),
            background: .init(color: UIStyleGuide.ColorPalette.dBlack)
        ),
        backgroundColor: UIStyleGuide.ColorPalette.black,
        details: .init(
            title: .init(color: UIStyleGuide.ColorPalette.white, font: .title1),
            publishedAt: .init(color: UIStyleGuide.ColorPalette.white, font: .title1),
            description: .init(color: UIStyleGuide.ColorPalette.white, font: .title1),
            button: .init(
                text: .init(color: UIStyleGuide.ColorPalette.blue, font: .title1),
                background: .init(color: UIStyleGuide.ColorPalette.white)
            )
        )
    ))

}
