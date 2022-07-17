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
        setupNavigationBarItems()
        setupBindingToViewModel()
        
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppper()
        
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        setupNavigationBarColor(isDarkMode: isDarkMode)
    }
    
    // MARK: - Private
    
    private let viewModel: FeedViewModelProtocol
    private(set) var selectedCell: NewsCollectionViewCell?
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
    
    func setupNavigationBar(navigationBarColor: UIColor? = nil) {
        navigationItem.title = R.string.localizable.feedTitle()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupNavigationBarItems() {
        navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(settingsTap(_:)))
    }
    
    func setupNavigationBarColor(isDarkMode: Bool) {
        let theme: AppTheme = isDarkMode ? .dark : .light
        
        navigationController?.navigationBar.backgroundColor = theme.components.backgroundColor
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
                self?.updateView(with: viewState)
            }
            .disposed(by: disposeBag)
        
        viewModel.scrollToTop.subscribe(onNext: { [weak self] _ in
            let topRow = IndexPath(row: 0, section: 0)
            
            self?.contentView.newsCollectionView.collectionView.scrollToItem(at: topRow, at: .top, animated: true)
        })
        .disposed(by: disposeBag)
    }
    
}

// MARK: - User interactions

private extension FeedViewController {
    
    @objc
    func didPullToRefresh(_ sender: Any) {
        viewModel.pullToRefresh { [weak self] in
            self?.contentView.newsCollectionView.refreshControl.endRefreshing()
        }
    }
    
    @objc
    func settingsTap(_ sender: Any) {
        viewModel.settingsTap()
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
        
        return cell.set(state: .init(imageUrl: article.urlToImage, author: article.author, title: article.title))
    }

}

// MARK: - UICollectionViewDelegate

extension FeedViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        selectedCell = collectionView.cellForItem(at: indexPath) as? NewsCollectionViewCell
        
        viewModel.tapSelectCell(at: indexPath)
        logger.info("tapped on cell: \(indexPath)")
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (viewModel.numberOfRows() - 2) {
            viewModel.scrollToEnd()
        }
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = 320
        return .init(width: width, height: height)
    }
    
}

// MARK: - UIViewControllerTransitioningDelegate

extension FeedViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let detailViewController = presented as? DetailsViewController,
              let selectedCell = selectedCell
        else { return nil }
        
        let animator = Animator(
            type: .present,
            fromViewController: self,
            toViewController: detailViewController,
            selectedCell: selectedCell
        )
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let detailViewController = dismissed as? DetailsViewController,
              let selectedCell = selectedCell
        else { return nil }
        
        let animator = Animator(
            type: .dismiss,
            fromViewController: self,
            toViewController: detailViewController,
            selectedCell: selectedCell
        )
        return animator
    }
    
}

// MARK: - Update view state

private extension FeedViewController {
    
    func updateView(with state: ViewState) {
        switch state {
        case .initial:
            break
            
        case .ready:
            contentView.hidePlaceholder()
            
        case .error, .empty, .loading:
            contentView.showPlaceholder()
        }
    }
    
}
