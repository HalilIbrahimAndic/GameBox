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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinding()
        viewModel.didViewLoad()
    }

}

//MARK: - Extension
private extension GameListViewController {
    
    func setupBinding() {
        viewModel.onErrorOccured = { [weak self] message in
            
        }
        
        viewModel.refreshItems = { [weak self] items in
            
        }
    }
}
