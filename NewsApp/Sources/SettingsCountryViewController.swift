//
//  SettingsCountryViewController.swift
//  NewsApp
//
//  Created by Bohdan Pokhidnia on 06.07.2022.
//

import UIKit
import RxSwift

private let logger = Logger(identifier: "SettingsCountryViewController")

final class SettingsCountryViewController: ViewController<SettingsCountryView> {
    
    // MARK: - Initializers
    
    init(viewModel: SettingsViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init()
        
        logger.debug("SettingsCountryViewController constructed")
    }
    
    @available(*, unavailable)
    required init() {
        fatalError("init() has not been implemented")
    }
    
    deinit {
        logger.debug("~SettingsCountryViewController destructed")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupViews()
        setupBindingToViewModel()
    }
    
    // MARK: - Private
    
    private let viewModel: SettingsViewModelProtocol
    private var selectedCountry: IndexPath?
    private let disposseBag = DisposeBag()
    
}

// MARK: - Setup

private extension SettingsCountryViewController {
    
    func setupNavigationBar() {
        navigationItem.title = R.string.localizable.settingsCountry()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func setupViews() {
        contentView.settingsCountryTableView.tableView.make {
            $0.dataSource = self
            $0.delegate = self
        }
    }
    
    func setupBindingToViewModel() {
        viewModel.selectedCountry.bind(onNext: { [weak self] indexPath in
            self?.selectedCountry = indexPath
            
            self?.contentView.settingsCountryTableView.tableView.reloadData()
        })
        .disposed(by: disposseBag)
    }
    
}

// MARK: - UITableViewDataSource

extension SettingsCountryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countCountries()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let country = viewModel.country(for: indexPath)
        let cell = tableView.dequeue(SettingsTableViewCell.self, for: indexPath)
            .make {
                if let selectedCountry = selectedCountry, selectedCountry == indexPath {
                    $0.accessoryType = .checkmark
                } else {
                    $0.accessoryType = .none
                }
            }

        return cell.set(state: .init(title: country.title, image: nil, accesoryType: nil))
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withClass: SettingsHeaderFooterView.self)
        return headerView.set(text: R.string.localizable.settingsListCountriesHeader(), style: .header)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withClass: SettingsHeaderFooterView.self)
        return footerView.set(text: R.string.localizable.settingsListCountriesFooter(), style: .footer)
    }
    
}

// MARK: - UITableViewDelegate

extension SettingsCountryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.accessoryType = .checkmark
        
        viewModel.tapSelectCountry(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }

        cell.accessoryType = .none
    }
    
}
