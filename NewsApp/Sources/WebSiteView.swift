//
//  WebSiteView.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 30.04.2021.
//

import UIKit
import WebKit

final class WebSiteView: View {
    
    // MARK: - UI
    
    let closeButton = Button()
        .title(R.string.localizable.webSiteDone())
        .titleColor(UIStyleGuide.ColorPalette.blue)
    
    let safariButton = Button()
        .setImage(R.image.icSafari())
        
    private(set) var webView = WKWebView()
    
    // MARK: - Lifecycle
    
    override func setupSubviews() {
        super.setupSubviews()
        
        addSubview(webView)
    }
    
    override func defineLayout() {
        super.defineLayout()
        
        safariButton.snp.makeConstraints {
            $0.width.equalTo(24)
        }
        
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Override methods
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        
        backgroundColor(color: theme.components.backgroundColor)
    }
    
}
