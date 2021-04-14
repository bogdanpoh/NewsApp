//
//  TextField.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 12.04.2021.
//

import UIKit

class TextField: UITextField {
    var textInsets: UIEdgeInsets = .zero
}

extension TextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
}

extension TextField {
    
    @discardableResult
    func setBorderStyle(_ borderStyle: UITextField.BorderStyle) -> Self {
        self.borderStyle = borderStyle
        return self
    }
    
    @discardableResult
    func setKeyboardType(_ keyboardType: UIKeyboardType) -> Self {
        self.keyboardType = keyboardType
        return self
    }
    
    @discardableResult
    func textColor(_ color: UIColor) -> Self {
        textColor = color
        return self
    }
    
    @discardableResult
    func attribText(_ aAttribText: NSAttributedString) -> Self {
        attributedText = aAttribText
        return self
    }
    
    @discardableResult
    func text(_ aText: String) -> Self {
        text = aText
        return self
    }
    
    @discardableResult
    func text(font aFont: UIFont) -> Self {
        font = aFont
        return self
    }
    
    @discardableResult
    func text(alignment aAlignement: NSTextAlignment) -> Self {
        textAlignment = aAlignement
        return self
    }
    
}
