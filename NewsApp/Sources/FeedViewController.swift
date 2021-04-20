//
//  FeedViewController.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import UIKit
import RxSwift

private let logger = Logger(identifier: "FeedViewController")

final class FeedViewController: ViewController<FeedView> {
    
    // MARK: - Initializers
    
    init(viewModel: FeedViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init()
        
        logger.debug("FeedViewController constructed")
    }
    
    @available(*, unavailable)
    required init() {
        fatalError("init() has not been implemented")
    }
    
    deinit {
        logger.debug("~FeedViewController destructed")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.newsCollectionView.collectionView.make {
            $0.dataSource = self
            $0.delegate = self
        }
        
        setupNavigationBar()
        setupBindingToViewModel()
        
        viewModel.viewDidLoad()
    }
    
    // MARK: - Private
    
    private let viewModel: FeedViewModelProtocol
    private let disposeBag = DisposeBag()
    
}

// MARK: - Setup

private extension FeedViewController {
    
    func setupNavigationBar() {
        navigationItem.title = R.string.localizable.newsTitle()
    }
    
    func setupBindingToViewModel() {
        viewModel.reloadCells
            .subscribe (onNext: { [weak self] _ in
                DispatchQueue.main.async {
                    self?.contentView.newsCollectionView.collectionView.reloadData()
                }
            })
            .disposed(by: disposeBag)
    }
    
}

// MARK: - UICollectionViewDataSource

extension FeedViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let article = viewModel.item(for: indexPath)
        let cell = collectionView.dequeue(NewsCollectionViewCell.self, for: indexPath)
        return cell.set(state: .init(
            imageUrl: article.urlToImage ?? "",
            author: article.author ?? R.string.localizable.newsWithoutAuthor(),
            title: article.title
        ))
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: View.noIntrinsicMetric, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = UIScreen.main.bounds.width - 36
        let height: CGFloat = 250
        return .init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.tapSelectCell(at: indexPath)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        
        if bottomEdge >= scrollView.contentSize.height {
            viewModel.scrollToEnd()
        }
    }
    
    
}
