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
        
        self.title = "Favorites".localized()
        
        setupUI()
        setupBinding()
        //viewModel.didViewLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.didViewLoad()
    }
    
    @IBAction func deleteAllFavorites(_ sender: Any) {
        showAlert()
    }
    
}

//MARK: - FavoriteVC Extension
extension FavoriteViewController {
    private func setupUI() {
        tableHelper = .init(tableView: tableView, VC: self, viewModel: viewModel, navigationController: navigationController!)
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
    
    func showAlert() {
        let alertController = UIAlertController(title: "Delete All".localized(), message: "All notes will be deleted \n Are you sure?".localized(), preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Delete".localized(), style: .destructive) {
                UIAlertAction in
            self.viewModel.deleteAll()
            }
        
        alertController.addAction(deleteAction)
        alertController.addAction(.init(title: "Cancel".localized(), style: .default))
        present(alertController, animated: true)
    }
}
