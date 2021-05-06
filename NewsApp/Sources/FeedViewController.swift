//
//  FeedViewController.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import UIKit
import RxSwift
import RxCocoa

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
        
        setupView()
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
    
    func setupView() {
        contentView.newsCollectionView.collectionView.make {
            $0.dataSource = self
            $0.delegate = self
        }
        
        contentView.newsCollectionView.refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
    }
    
    func setupNavigationBar() {
        navigationItem.title = R.string.localizable.feedTitle()
    }
    
    func setupBindingToViewModel() {
        viewModel.reloadCells
            .subscribe (onNext: { [weak self] _ in
                DispatchQueue.main.async {
                    self?.contentView.newsCollectionView.collectionView.reloadData()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.viewState
            .bind { [weak self] viewState in
                self?.update(with: viewState)
            }
            .disposed(by: disposeBag)
    }
    
}

// MARK: - User interactions

extension FeedViewController {
    
    @objc
    func didPullToRefresh(_ sender: Any) {
        viewModel.pullToRefresh { [weak self] in
            self?.contentView.newsCollectionView.refreshControl.endRefreshing()
        }
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
            imageUrl: article.urlToImage,
            author: article.author,
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
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = UIScreen.main.bounds.width - 36
        let height: CGFloat = 300
        return .init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.tapSelectCell(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == viewModel.numberOfRows() - 2) {
            viewModel.scrollToEnd()
        }
    }
    
}

// MARK: -

extension FeedViewController {
    
    func update(with state: ViewState) {
        switch state {
        case .initial:
            break
        
        case .loading, .ready, .error:
            logger.info("viewState: loading, ready, error")
            
        case .empty:
            logger.info("viewState: empty")
        }
    }
    
}
