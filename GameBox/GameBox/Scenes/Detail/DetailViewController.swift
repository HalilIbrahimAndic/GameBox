//
//  DetailViewController.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 18.01.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detailViewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupUI()
//        setupBinding()
        detailViewModel.didViewLoad()
    }

}

//MARK: - Extension
private extension DetailViewController {
    
//    private func setupUI() {
//        detailTableHelper = .init(tableView: gameTableView, viewModel: viewModel, searchBar: gameSearchBar)
//    }
//
//    func setupBinding() {
//        viewModel.onErrorOccured = { [weak self] message in
//            let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
//            alertController.addAction(.init(title: "Ok", style: .default))
//            self?.present(alertController, animated: true)
//        }
//
//        viewModel.refreshItems = { [weak self] items in
//            self?.tableHelper.setItems(items)
//            self?.gameActivityIndicator.stopAnimating()
//        }
//    }
}
