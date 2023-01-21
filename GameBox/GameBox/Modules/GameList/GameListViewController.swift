//
//  ViewController.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 14.01.2023.
//

import UIKit

class GameListViewController: UIViewController {

    @IBOutlet private weak var gameSearchBar: UISearchBar!
    @IBOutlet private weak var gameTableView: UITableView!
    @IBOutlet private weak var gameActivityIndicator: UIActivityIndicatorView!
    
    private let viewModel = GameListViewModel()
    private var tableHelper: GameListVCHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
        viewModel.didViewLoad()
    }
}

//MARK: - Extension
extension GameListViewController {
    
    private func setupUI() {
        tableHelper = .init(tableView: gameTableView, viewModel: viewModel, searchBar: gameSearchBar, navigationController: navigationController!, tabbarController: tabBarController!)
    }
    
    func setupBinding() {
        viewModel.onErrorOccured = { [weak self] message in
            let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alertController.addAction(.init(title: "Ok", style: .default))
            self?.present(alertController, animated: true)
        }
        
        viewModel.refreshItems = { [weak self] items in
            self?.tableHelper.setItems(items)
            self?.gameActivityIndicator.stopAnimating()
        }
    }
}
