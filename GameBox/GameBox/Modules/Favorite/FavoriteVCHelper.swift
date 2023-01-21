//
//  FavoriteVCHelper.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 21.01.2023.
//

import UIKit

class FavoriteVCHelper: NSObject {
    
    weak var tableView: UITableView?
    weak var viewModel: FavoriteViewModel?
    weak var navigationController: UINavigationController?
    
    init(tableView: UITableView, viewModel: FavoriteViewModel, navigationController: UINavigationController) {
        self.tableView = tableView
        self.viewModel = viewModel
        self.navigationController = navigationController
        super.init()
        //setupTableView()
    }
    
}
