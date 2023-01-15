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
private extension GameListViewController {
    
    private func setupUI() {
        tableHelper = .init(tableView: gameTableView, viewModel: viewModel)
    }
    
    func setupBinding() {
        viewModel.onErrorOccured = { [weak self] message in
            
        }
        
        viewModel.refreshItems = { [weak self] items in
            self?.tableHelper.setItems(items)
        }
    }
}
