//
//  SettingsHeaderFooterView.swift
//  NewsApp
//
//  Created by Bohdan Pokhidnia on 05.07.2022.
//

import UIKit

class SettingsHeaderFooterView: UITableViewHeaderFooterView, ViewLayoutableProtocol, Themeable { //View {

    enum TextStyle {
        case header
        case footer
    }
    
    // MARK: - UI
    
    private let view = View()
    
    private let titleLabel = Label()
        .set(numberOfLines: 0)
        .text(alignment: .justified)
        .adjustsFontSizeToFitWidth(scale: 0.3)
    
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
    
    // MARK: - Lifecycle

    func setup() {
        themeProvider.register(observer: self)
    }

    func setupSubviews() {
        addSubview(view)
        view.addSubview(titleLabel)
    }

    func defineLayout() {
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(horizontal: 22))
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
    func set(text: String, style: TextStyle) -> Self {
        let valueText: String

        switch style {
        case .header:
            valueText = text.uppercased()

        case .footer:
            valueText = text
        }

        titleLabel.text(valueText)
        return self
    }

}
