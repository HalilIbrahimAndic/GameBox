//
//  ViewController.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 14.01.2023.
//

import UIKit
import DropDown
import NVActivityIndicatorView

class GameListViewController: UIViewController{

    // Outlets
    @IBOutlet private weak var gameSearchBar: UISearchBar!
    @IBOutlet private weak var gameTableView: UITableView!
    @IBOutlet weak var sortButton: UIBarButtonItem!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    
    // Instances
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

//MARK: - Delegate of ViewController-Helper
// Protocol pattern applied between VCHelper & VC
extension GameListViewController: canAccessVC {
    
    private func setupUI() {
        tableHelper = .init(tableView: gameTableView, viewModel: viewModel, searchBar: gameSearchBar, navigationController: navigationController!, tabbarController: tabBarController!)
        tableHelper.delegate = self
        gameSearchBar.placeholder = "What are you looking for?".localized()
        
        //Activity Indicator setup
        activityIndicatorView.type = NVActivityIndicatorType.pacman
        activityIndicatorView.startAnimating()
        
        // Arranges sort menu items in the beginning
        dropDown.anchorView = sortButton
        dropDown.dataSource = ["Released in 2022".localized(),"RPG Games".localized(),"Co-op Games".localized(),"Mac-OS Games".localized(),"Clear Filter".localized()]
    }
    
    // Creates binding between View-ViewModel
    func setupBinding() {
        viewModel.onErrorOccured = { [weak self] message in
            let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alertController.addAction(.init(title: "Ok", style: .default))
            self?.present(alertController, animated: true)
        }
        
        // VM reaches here
        viewModel.refreshItems = { [weak self] items in
            // what happens when new fetch arrives from ViewModel?
            self?.tableHelper.setItems(items)
            self?.activityIndicatorView.stopAnimating()
            self?.gameTableView.isHidden = false
            // resets paginations
            self?.tableHelper.paginationFlag = 0
        }
    }
    
    // Protocol Function
    // triggers when swipe action is activated for notes
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
            viewModel.pageNumber = 1
            tableHelper.paginationFlag = 1
            viewModel.didViewLoad()
            activityIndicatorView.startAnimating()
            gameTableView.isHidden = true
        }
    }
}
