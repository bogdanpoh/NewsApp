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
                color: UIStyleGuide.ColorPalette.tblack,
                font: .title1
            ),
            background: .systemGroupedBackground
        ),
        backgroundColor: .systemGroupedBackground,
        placeholder: .init(color: UIStyleGuide.ColorPalette.black, font: .titleFeed),
        feed: .init(cell: .init(
            title: .init(color: UIStyleGuide.ColorPalette.tblack, font: .titleFeed),
            author: .init(color: UIStyleGuide.ColorPalette.lightGray, font: .authorFeed),
            background: UIStyleGuide.ColorPalette.white
        )),
        details: .init(
            title: .init(color: UIStyleGuide.ColorPalette.black, font: .titleDetails),
            author: .init(color: UIStyleGuide.ColorPalette.black, font: .authorDetails),
            description: .init(color: UIStyleGuide.ColorPalette.black, font: .descriptionDetails),
            button: .init(
                text: .init(color: UIStyleGuide.ColorPalette.white, font: .buttonDetails),
                background: .init(color: UIStyleGuide.ColorPalette.blue)
            ),
            background: UIStyleGuide.ColorPalette.white
        ),
        settings: .init(
            headerFooter: .init(
                color: UIStyleGuide.ColorPalette.systemGray,
                font: UIStyleGuide.Typography.roboto(weight: .light, size: 14)
            ),
            backgroundCell: .systemBackground,
            background: .systemGroupedBackground
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
            background: UIStyleGuide.ColorPalette.dBlack
        ),
        backgroundColor: .systemGroupedBackground,
        placeholder: .init(color: UIStyleGuide.ColorPalette.white, font: .titleFeed),
        feed: .init(cell: .init(
            title: .init(color: UIStyleGuide.ColorPalette.white, font: .titleFeed),
            author: .init(color: UIStyleGuide.ColorPalette.lightGray, font: .authorFeed),
            background: UIStyleGuide.ColorPalette.tinyBlack
        )),
        details: .init(
            title: .init(color: UIStyleGuide.ColorPalette.white, font: .titleDetails),
            author: .init(color: UIStyleGuide.ColorPalette.gray, font: .authorDetails),
            description: .init(color: UIStyleGuide.ColorPalette.white, font: .descriptionDetails),
            button: .init(
                text: .init(color: UIStyleGuide.ColorPalette.white, font: .buttonDetails),
                background: .init(color: UIStyleGuide.ColorPalette.blue)
            ),
            background: UIStyleGuide.ColorPalette.tblack
        ),
        settings: .init(
            headerFooter: .init(
                color: UIStyleGuide.ColorPalette.gray,
                font: UIStyleGuide.Typography.roboto(weight: .light, size: 14)
            ),
            backgroundCell: UIStyleGuide.ColorPalette.tinyBlack,
            background: .systemGroupedBackground
        )
    ))
    
}
