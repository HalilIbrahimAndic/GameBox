//
//  GameListVCHelper.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 15.01.2023.
//

import UIKit

//MARK: - Protocol
protocol canAccessVC: AnyObject {
    func goToNote(_ noteName: String)
}

//MARK: - Delegator
class GameListVCHelper: NSObject, UITableViewDelegate{
    
    typealias RowItem = GameListCellModel
    
    // Flag for Detail Page
    var gameID: Int = 0
    // Flag for Favorites Page
    var favID = 0
    // Flag for Notes Page
    var noteName = ""
    // Flag for Pagination
    var paginationFlag = 0
    
    weak var delegate: canAccessVC?
    weak var tableView: UITableView?
    weak var searchBar: UISearchBar?
    weak var viewModel: GameListViewModel?
    weak var navigationController: UINavigationController?
    weak var tabbarController: UITabBarController?
    
    private var items: [RowItem] = []
    private var filteredItems: [RowItem] = []
    private let cellIdentifier = "GameListCell"
    
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
        // add newcomings to the end of the list
        if paginationFlag == 0 {
            self.items.append(contentsOf: newItems)
        } else { // triggers when new sorting requested
            self.items = newItems
        }
        
        // transfers items for search tool
        filteredItems = items
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
        let favoriteAction = UIContextualAction(style: .normal, title: "Favorite".localized()) { [self]  (contextualAction, view, boolValue) in
            favID = filteredItems[indexPath.row].id
            goToFavoritePage(favID)
        }
        favoriteAction.image = UIImage(systemName: "heart.fill")
        favoriteAction.backgroundColor = .red
        
        // Note Action
        let noteAction = UIContextualAction(style: .normal, title: "Note".localized()) { [self]  (contextualAction, view, boolValue) in
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
    
    // ---- Pagination ----
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        /*
         To prevent uncontrolled pagination, I wrote below logic with pageNumber flag.
         This controls the Home Page of the whole Application. So, I have to be careful.
         
         My Home Page contains:
            - Initial game list request
            - Search request
            - Different sort requests
            - Pagination request
         
         where, all 4 of them calls viewmodel and reloads tableview.
         Not sure if this is the correect way but I know it works :)
         
         P.S.: I intentionally avoid using global search request.
         */
        if (indexPath.row == filteredItems.count - 1) && indexPath.row >= 10 {
            viewModel?.pageNumber += 1
            viewModel?.didViewLoad()
        }
    }
    // ---- Pagination ----
}

// --- Search Bar ---
extension GameListVCHelper: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // when user deletes search text, initial page comes back.
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
