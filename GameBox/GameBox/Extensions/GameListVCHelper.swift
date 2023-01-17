//
//  GameListVCHelper.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 15.01.2023.
//

import UIKit

class GameListVCHelper: NSObject {
    
    typealias RowItem = GameListCellModel
    
    private let cellIdentifier = "GameListCell"
    
    weak var tableView: UITableView?
    weak var viewModel: GameListViewModel?
    
    private var items: [RowItem] = []
    
    init(tableView: UITableView, viewModel: GameListViewModel) {
        self.tableView = tableView
        self.viewModel = viewModel
        super.init()
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView?.register(.init(nibName: "GameListCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView?.delegate = self
        tableView?.dataSource = self
    }
    
    func setItems(_ items: [RowItem]){
        self.items = items
        tableView?.reloadData()
    }
}

//MARK: - Extensions
extension GameListVCHelper: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.itemPressed(indexPath.row)
    }
}

extension GameListVCHelper: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! GameListCell
        cell.configure(with: items[indexPath.row])
        
        return cell
    }
    
}
