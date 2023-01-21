//
//  FavoriteViewController.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 19.01.2023.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let viewModel = FavoriteViewModel()
    private var tableHelper: FavoriteVCHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
        viewModel.didViewLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.didViewLoad()
    }
}

//MARK: - FavoriteVC Extension
extension FavoriteViewController {
    private func setupUI() {
        tableHelper = .init(tableView: tableView, viewModel: viewModel, navigationController: navigationController!)
    }
    
    func setupBinding() {
        viewModel.onErrorOccured = { [weak self] message in
            let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alertController.addAction(.init(title: "Ok", style: .default))
            self?.present(alertController, animated: true)
        }

        viewModel.refreshItems = { [weak self] items in
            self?.tableHelper.setItems(items)
            self?.activityIndicator.stopAnimating()
        }
    }
}
