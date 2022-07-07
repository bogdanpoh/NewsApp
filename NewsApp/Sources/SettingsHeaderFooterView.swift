//
//  SettingsHeaderFooterView.swift
//  NewsApp
//
//  Created by Bohdan Pokhidnia on 05.07.2022.
//

import UIKit

class SettingsHeaderFooterView: UITableViewHeaderFooterView, ViewLayoutableProtocol, Themeable {

    enum ViewStyle {
        case header
        case footer
    }
    
    // MARK: - Initializers
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setup()
        setupSubviews()
        defineLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI

    private let titleLabel = Label()
        .set(numberOfLines: 0)
        .text(alignment: .justified)
        .adjustsFontSizeToFitWidth(scale: 0.3)
    
    // MARK: - Lifecycle

    func setup() {
        themeProvider.register(observer: self)
    }

    func setupSubviews() {
        addSubview(titleLabel)
    }

    func defineLayout() {
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func apply(theme: AppTheme) {
        let headerFooterTheme = theme.components.settings.headerFooter

        titleLabel
            .textColor(headerFooterTheme.color)
            .text(font: headerFooterTheme.font)
    }

}

// MARK: - Set

extension SettingsHeaderFooterView {

    @discardableResult
    func set(_ text: String, style: ViewStyle) -> Self {
        var valueText: String?

        switch style {
        case .header:
            valueText = text.uppercased()

        case .footer:
            valueText = text
        }

        titleLabel.text = valueText
        return self
    }

}
