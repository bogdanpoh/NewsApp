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
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupNavigationBarItems() {
        navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "globe.europe.africa.fill"), style: .plain, target: self, action: #selector(settingsTap(_:)))
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
        
        viewModel.settingsTapped.subscribe(onNext: { [weak self] in
            self?.showCountryActionSheet()
        })
        .disposed(by: disposeBag)
    }
    
}

// MARK: - User interactions

private extension FeedViewController {
    
    @objc
    func didPullToRefresh(_ sender: Any) {
        viewModel.pullToRefresh { [weak self] in
            self?.contentView.newsTableView.refreshControl.endRefreshing()
        }
    }
    
    @objc
    func settingsTap(_ sender: Any) {
        viewModel.settingsTap()
    }
    
}

// MARK: - UITableViewDataSource

extension FeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = viewModel.item(for: indexPath)
        let cell = tableView.dequeue(NewsTableViewCell.self, for: indexPath)
        
        return cell.set(state: .init(imageUrl: article.urlToImage, author: article.author, title: article.title))
    }
    
}

// MARK: - UITableViewDelegate

extension FeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.tapSelectCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(indexPath.row == viewModel.numberOfRows() - 2) {
            viewModel.scrollToEnd()
        }
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

// MARK: - Country Action Sheet

private extension FeedViewController {
    
    func showCountryActionSheet() {
        let countries = Constants.NewsApi.Countrys.allCases
        let alertController = UIAlertController(
            title:  R.string.localizable.actionSheetTitle(),
            message: R.string.localizable.actionSheetMessage(),
            preferredStyle: .actionSheet
        )
        
        let action: (_ country: Country) -> Void = { [unowned self] in
            viewModel.selectedCountry($0)
        }
        
        for country in countries {
            alertController.addDefaultAction(title: country.title) {
                action(country)
            }
        }

        alertController.addAction(.makeCancelAction())
        present(alertController, animated: true)
    }
    
}
