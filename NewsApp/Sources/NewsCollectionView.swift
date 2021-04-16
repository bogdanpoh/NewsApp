//
//  NewsCollectionView.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 15.04.2021.
//

import UIKit

final class NewsCollectionView: View {
    
    // MARK: - UI
    
    private lazy var newsCollectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(class: NewsCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    override func setupSubviews() {
        super.setupSubviews()
        
        addSubview(newsCollectionView)
    }
    
    override func defineLayout() {
        super.defineLayout()
        
        newsCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Override methods
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        
        backgroundColor(color: theme.components.backgroundColor)
        
        newsCollectionView.backgroundColor(color: theme.components.backgroundColor)
    }
    
    // MARK: - Private
    
    private var news: [News] = FakeParsser().getNews()
    
}

// MARK: - UICollectionViewDataSource

extension NewsCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let article = news[indexPath.row]
        let cell = collectionView.dequeue(NewsCollectionViewCell.self, for: indexPath)
        return cell.set(state: .init(
            image: R.image.testImg(),
            author: article.author ?? "no author",
            title: article.title
        ))
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension NewsCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: View.noIntrinsicMetric, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 36
        let height = UIScreen.main.bounds.height / 4
        return .init(width: width, height: height)
    }
    
}
