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
        let gameId = filteredItems[indexPath.row].id

        guard let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController
        else { return }
        
        detailVC.gameID = gameId
        detailVC.title = filteredItems[indexPath.row].name
        self.navigationController?.pushViewController(detailVC, animated: true)
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
