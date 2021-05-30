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
        contentView.newsTableView.tableView.make {
            $0.dataSource = self
            $0.delegate = self
        }

        contentView.newsTableView.refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
    }
    
    func setupNavigationBar() {
        navigationItem.title = R.string.localizable.feedTitle()
    }
    
    func setupBindingToViewModel() {
        viewModel.reloadCells
            .subscribe (onNext: { [weak self] _ in
                DispatchQueue.main.async {
                    self?.contentView.newsTableView.tableView.reloadData()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.viewState
            .bind { [weak self] viewState in
                self?.updateView(with: viewState)
            }
            .disposed(by: disposeBag)
    }
    
}

// MARK: - User interactions

extension FeedViewController {
    
    @objc
    func didPullToRefresh(_ sender: Any) {
        viewModel.pullToRefresh { [weak self] in
            self?.contentView.newsTableView.refreshControl.endRefreshing()
        }
    }
    
}

// MARK: - UITableViewDataSource

extension FeedViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = viewModel.item(for: indexPath)
        let cell = tableView.dequeue(NewsTableViewCell.self, for: indexPath)
        return cell.set(state: .init(
            imageUrl: article.urlToImage,
            author: article.author,
            title: article.title
        ))
    }
    
}

// MARK: - Delegate

extension FeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.tapSelectCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(indexPath.row == viewModel.numberOfRows() - 2) {
            print("scroll to end")
//            viewModel.scrollToEnd()
        }
    }
    
}

// MARK: -

extension FeedViewController {
    
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
