//
//  GameListVCHelper.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 15.01.2023.
//

import UIKit

protocol canAccessVC: AnyObject {
    func goToNote(_ noteName: String)
}

class GameListVCHelper: NSObject, UITableViewDelegate{
    
    typealias RowItem = GameListCellModel
    
    private let cellIdentifier = "GameListCell"
    var gameID: Int = 0
    var favID = 0
    var noteName = ""
    
    weak var delegate: canAccessVC?
    
    weak var tableView: UITableView?
    weak var searchBar: UISearchBar?
    weak var viewModel: GameListViewModel?
    weak var navigationController: UINavigationController?
    weak var tabbarController: UITabBarController?
    
    private var items: [RowItem] = []
    private var filteredItems: [RowItem] = []
    
    init(tableView: UITableView, viewModel: GameListViewModel, searchBar: UISearchBar, navigationController: UINavigationController, tabbarController: UITabBarController) {
        self.tableView = tableView
        self.viewModel = viewModel
        self.searchBar = searchBar
        self.navigationController = navigationController
        self.tabbarController = tabbarController
        
        super.init()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView?.register(.init(nibName: "GameListCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
        searchBar?.delegate = self
    }
    
    func setItems(_ newItems: [RowItem]){
        //self.items.append(contentsOf: newItems)
        self.items = newItems
        filteredItems = items
        print(filteredItems.count)
        tableView?.reloadData()
        tableView?.separatorStyle = .singleLine
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gameID = filteredItems[indexPath.row].id
        goToDetailPage(gameID)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Favorite Action
        let favoriteAction = UIContextualAction(style: .normal, title: "Favorite") { [self]  (contextualAction, view, boolValue) in
            favID = filteredItems[indexPath.row].id
            goToFavoritePage(favID)
        }
        favoriteAction.image = UIImage(systemName: "heart.fill")
        favoriteAction.backgroundColor = .red
        
        // Note Action
        let noteAction = UIContextualAction(style: .normal, title: "Note") { [self]  (contextualAction, view, boolValue) in
            noteName = filteredItems[indexPath.row].name
            goToNotePage(noteName)
        }
        noteAction.image = UIImage(systemName: "book.fill")
        noteAction.backgroundColor = .blue

        let swipeActions = UISwipeActionsConfiguration(actions: [favoriteAction, noteAction])
        return swipeActions
    }
}

// --- Data Source ---
extension GameListVCHelper: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! GameListCell
        cell.configure(with: filteredItems[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if (indexPath.row == filteredItems.count - 1) && indexPath.row >= 10 {
//            viewModel?.pageNumber += 1
//            print("Viewmodel pageNumber: \(viewModel?.pageNumber ?? 10)")
//            viewModel?.didViewLoad()
//        }
    }
}

// --- Search Bar ---
extension GameListVCHelper: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filteredItems = items
        } else {
            filteredItems = items.filter{ ($0.name).localizedCaseInsensitiveContains(searchText) }
            
        }
        tableView?.reloadData()
    }
}

// --- Go Other Pages ---
extension GameListVCHelper {
    func goToDetailPage(_ gameID: Int) {
        guard let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController
        else { return }
        
        detailVC.gameID = gameID
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func goToFavoritePage(_ favID: Int) {
        viewModel?.didFavPressed(favID)
        tabbarController?.selectedIndex = 1
    }
    
    func goToNotePage(_ noteName: String) {
        delegate?.goToNote(noteName)
    }
}
