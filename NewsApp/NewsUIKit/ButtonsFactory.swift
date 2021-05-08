//
//  ButtonsFactory.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 08.05.2021.
//

import UIKit

enum ButtonsFactory {
    
    ///corner radius: 20
    static func makeActionButton(image: UIImage?,cornerRadius: CGFloat = 20) -> Button {
        Button()
            .title(hAlignment: .center)
            .setImage(image)
            .setCornerRadius(cornerRadius)
            .maskToBounds(true)
            .make {
                $0.titleEdgeInsets = .init(aLeft: 8)
            }
    }
    
}
