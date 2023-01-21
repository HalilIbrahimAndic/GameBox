//
//  NoteViewController.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 19.01.2023.
//

import UIKit

class NoteViewController: UIViewController {
    
    
    @IBOutlet weak var noteTableView: UITableView!
    
    private let viewModel = NoteViewModel()
    private var tableHelper: NoteVCHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.didViewLoad()
        //viewModel.didFavDeleted()
    }
    
    @IBAction func addNote(_ sender: UIBarButtonItem) {
        print("note added")
    }
}

//MARK: - NoteVC Extension
extension NoteViewController {
    private func setupUI() {
        tableHelper = .init(tableView: noteTableView, viewModel: viewModel, navigationController: navigationController!)
    }
    
    func setupBinding() {
        viewModel.onErrorOccured = { [weak self] message in
            let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alertController.addAction(.init(title: "Ok", style: .default))
            self?.present(alertController, animated: true)
        }

        viewModel.refreshItems = { [weak self] items in
            self?.tableHelper.setItems(items)
        }
    }
}
