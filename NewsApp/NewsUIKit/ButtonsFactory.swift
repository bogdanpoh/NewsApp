//
//  ButtonsFactory.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 08.05.2021.
//

import UIKit

enum ButtonsFactory {
    
    /// button with corner radius and image
    /// default params: cornerRadius = 20, titleEdgeInsets: aLeft = 8
    static func makeActionButton(image: UIImage?, cornerRadius: CGFloat = 20) -> Button {
        Button()
            .title(hAlignment: .center)
            .setCornerRadius(cornerRadius)
            .maskToBounds(true)
            .make {
                $0.titleEdgeInsets = .init(aLeft: 8)
                $0.setImage(image, for: .normal)
                $0.setImage(image, for: .highlighted)
            }
    }
    
}
