//
//  ViewController.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 10.04.2021.
//

import UIKit

class ViewController<ContentView: View>: UIViewController {
    
    var contentView: ContentView! {
        return view as? ContentView
    }
    
    // MARK: - Lifecycle
    
    required init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = ContentView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        themeProvider.register(observer: self)
        
        let uiStyle = traitCollection.userInterfaceStyle
        themeProvider.set(theme: uiStyle == .light ? .light : .dark)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        let uiStyle = traitCollection.userInterfaceStyle
        themeProvider.set(theme: uiStyle == .light ? .light : .dark)
    }
    
}

// MARK: - Themeable

extension ViewController: Themeable {
    
    func apply(theme: AppTheme) {
        navigationController?.navigationBar.backgroundColor = theme.components.navigationBar.background.color
    }
    
}
