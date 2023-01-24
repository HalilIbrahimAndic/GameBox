//
//  FavoriteViewController.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 19.01.2023.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var bigHeartImage: UIImageView!
    @IBOutlet weak var heartLabel: UILabel!
    
    // instances of VM and helper
    private let viewModel = FavoriteViewModel()
    private var tableHelper: FavoriteVCHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Favorites".localized()
        setupUI()
        setupBinding()
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
        tableHelper = .init(tableView: tableView, viewModel: viewModel, navigationController: navigationController!)
        heartLabel.text = "No Favorited Game Yet".localized()
        heartLabel.alpha = 0.5
        bigHeartImage.alpha = 0.5
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
            
            // Arranges the objects for empty page
            if items.count != 0 {
                self?.bigHeartImage.isHidden = true
                self?.heartLabel.isHidden = true
                self?.tableView.isHidden = false
            } else {
                self?.bigHeartImage.isHidden = false
                self?.heartLabel.isHidden = false
                self?.tableView.isHidden = true
            }
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
