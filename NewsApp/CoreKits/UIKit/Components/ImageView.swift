//
//  ImageView.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 12.04.2021.
//

import UIKit

class ImageView: UIImageView {
    
}

extension ImageView {
    
    @discardableResult
    func setImage(_ aImage: UIImage?) -> Self {
        image = aImage
        return self
    }
    
    @discardableResult
    func setContentMode(_ contentMode: ContentMode) -> Self {
        self.contentMode = contentMode
        return self
    }
    
    @discardableResult
    func applyCircleRadius() -> Self {
        assert(bounds.width == bounds.height)
        self.masksToBounds(true)
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
        return self
    }
    
    @discardableResult
    func masksToBounds(_ masksToBounds: Bool) -> Self {
        layer.masksToBounds = masksToBounds
        return self
    }
    
    @discardableResult
    func borderColor(_ color: UIColor) -> Self {
        layer.borderColor = color.cgColor
        return self
    }
    
}
