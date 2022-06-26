//
//  DetailNewsController.swift
//  NewsAppWatch WatchKit Extension
//
//  Created by Bohdan Pokhidnia on 21.06.2022.
//

import WatchKit

class DetailNewsController: WKInterfaceController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var newsImage: WKInterfaceImage!
    @IBOutlet weak var newsTitleLabel: WKInterfaceLabel!
    @IBOutlet weak var newsDescriptionLabel: WKInterfaceLabel!
    
    
    // MARK: - Lifecycle
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        guard let article = context as? Article else { return }
        
        setuptitle(article.source.name)
        setupViews(with: article)
    }
    
}

// MARK: - Setup

private extension DetailNewsController {
    
    func setuptitle(_ text: String?) {
        let title = text?.uppercased()
        
        setTitle(title)
    }
    
    func setupViews(with article: Article) {
        newsImage.setupImage(urlString: article.urlToImage, placeholder: R.image.newsPlaceholder.watchImage())
        newsTitleLabel.setText(article.title)
        newsDescriptionLabel.setText(article.description)
    }
    
}
