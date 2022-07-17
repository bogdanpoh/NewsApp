//
//  Blurable.swift
//  NewsApp
//
//  Created by Bohdan Pokhidnia on 17.07.2022.
//

import UIKit

protocol Blurable {
    func addBlur(_ alpha: CGFloat) -> Self
}

extension Blurable where Self: UIImageView {
    
    @discardableResult
    func addBlur(_ alpha: CGFloat = 0.5) -> Self {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = alpha
        
        addSubview(blurEffectView)
        return self
    }
    
}

extension UIImageView: Blurable {}
