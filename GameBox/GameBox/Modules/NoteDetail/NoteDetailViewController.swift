//
//  NoteDetailViewController.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 22.01.2023.
//

import UIKit

class NoteDetailViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pickerView: UIPickerView!
    
    private let viewModel = NoteDetailViewModel()
    private var tableHelper: NoteDetailVCHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupBinding()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        viewModel.didViewLoad()
//    }
}

//MARK: - NoteDetailVC Extension
extension NoteDetailViewController {
    private func setupUI() {
        tableHelper = .init(pickerView: pickerView, viewModel: viewModel, searchBar: searchBar)
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

