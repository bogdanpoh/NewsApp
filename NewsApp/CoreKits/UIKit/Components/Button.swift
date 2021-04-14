//
//  Button.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 12.04.2021.
//

import UIKit

extension Button.State: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }

}

class Button: UIButton {

    struct State: OptionSet {
        let rawValue: UInt8

        static let normal = State(rawValue: 1 << 0)
        static let highlighted = State(rawValue: 1 << 1)
        static let disabled = State(rawValue: 1 << 2)
        static let selected = State(rawValue: 1 << 3)
    }

    struct BorderState {
        var width: CGFloat
        var color: UIColor
    }

    // MARK: - Overrides

    override var isEnabled: Bool {
        didSet {
            guard isEnabled != oldValue else { return }
            updateBackgroundColor()
            updateBorder()
        }
    }

    override var isHighlighted: Bool {
        didSet {
            guard isEnabled else { return }
            updateBackgroundColor()
            updateBorder()
        }
    }

    override var isSelected: Bool {
        didSet {
            updateBackgroundColor()
            updateBorder()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if let insets = calculateImageInsets?() {
            setImageInsets(insets)
        }
    }

    // MARK: - Private

    private var backgroundColors: [State: UIColor] = [:]

    private var fonts: [State: UIFont?] = [
        .normal     : nil,
        .disabled   : nil,
        .highlighted: nil,
        .selected   : nil
    ]

    private var bordersWidths: [State: BorderState] = [:]

    private var calculateImageInsets: (() -> UIEdgeInsets)?

    private var onTapAction: (() -> Void) = { }

}

// MARK: - User interactions

private extension Button {

    @objc
    func tapButton() {
        onTapAction()
    }

}

extension Button {

    @discardableResult
    func whenTap(action: @escaping () -> Void) -> Self {
        self.onTapAction = action
        addTarget(self, action: #selector(tapButton))
        return self
    }

    @discardableResult
    func background(color: UIColor, for state: State = .normal) -> Self {
        backgroundColors[state] = color
        updateBackgroundColor()
        return self
    }

    @discardableResult
    func titleColor(_ color: UIColor, for state: UIControl.State = .normal) -> Self {
        setTitleColor(color, for: state)
        return self
    }

    @discardableResult
    func title(vAlignment: UIControl.ContentVerticalAlignment) -> Self {
        contentVerticalAlignment = vAlignment
        return self
    }

    @discardableResult
    func title(hAlignment: UIControl.ContentHorizontalAlignment) -> Self {
        contentHorizontalAlignment = hAlignment
        return self
    }

    @discardableResult
    func text(font aFont: UIFont, for state: State = .normal) -> Self {
        titleLabel?.font = aFont
        fonts[state] = titleLabel?.font
        return self
    }

    @discardableResult
    func setImage(_ image: UIImage?) -> Self {
        setImage(image, for: .normal)
        return self
    }

    @discardableResult
    func setBackground(_ image: UIImage?, for state: UIControl.State = .normal) -> Self {
        setBackgroundImage(image, for: state)
        return self
    }

    @discardableResult
    func title(_ title: String?, for state: UIControl.State = .normal) -> Self {
        setTitle(title, for: state)
        return self
    }

    @discardableResult
    func enabled(_ aIsEnabled: Bool) -> Self {
        isEnabled = aIsEnabled
        return self
    }

    @discardableResult
    func highlighted(_ aIsHighlighted: Bool) -> Self {
        isHighlighted = aIsHighlighted
        return self
    }
    
    @discardableResult
    func addShadow(shadowColor: UIColor,
                   shadowOffset: CGSize,
                   shadowOpacity: Float,
                   shadowRadius: CGFloat) -> Self {
        
        let shadowLayer = CAShapeLayer()

        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowOffset = shadowOffset
        shadowLayer.shadowOpacity = shadowOpacity
        shadowLayer.shadowRadius = shadowRadius
        
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius

        layer.insertSublayer(shadowLayer, at: 0)

        return self
    }

    @discardableResult
    func setImageInsets(_ insets: UIEdgeInsets) -> Self {
        imageEdgeInsets = insets
        return self
    }

    @discardableResult
    func backgroundColor(normal: UIColor, disabled: UIColor = .clear, highlighted: UIColor = .clear, selected: UIColor = .clear) -> Self {
        backgroundColors[.normal] = normal
        backgroundColors[.disabled] = disabled
        backgroundColors[.highlighted] = highlighted
        backgroundColors[.selected] = selected

        updateBackgroundColor()

        return self
    }

    @discardableResult
    func borderWidth(_ value: CGFloat, color: UIColor, for state: State) -> Self {
        bordersWidths[state] = .init(width: value, color: color)
        updateBorder()
        return self
    }

    func underline(text: String, font: UIFont, for state: UIButton.State = .normal) -> Self {
        let underlineAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributedText = NSAttributedString(string: text, attributes: underlineAttributes)
        setAttributedTitle(attributedText, for: state)
        return self
    }

}

// MARK: -

private extension Button {

    func updateBackgroundColor() {
        guard isEnabled else {
            backgroundColor = backgroundColors[.disabled] ?? backgroundColors[.normal]
            return
        }

        guard isSelected else {
            if isHighlighted {
                backgroundColor = backgroundColors[.highlighted] ?? backgroundColors[.normal]
            } else {
                backgroundColor = backgroundColors[.normal]
            }
            return
        }

        if isHighlighted {
            backgroundColor = backgroundColors[[.selected, .highlighted]]
            return
        }

        backgroundColor = backgroundColors[.selected] ?? backgroundColors[.normal]
    }
    
    func updateBorder() {
        guard isEnabled else {
            if let border = bordersWidths[.disabled] ?? bordersWidths[.normal] {
                borderWidth(border.width, color: border.color)
            }
            return
        }

        guard isSelected else {
            if let border = bordersWidths[.normal] {
                borderWidth(border.width, color: border.color)
            } else {
                borderWidth(0)
            }
            return
        }

        if let border = bordersWidths[.selected] {
            borderWidth(border.width, color: border.color)
        } else {
            borderWidth(0)
        }
    }

}
