//
//  UIStackView+Ext.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 12.04.2021.
//

import UIKit

func makeStackView(axis: NSLayoutConstraint.Axis,
                   distibution: UIStackView.Distribution = .fill,
                   alignment: UIStackView.Alignment = .fill,
                   spacing: CGFloat = 0.0
    ) -> (UIView...) -> UIStackView {
    return { (views: UIView...) -> UIStackView in
        let stack = UIStackView(arrangedSubviews: views)
        stack.axis = axis
        stack.distribution = distibution
        stack.alignment = alignment
        stack.spacing = spacing
        return stack
    }
}

func makeStackView(_ axis: NSLayoutConstraint.Axis,
                   distibution: UIStackView.Distribution = .fill,
                   alignment: UIStackView.Alignment = .fill,
                   spacing: CGFloat = 0.0
    ) -> (UIView...) -> UIStackView {
    return makeStackView(axis: axis, distibution: distibution, alignment: alignment, spacing: spacing)
}

extension UIStackView {
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }
    
    func removeArrangedSubviews() {
        arrangedSubviews.forEach { removeArrangedSubview($0) }
    }
    
}

extension UIStackView {
    
    @discardableResult
    func setSpacing(_ value: CGFloat) -> Self {
        spacing = value
        return self
    }
    
    @discardableResult
    func setASpacing(adaptive: CGFloat, normal: CGFloat) -> Self {
        spacing = UIDevice.current.isIPhone5 ? adaptive : normal
        return self
    }
    
}
