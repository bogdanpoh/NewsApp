//
//  File.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 10.04.2021.
//

import UIKit

final class Label: UILabel {
    
}

extension Label {
    
    @discardableResult
    func text(_ aText: String) -> Self {
        self.text = aText
        return self
    }
    
    @discardableResult
    func attribText(_ aAttribText: NSAttributedString) -> Self {
        attributedText = aAttribText
        return self
    }
    
    @discardableResult
    func textColor(_ color: UIColor) -> Self {
        textColor = color
        return self
    }
    
    @discardableResult
    func text(font aFont: UIFont) -> Self {
        font = aFont
        return self
    }
    
    @discardableResult
    func text(alignment aAlignment: NSTextAlignment) -> Self {
        textAlignment = aAlignment
        return self
    }
    
    @discardableResult
    func enableMultilines() -> Self {
        numberOfLines = 0
        return self
    }
    
    @discardableResult
    func set(numberOfLines lines: Int) -> Self {
        numberOfLines = lines
        return self
    }
    
    @discardableResult
    func baselineAdjustment(_ adjustment: UIBaselineAdjustment) -> Self {
        baselineAdjustment = adjustment
        return self
    }
    
    @discardableResult
    func lineBreakMode(_ aLineBreakMode: NSLineBreakMode) -> Self {
        lineBreakMode = aLineBreakMode
        return self
    }
    
}
