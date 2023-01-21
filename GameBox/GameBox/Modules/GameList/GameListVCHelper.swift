//
//  GameListVCHelper.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 15.01.2023.
//

import UIKit

class GameListVCHelper: NSObject, UITableViewDelegate{
    
    typealias RowItem = GameListCellModel
    
    private let cellIdentifier = "GameListCell"
    var gameID: Int = 0
    
    weak var tableView: UITableView?
    weak var searchBar: UISearchBar?
    weak var viewModel: GameListViewModel?
    weak var navigationController: UINavigationController?
    
    private var items: [RowItem] = []
    private var filteredItems: [RowItem] = []
    
    init(tableView: UITableView, viewModel: GameListViewModel, searchBar: UISearchBar, navigationController: UINavigationController) {
        self.tableView = tableView
        self.viewModel = viewModel
        self.searchBar = searchBar
        self.navigationController = navigationController
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
    
    func setItems(_ items: [RowItem]){
        self.items = items
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
        let item = UIContextualAction(style: .normal, title: "Favorite") {  (contextualAction, view, boolValue) in
            print("Hello")
        }
        item.image = UIImage(systemName: "heart.fill")
        item.backgroundColor = .red
        
        let swipeActions = UISwipeActionsConfiguration(actions: [item])
        
        return swipeActions
    }
}

extension GameListVCHelper: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! GameListCell
        cell.configure(with: filteredItems[indexPath.row])
        
        return cell
    }
}

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

extension GameListVCHelper {
    
    func goToDetailPage(_ gameID: Int) {
        guard let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController
        else { return }
        
        detailVC.gameID = gameID
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func goToFavoritePage(_ gameID: Int) {
        guard let favoriteVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: FavoriteViewController.self)) as? DetailViewController
        else { return }
        
        detailVC.gameID = gameID
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
