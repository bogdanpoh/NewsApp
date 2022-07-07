//
//  SettingsViewController.swift
//  NewsApp
//
//  Created by Bohdan Pokhidnia on 04.07.2022.
//

import UIKit
import RxSwift

private let logger = Logger(identifier: "SettingsViewController")

final class SettingsViewController: ViewController<SettingsView> {
    
    // MARK: - Initializers
    
    init(viewModel: SettingsViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init()
        
        logger.debug("SettingsViewController constructed")
    }
    
    @available(*, unavailable)
    required init() {
        fatalError("init() has not been implemented")
    }
    
    deinit {
        logger.debug("~SettingsViewController destructed")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupViews()
    }
    
    // MARK: - Private
    
    private let viewModel: SettingsViewModelProtocol
    private let disposseBag = DisposeBag()
    
}

// MARK: - Setup

private extension SettingsViewController {
    
    func setupNavigationBar() {
        navigationItem.title = R.string.localizable.settingsTitle()
        navigationController?.navigationBar.backgroundColor = .systemGroupedBackground
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func setupViews() {
        contentView.settingsTableView.tableView.make {
            $0.dataSource = self
            $0.delegate = self
        }
    }
    
}

// MARK: - UITableViewDataSource

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countMenuItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menuItem = viewModel.menuItem(for: indexPath)
        let cell = tableView.dequeue(SettingsTableViewSingleCell.self, for: indexPath)
        
        return cell.set(state: .init(
            title: menuItem.title,
            image: menuItem.icon,
            accesoryType: menuItem.accessoryType
        ))
    }
    
}

// MARK: - UITableViewDelegate

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        viewModel.tapSelectMenuItem(at: indexPath)
    }
    
}
