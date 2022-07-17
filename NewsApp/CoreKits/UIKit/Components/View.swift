//
//  View.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 10.04.2021.
//

import UIKit
import SnapKit

let kDefaultViewSize = CGSize(width: 320, height: 528)

enum ViewState {
    case initial,
         loading,
         ready,
         error,
         empty
}

class View: UIView, ViewLayoutableProtocol, Themeable {

    var shadowLayers: Set<CAShapeLayer> = []

    required init() {
        super.init(frame: .init(origin: .zero, size: kDefaultViewSize))

        setup()
        setupSubviews()
        defineLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setup()
        setupSubviews()
        defineLayout()
    }

    func setup() {
        themeProvider.register(observer: self)
    }

    func setupSubviews() {

    }

    func defineLayout() {

    }

    override func layoutSubviews() {
        super.layoutSubviews()

        shadowLayers.forEach {
            $0.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            $0.shadowPath = $0.path
        }
    }

    func update(state: ViewState) {
        switch state {
        case .loading:
            activityView.hidden(false)
            activityView.start()
            
        case .initial, .ready, .error, .empty:
            activityView.hidden(true)
            activityView.stop()
        }
    }

    // MARK: - Themeable

    func apply(theme: AppTheme) {
        // do nothing
    }

    // MARK: - Private
    
    private lazy var activityView = ActivityView().make {
        $0.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        $0.isHidden = true
    }

    private lazy var placeholderView = ActivityView().make {
        $0.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude) - 1
        $0.isHidden = true
    }

}

// MARK: - Shadows

extension View {

    @discardableResult
    func addShadow(color: UIColor,
                   offset: CGSize,
                   opacity: Float,
                   radius: CGFloat,
                   fillColor: UIColor = .clear) -> Self {
        let shadowLayer = CAShapeLayer()

        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        shadowLayer.fillColor = fillColor.cgColor

        shadowLayer.shadowColor = color.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = offset
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = radius

        layer.insertSublayer(shadowLayer, at: 0)
        shadowLayers.insert(shadowLayer)

        return self
    }

    @discardableResult
    func removeShadows() -> Self {
        shadowLayers.forEach { $0.removeFromSuperlayer() }
        shadowLayers = []
        return self
    }

}

extension UIView {
    
    @discardableResult
    func cornersRadiusOnly(_ radius: CGFloat,
                           topLeft: Bool = false,
                           topRight: Bool = false,
                           bottomLeft: Bool = false,
                           bottomRight: Bool = false) -> Self {
        
        var corners = CACornerMask()
        
        if topLeft {
            corners.insert(.layerMinXMinYCorner)
        }
        if topRight {
            corners.insert(.layerMaxXMinYCorner)
        }
        if bottomLeft {
            corners.insert(.layerMinXMaxYCorner)
        }
        if bottomRight {
            corners.insert(.layerMaxXMaxYCorner)
        }
        
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = corners
        
        return self
    }

    var cornerRadius: CGFloat { return layer.cornerRadius }

    @discardableResult
    func setCornerRadius(_ radius: CGFloat) -> Self {
        layer.cornerRadius = radius
        return self
    }

    @discardableResult
    func backgroundColor(color: UIColor) -> Self {
        backgroundColor = color
        return self
    }

    @discardableResult
    func maskToBounds(_ enabled: Bool) -> Self {
        layer.masksToBounds = enabled
        return self
    }

    @discardableResult
    func hidden(_ aIsHidden: Bool) -> Self {
        isHidden = aIsHidden
        return self
    }

    @discardableResult
    func tint(color: UIColor) -> Self {
        tintColor = color
        return self
    }

    @discardableResult
    func setAlpha(_ aAlpha: CGFloat) -> Self {
        alpha = aAlpha
        return self
    }

    @discardableResult
    func borderWidth(_ value: CGFloat, color: UIColor) -> Self {
        layer.borderWidth = value
        layer.borderColor = color.cgColor
        return self
    }

    @discardableResult
    func borderWidth(_ value: CGFloat) -> Self {
        layer.borderWidth = value
        return self
    }

    @discardableResult
    func apply(transform newTransform: CGAffineTransform) -> Self {
        transform = newTransform
        return self
    }

}

extension UIView {

    @discardableResult
    func addSubviews(_ subviews: UIView...) -> Self {
        subviews.forEach { addSubview($0) }
        return self
    }
    
    func convertSelfBounds(to space: UICoordinateSpace) -> CGRect {
        return convert(bounds, to: space)
    }

}

import UIImageColors

extension UIView {
    
    @discardableResult
    func setBackgroundColor(from image: UIImage?) -> Self {
        image?.getColors() { [weak self] in
            self?.backgroundColor = $0?.background
        }
        
        return self
    }
    
}
