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
        dropDownAPI()
    }
}

//MARK: - Extension
extension GameListViewController: canAccessVC {
    
    private func setupUI() {
        tableHelper = .init(tableView: gameTableView, viewModel: viewModel, searchBar: gameSearchBar, navigationController: navigationController!, tabbarController: tabBarController!)
        tableHelper.delegate = self
        gameSearchBar.placeholder = "What are you looking for?".localized()
        
        dropDown.anchorView = sortButton
        dropDown.dataSource = ["Released in 2022".localized(),"RPG Games".localized(),"Co-op Games".localized(),"Mac-OS Games".localized(),"Clear Filter".localized()]
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
            self?.gameTableView.isHidden = false
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

//MARK: - Dropdown Function
extension GameListViewController {
    
    func dropDownAPI() {
        dropDown.selectionAction =  { [unowned self] (index: Int, item: String) in
            switch item {
            case "Released in 2022":
                viewModel.apiFlag = 1
            case "RPG Games":
                viewModel.apiFlag = 2
            case "Co-op Games":
                viewModel.apiFlag = 3
            case "Mac-OS Games":
                viewModel.apiFlag = 4
            case "Clear Filter":
                viewModel.apiFlag = 0
            case "2022'de Yayınlananlar":
                viewModel.apiFlag = 1
            case "RPG Oyunları":
                viewModel.apiFlag = 2
            case "Co-op Oyunları":
                viewModel.apiFlag = 3
            case "Mac-OS Oyunları":
                viewModel.apiFlag = 4
            case "Filtreleri Temizle":
                viewModel.apiFlag = 0
            default:
                viewModel.apiFlag = 0
            }
            //viewModel.pageNumber = 1
            viewModel.didViewLoad()
            gameActivityIndicator.startAnimating()
            gameTableView.isHidden = true
        }
    }
}
