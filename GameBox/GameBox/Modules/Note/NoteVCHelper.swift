//
//  NoteVCHelper.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 22.01.2023.
//

import UIKit

class NoteVCHelper: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    typealias RowItem = NoteCellModel
    private let cellIdentifier = "NoteCell"
    
    weak var tableView: UITableView?
    weak var viewModel: NoteViewModel?
    weak var navigationController: UINavigationController?
    
    private var items: [RowItem] = []
    
    init(tableView: UITableView, viewModel: NoteViewModel, navigationController: UINavigationController) {
        self.tableView = tableView
        self.viewModel = viewModel
        self.navigationController = navigationController
        super.init()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView?.register(.init(nibName: "NoteCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
    }
    
    func setItems(_ items: [RowItem]) {
        self.items = items
        tableView?.reloadData()
        tableView?.separatorStyle = .singleLine
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let gameId = items[indexPath.row].id
//
//        guard let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController
//        else { return }
//
//        detailVC.gameID = gameId
//        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! NoteCell
        cell.configure(with: items[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let item = UIContextualAction(style: .destructive, title: "Delete") { [self] (contextualAction, view, boolValue) in
            //let deleteID = items[indexPath.row].id
            //viewModel?.deleteID = deleteID
            //VC?.viewWillAppear(true)
        }
        //item.image = UIImage(systemName: "heart")
        item.backgroundColor = .red
        
        let swipeActions = UISwipeActionsConfiguration(actions: [item])
        
        return swipeActions
    }
}
