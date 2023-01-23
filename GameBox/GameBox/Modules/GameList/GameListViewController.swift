//
//  ViewController.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 14.01.2023.
//

import UIKit
import DropDown

class GameListViewController: UIViewController{

    @IBOutlet private weak var gameSearchBar: UISearchBar!
    @IBOutlet private weak var gameTableView: UITableView!
    @IBOutlet private weak var gameActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var sortButton: UIBarButtonItem!
    
    private let viewModel = GameListViewModel()
    private var tableHelper: GameListVCHelper!
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBinding()
        viewModel.didViewLoad()
    }
    
    
    @IBAction func sortButtonPressed(_ sender: Any) {
        dropDown.show()
        dropDown.selectionAction =  { [unowned self] (index: Int, item: String) in
            switch item {
            case "Sort by Name":
                print("opsion 1")
                //viewModel.getHighestRating()
            case "Sort by Rating":
                print("opsion 2")
                //viewModel.upcomingGames()
            case "Filter by year: 2022":
                print("opsion 3")
                //viewModel.fetchGames(page: 1)
            case "Filter by platform: Mac-OS":
                print("opsion 3")
            case "Clear filter":
                print("opsion 3")
            default:
                print("")
            }
        }
    }
    
}

//MARK: - Extension
extension GameListViewController: canAccessVC {
    
    private func setupUI() {
        tableHelper = .init(tableView: gameTableView, viewModel: viewModel, searchBar: gameSearchBar, navigationController: navigationController!, tabbarController: tabBarController!)
        tableHelper.delegate = self
        
        dropDown.anchorView = sortButton
        dropDown.dataSource = ["Top 20 Highest Rating","2022 Games","Clear Filter"]
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
    
    func goToNote(_ noteName: String){
        guard let noteDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: NoteDetailViewController.self)) as? NoteDetailViewController
                else { return }
        
        present(noteDetailVC, animated: true, completion: {
            noteDetailVC.gameNameField.text = noteName
        })
    }
}
